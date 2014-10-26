package SOAP::WSDL::Expat::WSDLParser;
use strict;
use warnings;
use Carp;
use SOAP::WSDL::TypeLookup;
use base qw(SOAP::WSDL::Expat::Base);

use version; our $VERSION = qv('2.00.03');

sub _import_children {
    my ($self, $name, $imported, $importer, $import_namespace) = @_;

    my $targetNamespace = $importer->get_targetNamespace();
    my $push_method = "push_$name";
    my $get_method = "get_$name";
    my $default_namespace = $imported->get_xmlns()->{ '#default' };

    no strict qw(refs);
    my $value_ref = $imported->$get_method();
    if ($value_ref) {

        $value_ref = [ $value_ref ] if (not ref $value_ref eq 'ARRAY');

        for (@{ $value_ref }) {
            # fixup namespace - new parent may be from different namespace
            if (defined ($default_namespace)) {
                my $xmlns = $_->get_xmlns();
                # it's a hash ref, so we can just update values
                if (! defined $xmlns->{ '#default'}) {
                    $xmlns->{ '#default' } = $default_namespace;
                }
            }
            # fixup targetNamespace, but don't override
            $_->set_targetNamespace( $import_namespace )
                if ( ($import_namespace ne $targetNamespace) && !  $_->get_targetNamespace);
            # update parent...
            $_->set_parent( $importer );

            # push elements into importing WSDL
            $importer->$push_method($_);
        }
    }
}

sub _import_namespace_definitions {
    my $self = shift;
    my $arg_ref = shift;
    my $importer = $arg_ref->{ importer };
    my $imported = $arg_ref->{ imported };

    # import namespace definitions, too
    my $importer_ns_of = $importer->get_xmlns();
    my %xmlns_of = %{ $imported->get_xmlns() };

    # it's a hash ref, we can just add to.
    # TODO: check whether prefix is already taken.
    # TODO: check wheter URI is the better key.
    while (my ($prefix, $url) = each %xmlns_of) {
        $importer_ns_of->{ $prefix } = $url;
    }
}

sub xml_schema_import {
    my $self = shift;
    my $schema = shift;
    my $parser = $self->clone();
    my %attr_of = @_;
    my $import_namespace = $attr_of{ namespace };

    if (not $attr_of{schemaLocation}) {
        warn "cannot import document for namespace >$import_namespace< without location";
        return;
    }

    if (not $self->get_uri) {
        die "cannot import document from namespace >$import_namespace< without base uri. Use >parse_uri< or >set_uri< to set one."
    }

    my $uri = URI->new_abs($attr_of{schemaLocation}, $self->get_uri() );
    my $imported = $parser->parse_uri($uri);

    # might already be imported - parse_uri just returns in this case
    return if not defined $imported;

    $self->_import_namespace_definitions({
        importer => $schema,
        imported => $imported,
    });

    for my $name ( qw(type element group attribute attributeGroup) ) {
        $self->_import_children( $name, $imported, $schema, $import_namespace);
    }
}

sub wsdl_import {
    my $self = shift;
    my $definitions = shift;
    my $parser = $self->clone();
    my %attr_of = @_;
    my $import_namespace = $attr_of{ namespace };

    if (not $attr_of{location}) {
        warn "cannot import document for namespace >$import_namespace< without location";
        return;
    }

    if (not $self->get_uri) {
        die "cannot import document from namespace >$import_namespace< without base uri. Use >parse_uri< or >set_uri< to set one."
    }

    my $uri = URI->new_abs($attr_of{location}, $self->get_uri() );

    my $imported = $parser->parse_uri($uri);

    # might already be imported - parse_uri just returns in this case
    return if not defined $imported;

    $self->_import_namespace_definitions({
        importer => $definitions,
        imported => $imported,
    });

    for my $name ( qw(types message binding portType service) ) {
        $self->_import_children( $name, $imported, $definitions, $import_namespace);
    }
}

sub _initialize {
    my ($self, $parser) = @_;

    # init object data
    $self->{ parser } = $parser;
    delete $self->{ data };

    # setup local variables for keeping temp data
    my $characters = undef;
    my $current = undef;
    my $list = [];        # node list

    # TODO skip non-XML Schema namespace tags
    $parser->setHandlers(
        Start => sub {
            my ($parser, $localname, %attrs) = @_;
            $characters = q{};

            my $action = SOAP::WSDL::TypeLookup->lookup(
                $parser->namespace($localname),
                $localname
            );

            return if not $action;

            if ($action->{ type } eq 'CLASS') {
                eval "require $action->{ class }";
                croak $@ if ($@);

                my $obj = $action->{ class }->new({ parent => $current,
                    # xmlns => { '#default' => $parser->namespace($localname) }
                    })
                  ->init( _fixup_attrs( $parser, %attrs ) );

                if ($current) {
                    # inherit namespace, but don't override
                    $obj->set_targetNamespace( $current->get_targetNamespace() )
                        if not $obj->get_targetNamespace();

                    # push on parent's element/type list
                    my $method = "push_$localname";

                    no strict qw(refs);
                    $current->$method( $obj );

                    # remember element for stepping back
                    push @{ $list }, $current;
                }
                else {
                    $self->{ data } = $obj;
                }
                # set new element (step down)
                $current = $obj;
            }
            elsif ($action->{ type } eq 'PARENT') {
                $current->init( _fixup_attrs($parser, %attrs) );
            }
            elsif ($action->{ type } eq 'METHOD') {
                my $method = $action->{ method };

                no strict qw(refs);
                # call method with
                # - default value ($action->{ value } if defined,
                #   dereferencing lists
                # - the values of the elements Attributes hash
                # TODO: add namespaces declared to attributes.
                # Expat consumes them, so we have to re-add them here.
                $current->$method( defined $action->{ value }
                    ? ref $action->{ value }
                        ? @{ $action->{ value } }
                        : ($action->{ value })
                    : _fixup_attrs($parser, %attrs)
                );
            }
            elsif ($action->{type} eq 'HANDLER') {
                my $method = $self->can($action->{method});
                $method->($self, $current, %attrs);
            }
            else {
                # TODO replace by hash lookup of known namespaces.
                my $namespace = $parser->namespace($localname) || q{};
                my $part = $namespace eq 'http://schemas.xmlsoap.org/wsdl/'
                    ? 'WSDL 1.1'
                    : 'XML Schema';

                warn "$part element <$localname> is not implemented yet"
                    if ($localname !~m{ \A (:? annotation | documentation ) \z }xms );
            }

            return;
        },

        Char => sub { $characters .= $_[1]; return;  },

        End => sub {
            my ($parser, $localname) = @_;

            my $action = SOAP::WSDL::TypeLookup->lookup(
                $parser->namespace( $localname ),
                $localname
            ) || {};

            return if not ($action->{ type });
            if ( $action->{ type } eq 'CLASS' ) {
               $current = pop @{ $list };
            }
            elsif ($action->{ type } eq 'CONTENT' ) {
                my $method = $action->{ method };

                # normalize whitespace
                $characters =~s{ ^ \s+ (.+) \s+ $ }{$1}xms;
                $characters =~s{ \s+ }{ }xmsg;

                no strict qw(refs);
                $current->$method( $characters );
            }
            return;
        }
    );
    return $parser;
}

# make attrs SAX style
sub _fixup_attrs {
    my ($parser, %attrs_of) = @_;

    my @attrs_from = map {
        $_ =
        {
            Name => $_,
            Value => $attrs_of{ $_ },
            LocalName => $_
        }
    } keys %attrs_of;

    # add xmlns: attrs. expat eats them.
    push @attrs_from, map {
        # ignore xmlns=FOO namespaces - must be XML schema
#        # Other nodes should be ignored somewhere else
#        ($_ eq '#default')
#        ? ()
#        :
        {
            Name => "xmlns:$_",
            Value => $parser->expand_ns_prefix( $_ ),
            LocalName => $_
        }
    } $parser->new_ns_prefixes();
    return @attrs_from;
}

1;


=pod

=head1 NAME

SOAP::WSDL::Expat::WSDLParser - Parse WSDL files into object trees

=head1 SYNOPSIS

 my $parser = SOAP::WSDL::Expat::WSDLParser->new();
 $parser->parse( $xml );
 my $obj = $parser->get_data();

=head1 DESCRIPTION

WSDL parser used by SOAP::WSDL.

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 Repository information

 $Id: WSDLParser.pm 677 2008-05-18 20:17:56Z kutterma $

 $LastChangedDate: 2008-05-18 22:17:56 +0200 (So, 18 Mai 2008) $
 $LastChangedRevision: 677 $
 $LastChangedBy: kutterma $

 $HeadURL: http://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Expat/WSDLParser.pm $

