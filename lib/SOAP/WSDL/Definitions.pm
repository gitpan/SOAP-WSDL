package SOAP::WSDL::Definitions;
use strict;
use warnings;
use Carp;
use File::Basename;
use File::Path;
use List::Util qw(first);
use Class::Std::Storable;
use base qw(SOAP::WSDL::Base);

my %types_of    :ATTR(:name<types>      :default<[]>);
my %message_of  :ATTR(:name<message>    :default<()>);
my %portType_of :ATTR(:name<portType>   :default<()>);
my %binding_of  :ATTR(:name<binding>    :default<()>);
my %service_of  :ATTR(:name<service>    :default<()>);
my %namespace_of  :ATTR(:name<namespace> :default<()>);

# must be attr for Class::Std::Storable
my %attributes_of :ATTR();      
%attributes_of = (
    binding => \%binding_of,
    message => \%message_of,
    portType => \%portType_of,
    service => \%service_of,
);

# Function factory - we could be writing this method for all %attribute
# keys, too, but that's just C&P (eehm, Copy & Paste...)
BLOCK: {    
  no strict qw/refs/;
  foreach my $method(keys %attributes_of ) {
  
      *{ "find_$method" } = sub {
          my ($self, @args) = @_;
          return first { 
                  $_->get_targetNamespace() eq $args[0] 
                  && $_->get_name() eq $args[1] 
              }
              @{ $attributes_of{ $method }->{ ident $self } };
      };
  }
}

sub explain {
    my $self = shift;
    my $opt = shift;
    $opt->{ wsdl } ||= $self;
    $opt->{ namespace } ||= $self->get_xmlns() || {};
    my $txt = '';

    for my $service (@{ $self->get_service() }) {
        $txt .= $service->explain( $opt );
        $txt .= "\n";
    }
    return $txt;
}

sub _expand {
    my ($self, $prefix, $localname) = ($_[0], split /:/, $_[1]);
    my %ns_map = reverse %{ $self->get_xmlns() };
    return ($ns_map{ $prefix }, $localname);
}

sub to_typemap {
    my $self = shift;
    my $opt = shift;
    $opt->{ prefix } ||= q{};
    $opt->{ wsdl } ||= $self;
    $opt->{ type_prefix } ||= $opt->{ prefix };
    $opt->{ element_prefix } ||= $opt->{ prefix };
    return  join "\n",
        map { $_->to_typemap( $opt ) } @{ $service_of{ ident $self } };
}

sub create_interface {
    my $self = shift;
    my $opt = shift;
 
    my $base_path = $opt->{ base_path } 
      or croak "missing or empty argument base_path";
    $opt->{ prefix } ||= q{};
    $opt->{ type_prefix } ||= $opt->{ prefix };
    $opt->{ element_prefix } ||= $opt->{ prefix };
    $opt->{ typemap_prefix } or die 'Required argument typemap_prefix missing';
   
    mkpath $base_path;

    for my $service (@{ $service_of{ ident $self } }) {
      warn "creating typemap $opt->{ typemap_prefix }". $service->get_name() . "\n";
      $self->_create_typemap({ %{ $opt }, service => $service });
    }

    my @schema = @{ $self->first_types()->get_schema() };
    for my $type (map { @{ $_->get_type() } , @{ $_->get_element() } } @schema[1..$#schema] ) {
        warn 'creating class for '. $type->get_name() . "\n";
        $type->to_class( { %$opt, wsdl => $self } );
    }
    1;
}

sub _create_typemap {
    my $self = shift;
    my $opt = shift;
    my $service_name = $opt->{ service }->get_name();
    my $file_name = "$opt->{ base_path }/$opt->{ typemap_prefix }/$service_name.pm";
    $file_name =~s{::}{/}gms;
    my $path = dirname $file_name;
    my $name = basename $file_name;
 
    my $typemap = $opt->{ service }->to_typemap( { %{ $opt }, wsdl => $self } );
    
    my $template = <<'EOT';
package [% typemap_prefix %][% service.get_name %];
use strict;
use warnings;

my %typemap = (
[% typemap %]
[% custom_types %]
);

sub get_class { 
  my $name = join '/', @{ $_[1] };
  exists $typemap{ $name } or die "Cannot resolve $name via " . __PACKAGE__;
  return $typemap{ $name };
}

1;

__END__

EOT

    require Template;
    my $tt = Template->new(
      OUTPUT_PATH => $path,
    );
    $tt->process(\$template, { %{ $opt }, typemap => $typemap }, $name)
      or die $tt->error();

}


1;

=pod

=head1 NAME

SOAP::WSDL::Definitions - model a WSDL E<gt>definitionsE<lt> element

=head1 DESCRIPTION

=head1 METHODS

=head2 first_service get_service set_service push_service

Accessors/Mutators for accessing / setting the E<gt>serviceE<lt> child 
element(s).

=head2 find_service

Returns the service matching the namespace/localname pair passed as arguments.

 my $service = $wsdl->find_service($namespace, $localname);

=head2 first_binding get_binding set_binding push_binding

Accessors/Mutators for accessing / setting the E<gt>bindingE<lt> child 
element(s).

=head2 find_service

Returns the binding matching the namespace/localname pair passed as arguments.

 my $binding = $wsdl->find_binding($namespace, $localname);

=head2 first_portType get_portType set_portType push_portType

Accessors/Mutators for accessing / setting the E<gt>portTypeE<lt> child 
element(s).

=head2 find_portType

Returns the portType matching the namespace/localname pair passed as arguments.

 my $portType = $wsdl->find_portType($namespace, $localname);

=head2 first_message get_message set_message push_message

Accessors/Mutators for accessing / setting the E<gt>messageE<lt> child 
element(s).

=head2 find_service

Returns the message matching the namespace/localname pair passed as arguments.

 my $message = $wsdl->find_message($namespace, $localname);

=head2 first_types get_types set_types push_types

Accessors/Mutators for accessing / setting the E<gt>typesE<lt> child 
element(s).

=head2 explain

Returns a POD string describing how to call the methods of the service(s) 
described in the WSDL. 

=head2 to_typemap

Creates a typemap for use with a generated type class library.

Options:

 NAME            DESCRIPTION
 -------------------------------------------------------------------------
 prefix          Prefix to use for all classes
 type_prefix     Prefix to use for all (Complex/Simple)Type classes
 element_prefix  Prefix to use for all Element classes (with atomic types)

As some webservices tend to use globally unique type definitions, but 
locally unique elements with atomic types, type and element classes may 
be separated by specifying type_prefix and element_prefix instead of 
prefix.

The typemap is plain text which can be used as snipped for building a 
SOAP::WSDL class_resolver perl class.

Try something like this for creating typemap classes: 

 my $parser = XML::LibXML->new();
 my $handler = SOAP::WSDL::SAX::WSDLHandler->new()
 $parser->set_handler( $handler );
 
 $parser->parse_url('file:///path/to/wsdl');

 my $wsdl = $handler->get_data(); 
 my $typemap = $wsdl->to_typemap();

 print <<"EOT"
 package MyTypemap;
 my \%typemap = (
  $typemap
 );
 sub get_class { return \$typemap{\$_[1] } };
 1;
 "EOT"

=head2 create_interface 

Creates a typemap class, classes for all types and elements, and interface
classes for every service.

See L<CODE GENERATOR|CODE GENERATOR> below.

Options:

 Name             Description
 ----------------------------------------------------------------------------
 prefix           Prefix to use for types and elements. Should end with '::'.
 element_prefix   Prefix to use for element packages. Should end with '::'.
                  Must be specified if prefix is not given.
 type_prefix      Prefix to use for type packages. Should end with '::'.
                  Must be specified if prefix is not given.
 typemap_prefix   Prefix to use for type packages. Should end with '::'.
                  Mandatory.
 custom_types     A perl source code snippet defining custom types for the 
                  class resolver (typemap).
                  Must look like this:
 q{
  'path/to/my/element' => 'My::Element',
  'path/to/my/element/prop' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
  'path/to/my/element/prop2' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
 };

=head2 _expand

Expands a qualified name into a list consisting of namespace URI and 
localname by using the definition's xmlns table.

Used internally by SOAP::WSDL::* classes.

=head1 CODE GENERATOR

TODO: move somewhere else - maybe SOAP::WSDL::Client ?

SOAP::WSDL::Definitions features a code generation facility for generating 
perl classes (packages) from a WSDL definition.

The following classes are generated:

=over

=item * Typemaps

A typemap class is created for every service.

Typemaps are basically lookup classes. They allow the 
SOAP::WSDL::SAX::MessageHandler to find out which class a XML element 
in a SOAP message shoud be processed as. 

Typemaps are passed to SOAP::WSDL::Client via the class_resolver 
method.

=item * Interfaces

TODO: Implement Interface generation

Interface classes are just convenience shortcuts for accessing web 
service methods. They define a method for every web service method, 
dispatching the request to SOAP::WSDL::Client.

=item * Type and Element classes

For every top-level E<lt>elementE<gt>,  E<lt>complexTypeE<gt> and 
E<lt>simpleTypeE<gt> definition in the WSDL's schema, a perl class is 
created.

Classes for E<lt>complexTypeE<gt> and E<lt>simpleTypeE<gt> definitions 
are prefixed by the C<type_prefix> argument passed to 
L<create_interface|create_interface>, classes for E<lt>elementE<gt> 
definitions are prefixed by the C<element_prefix> passed to 
L<create_interface|create_interface>. If the specific prefixes are not 
specified, the C<prefix> argument is used instead.

If your web service is part of a bigger framework which defines types 
globally, you probably do well always using the same C<type_prefix>: 
This reduces the number of classes generated (provided types 
are re-used by more than one service).

You probably should use different element prefixes, though - 
E<lt>elementE<gt> definitions tend to be unique in the defining WSDL 
only, especially when using document/literal style/encoding.

If not, you probably want to specify just C<prefix> (and use a 
different one for every web service).

=back

=head1 LICENSE

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under 
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=cut

