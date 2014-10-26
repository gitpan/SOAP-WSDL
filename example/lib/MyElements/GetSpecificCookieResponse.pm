package MyElements::GetSpecificCookieResponse;
use strict;
use Class::Std::Storable;
use SOAP::WSDL::XSD::Typelib::Element;

# atomic complexType
# <element name="GetSpecificCookieResponse"><complexType> definition
use SOAP::WSDL::XSD::Typelib::ComplexType;
use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);


my %GetSpecificCookieResult_of :ATTR(:get<GetSpecificCookieResult>);


__PACKAGE__->_factory(
    [ qw( 
    GetSpecificCookieResult
    ) ],
    { 
       GetSpecificCookieResult => \%GetSpecificCookieResult_of, 
        
    },
    {
      
        GetSpecificCookieResult => 'SOAP::WSDL::XSD::Typelib::Builtin::string',        
         
      
    }
);



sub get_xmlns { 'http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx' }

__PACKAGE__->__set_name('GetSpecificCookieResponse');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref('');

1;


__END__

=pod

=head1 NAME MyElements::GetSpecificCookieResponse

=head1 SYNOPSIS

=head1 DESCRIPTION

Type class for the XML element GetSpecificCookieResponse. 

=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY 
methods:

 GetSpecificCookieResult

=head1 Object structure

        GetSpecificCookieResult => 'SOAP::WSDL::XSD::Typelib::Builtin::string',        
        

Structure as perl hash: 

 The object structure is displayed as hash below though this is not correct.
 Complex hash elements actually are objects of their corresponding classes 
 (look for classes of the same name in your typleib).
 new() will accept a hash structure like this, but transform it to a object 
 tree.

    'GetSpecificCookieResponse'=> {
     'GetSpecificCookieResult' => $someValue,
   },


=cut

