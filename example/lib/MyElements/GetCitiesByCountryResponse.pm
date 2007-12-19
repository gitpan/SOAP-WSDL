package MyElements::GetCitiesByCountryResponse;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.webserviceX.NET' }

__PACKAGE__->__set_name('GetCitiesByCountryResponse');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %GetCitiesByCountryResult_of :ATTR(:get<GetCitiesByCountryResult>);

__PACKAGE__->_factory(
    [ qw(
        GetCitiesByCountryResult
    ) ],
    {
        GetCitiesByCountryResult => \%GetCitiesByCountryResult_of,
    },
    {
        GetCitiesByCountryResult => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    }
);

} # end BLOCK







} # end of BLOCK
1;

# __END__

=pod

=head1 NAME

MyElements::GetCitiesByCountryResponse

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
GetCitiesByCountryResponse from the namespace http://www.webserviceX.NET.

=head1 METHODS

=head2 new

 my $element = MyElements::GetCitiesByCountryResponse->new($data);

Constructor. The following data structure may be passed to new():

 {
   GetCitiesByCountryResult =>  $some_value, # string
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

