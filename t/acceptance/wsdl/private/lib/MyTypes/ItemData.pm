package MyTypes::ItemData;
use strict;
use warnings;


our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}



# There's no variety - empty complexType
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

__PACKAGE__->_factory();





1;


=pod

=head1 NAME

MyTypes::ItemData

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ItemData from the namespace http://tempuri2.org/.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over



=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

,




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

