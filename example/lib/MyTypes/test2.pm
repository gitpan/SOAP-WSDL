package MyTypes::test2;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %name_of :ATTR(:get<name>);
my %givenName_of :ATTR(:get<givenName>);

__PACKAGE__->_factory(
    [ qw(
        name
        givenName
    ) ],
    {
        name => \%name_of,
        givenName => \%givenName_of,
    },
    {
        name => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        givenName => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    }
);

} # end BLOCK






1;

=pod

=head1 NAME

MyTypes::test2

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complextype
test2 from the namespace urn:HelloWorld.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

 name
 givenName


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # MyTypes::test2
   name =>  $some_value, # string
   givenName =>  $some_value, # string
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

