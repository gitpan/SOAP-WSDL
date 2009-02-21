package MyTypes::ItemCreateData;
use strict;
use warnings;


our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}


use base qw(MyTypes::ItemData);
# Variety: sequence
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Folder_of :ATTR(:get<Folder>);
my %Author_of :ATTR(:get<Author>);
my %GroupID_of :ATTR(:get<GroupID>);

__PACKAGE__->_factory(
    [ qw(        Folder
        Author
        GroupID

    ) ],
    {
        'Folder' => \%Folder_of,
        'Author' => \%Author_of,
        'GroupID' => \%GroupID_of,
    },
    {
        'Folder' => 'MyTypes::Folders',
        'Author' => 'MyTypes::NUser',
        'GroupID' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
    },
    {

        'Folder' => 'Folder',
        'Author' => 'Author',
        'GroupID' => 'GroupID',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

MyTypes::ItemCreateData

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ItemCreateData from the namespace http://tempuri2.org/.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Folder


=item * Author


=item * GroupID




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # MyTypes::ItemCreateData
   Folder =>  { # MyTypes::Folders
     SubFolder =>  $some_value, # string
   },
   Author =>  { value => $some_value },
   GroupID =>  $some_value, # int
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

