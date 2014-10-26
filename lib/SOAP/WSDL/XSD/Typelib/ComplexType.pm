#!/usr/bin/perl
package SOAP::WSDL::XSD::Typelib::ComplexType;
use strict;
use Carp;
use SOAP::WSDL::XSD::Typelib::Builtin;
use Scalar::Util qw(blessed);
use Class::Std::Storable;

use Data::Dumper;

use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anyType);

my %ELEMENTS_FROM;
my %ATTRIBUTES_OF;
my %CLASSES_OF;

# we store per-class elements.
# call as __PACKAGE__->_factory
sub _factory {
    my $class = shift;
    $ELEMENTS_FROM{ $class } = shift;
    $ATTRIBUTES_OF{ $class } = shift;
    $CLASSES_OF{ $class } = shift;

    no strict qw(refs);
    no warnings qw(redefine); 
    while (my ($name, $attribute_ref) = each %{ $ATTRIBUTES_OF{ $class } } )
    {
        my $type = $CLASSES_OF{ $class }->{ $name }
            or die "No class given for $name";

        $type->isa('UNIVERSAL')
            or eval "require $type" 
                or croak $@;

        *{ "$class\::set_$name" } = sub  {
            my ($self, $value) = @_;
            
            # we accept:
            # a) objects
            # b) scalars            
            # c) list refs
            # d) hash refs
            # e) mixed stuff of all of the above, so we have to 
            # set our element to 
            # a) value if it's an object
            # b) New object with value for simple values
            # c 1) New object with value for list values and list type
            # c 2) List ref of new objects with value for list values and non-list type
            # c + e) List ref of objects for list values (list of objects) and non-list type
            # d) New object with values passed to new for HASH references
            # 
            # Die on non-ARRAY/HASH references - if you can define semantics 
            # for GLOB references, feel free to add them.
            $attribute_ref->{ ident $self } = blessed $value
                ? $value
                : ref $value 
                    ? ref $value eq 'ARRAY' 
                        ?  $type->isa('SOAP::WSDL::XSD::Typelib::Builtin::list')
                            ? $type->new({ value => $value })
                            : [ map { 
                                    blessed($_) 
                                        ? ($_->isa('SOAP::WSDL::XSD::Typelib::Builtin::anyType'))
                                            ? $_
                                            : croak 'cannot use non-XSD object as value'
                                        : $type->new({ value => $_ })
                                } @{ $value } 
                             ]
                    : ref $value eq 'HASH' 
                        ?  $type->new( $value )
                        :  die 'Cannot use non-ARRAY/HASH as data'
                : $type->new({ value => $value });                     
        };

        *{ "$class\::add_$name" } = sub {
            my ($self, $value) = @_;
            my $ident = ident $self;
            if (not defined $value) {
                warn "attempting to add empty value to " . ref $self;
            }
            
            return $attribute_ref->{ $ident } = $value
                if not defined $attribute_ref->{ $ident };

            # listify previous value if it's no list
            $attribute_ref->{ $ident } = [  $attribute_ref->{ $ident } ]
                if not ref $attribute_ref->{ $ident } eq 'ARRAY';

            # add to list
            return push @{ $attribute_ref->{ $ident } }, $value;                                          
        };
        
        *{ "$class\::START" } = sub {
            my ($self, $ident, $args_of) = @_;
        
            # iterate over keys of arguments 
            # and call set appropriate field in clase
            map { ($ATTRIBUTES_OF{ $class }->{ $_ }) 
               ? do {
                    my $method = "set_$_";
                    $self->$method( $args_of->{ $_ } );    
               }
               : $_ =~ m{ \A              # beginning of string
                          xmlns           # xmlns 
                    }xms  
                    ? do {}
                    : do { use Data::Dumper; 
                        croak "unknown field $_ in $class. Valid fields are " 
                          . join(', ', @{ $ELEMENTS_FROM{ $class } }) . "\n"
                          . Dumper @_ };
            # TODO maybe only warn for unknown fields ?
        
            } keys %$args_of;
        };

        # this serialize method works fine for <all> and <sequence>
        # complextypes, as well as for <restriction><all> or
        # <restriction><sequence>.
        # But what about choice, group, extension ?
        #
        *{ "$class\::_serialize" } = sub {
            my $ident = ident $_[0];
            # my $class = ref $_[0];

            # return concatenated return value of serialize call of all
            # elements retrieved from get_elements expanding list refs.
            # get_elements is inlined for performance.
            return join q{} , map {     
                my $element = $ATTRIBUTES_OF{ $class }->{ $_ }->{ $ident };
                
                if (defined $element) {       
                    $element = [ $element ]
                        if not ref $element eq 'ARRAY';
                    my $name = $_;
            
                    map {
                        # serialize element elements with their own serializer
                        # but name them like they're named here.
                        if ( $_->isa( 'SOAP::WSDL::XSD::Typelib::Element' ) ) {
                                $_->serialize( { name => $name } );
                        }
                        # serialize complextype elments (of other types) with their 
                        # serializer, but add element tags around.
                        else {
                            join q{}, $_->start_tag({ name => $name })
                                , $_->serialize()
                                , $_->end_tag({ name => $name });       
                        }
                    } @{ $element }
                }
                else {
                    q{};
                }        
            } (@{ $ELEMENTS_FROM{ $class } });
        };

        *{ "$class\::serialize" } = sub {
            my ($self, $opt) = @_;
            $opt ||= {};
        
            # do we have a empty element ? 
            return $self->start_tag({ %$opt, empty => 1 })
                if not defined $ELEMENTS_FROM{ $class } or not @{ $ELEMENTS_FROM{ $class } };
            return join q{}, $self->start_tag($opt),
                    $self->_serialize(), $self->end_tag();
        }

    }
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::XSD::Typelib::ComplexType - ComplexType XML Schema definitions

=head1 Bugs and limitations

=over

=item * Incomplete API

Not all variants of XML Schema ComplexType definitions are supported yet.

Variants known to work are:

 sequence
 all
 complexContent containing sequence/all definitions
 
=item * Thread safety

SOAP::WSDL::XSD::Typelib::Builtin uses Class::Std::Storable which uses
Class::Std. Class::Std is not thread safe, so
SOAP::WSDL::XSD::Typelib::Builtin is neither.

=item * XML Schema facets

No facets are implemented yet.

=back

=head1 AUTHOR

Replace whitespace by @ in e-mail address.

 Martin Kutter E<gt>martin.kutter fen-net.deE<lt>

=head1 COPYING

This library is free software, you may distribute/modify it under the
same terms as perl itself

=cut
