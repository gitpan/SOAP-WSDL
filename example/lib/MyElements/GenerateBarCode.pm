package MyElements::GenerateBarCode;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.webservicex.net/' }

__PACKAGE__->__set_name('GenerateBarCode');
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

my %BarCodeParam_of :ATTR(:get<BarCodeParam>);
my %BarCodeText_of :ATTR(:get<BarCodeText>);

__PACKAGE__->_factory(
    [ qw(
        BarCodeParam
        BarCodeText
    ) ],
    {
        BarCodeParam => \%BarCodeParam_of,
        BarCodeText => \%BarCodeText_of,
    },
    {
        BarCodeParam => 'MyTypes::BarCodeData',
        BarCodeText => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    }
);

} # end BLOCK

} # end of BLOCK
1;

# __END__

=pod

=head1 NAME

MyElements::GenerateBarCode

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
GenerateBarCode from the namespace http://www.webservicex.net/.

=head1 METHODS

=head2 new

 my $element = MyElements::GenerateBarCode->new($data);

Constructor. The following data structure may be passed to new():

 {
   BarCodeParam =>    { # MyTypes::BarCodeData
     Height =>  $some_value, # int
     Width =>  $some_value, # int
     Angle =>  $some_value, # int
     Ratio =>  $some_value, # int
     Module =>  $some_value, # int
     Left =>  $some_value, # int
     Top =>  $some_value, # int
     CheckSum =>  $some_value, # boolean
     FontName =>  $some_value, # string
     BarColor =>  $some_value, # string
     BGColor =>  $some_value, # string
     FontSize =>  $some_value, # float
     barcodeOption => $some_value, # BarcodeOption
     barcodeType => $some_value, # BarcodeType
     checkSumMethod => $some_value, # CheckSumMethod
     showTextPosition => $some_value, # ShowTextPosition
     BarCodeImageFormat => $some_value, # ImageFormats
   },
   BarCodeText =>  $some_value, # string
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

