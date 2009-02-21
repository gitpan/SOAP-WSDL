package MyTypes::Attachment;
use strict;
use warnings;


our $XML_ATTRIBUTE_CLASS = 'MyTypes::Attachment::_Attachment::XmlAttr';

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Data_of :ATTR(:get<Data>);
my %Operation_of :ATTR(:get<Operation>);

__PACKAGE__->_factory(
    [ qw(        Data
        Operation

    ) ],
    {
        'Data' => \%Data_of,
        'Operation' => \%Operation_of,
    },
    {
        'Data' => 'SOAP::WSDL::XSD::Typelib::Builtin::base64Binary',
        'Operation' => 'MyTypes::AttachmentOperation',
    },
    {

        'Data' => 'Data',
        'Operation' => 'Operation',
    }
);

} # end BLOCK




package MyTypes::Attachment::_Attachment::XmlAttr;
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);

{ # BLOCK to scope variables

my %Name_of :ATTR(:get<Name>);

__PACKAGE__->_factory(
    [ qw(
        Name
    ) ],
    {

        Name => \%Name_of,
    },
    {
        Name => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    }
);

} # end BLOCK



1;


=pod

=head1 NAME

MyTypes::Attachment

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Attachment from the namespace http://tempuri2.org/.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Data


=item * Operation




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # MyTypes::Attachment
   Data =>  $some_value, # base64Binary
   Operation => $some_value, # AttachmentOperation
 },



=head2 attr

NOTE: Attribute documentation is experimental, and may be inaccurate.
See the correspondent WSDL/XML Schema if in question.

This class has additional attributes, accessibly via the C<attr()> method.

attr() returns an object of the class MyTypes::Attachment::_Attachment::XmlAttr.

The following attributes can be accessed on this object via the corresponding
get_/set_ methods:

=over

=item * Name



This attribute is of type L<SOAP::WSDL::XSD::Typelib::Builtin::string|SOAP::WSDL::XSD::Typelib::Builtin::string>.


=back




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

