
package MyElements::GetItems;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://tempuri2.org/' }

__PACKAGE__->__set_name('GetItems');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %listName_of :ATTR(:get<listName>);
my %User_of :ATTR(:get<User>);
my %query_of :ATTR(:get<query>);
my %fields_of :ATTR(:get<fields>);
my %startID_of :ATTR(:get<startID>);
my %maxItems_of :ATTR(:get<maxItems>);
my %Folder_of :ATTR(:get<Folder>);
my %viewRecursive_of :ATTR(:get<viewRecursive>);

__PACKAGE__->_factory(
    [ qw(        listName
        User
        query
        fields
        startID
        maxItems
        Folder
        viewRecursive

    ) ],
    {
        'listName' => \%listName_of,
        'User' => \%User_of,
        'query' => \%query_of,
        'fields' => \%fields_of,
        'startID' => \%startID_of,
        'maxItems' => \%maxItems_of,
        'Folder' => \%Folder_of,
        'viewRecursive' => \%viewRecursive_of,
    },
    {
        'listName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'User' => 'MyTypes::NUser',
        'query' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'fields' => 'MyTypes::ArrayOfString2',
        'startID' => 'SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt',
        'maxItems' => 'SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt',
        'Folder' => 'MyTypes::Folders',
        'viewRecursive' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    },
    {

        'listName' => 'listName',
        'User' => 'User',
        'query' => 'query',
        'fields' => 'fields',
        'startID' => 'startID',
        'maxItems' => 'maxItems',
        'Folder' => 'Folder',
        'viewRecursive' => 'viewRecursive',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

MyElements::GetItems

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
GetItems from the namespace http://tempuri2.org/.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * listName

 $element->set_listName($data);
 $element->get_listName();




=back
=item * User

 $element->set_User($data);
 $element->get_User();




=back
=item * query

 $element->set_query($data);
 $element->get_query();




=back
=item * fields

 $element->set_fields($data);
 $element->get_fields();




=back
=item * startID

 $element->set_startID($data);
 $element->get_startID();




=back
=item * maxItems

 $element->set_maxItems($data);
 $element->get_maxItems();




=back
=item * Folder

 $element->set_Folder($data);
 $element->get_Folder();




=back
=item * viewRecursive

 $element->set_viewRecursive($data);
 $element->get_viewRecursive();




=back


=head1 METHODS

=head2 new

 my $element = MyElements::GetItems->new($data);

Constructor. The following data structure may be passed to new():

 {
   listName =>  $some_value, # string
   User =>  { value => $some_value },
   query =>  $some_value, # string
   fields =>  { # MyTypes::ArrayOfString2
     string =>  $some_value, # string
   },
   startID =>  $some_value, # unsignedInt
   maxItems =>  $some_value, # unsignedInt
   Folder =>  { # MyTypes::Folders
     SubFolder =>  $some_value, # string
   },
   viewRecursive =>  $some_value, # boolean
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

