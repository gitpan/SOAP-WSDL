package MyTypes::ArrayOfContract;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Contract_of :ATTR(:get<Contract>);

__PACKAGE__->_factory(
    [ qw(
        Contract
    ) ],
    {
        Contract => \%Contract_of,
    },
    {
        Contract => 'MyTypes::Contract',
    }
);

} # end BLOCK






1;

=pod

=head1 NAME

MyTypes::ArrayOfContract

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complextype
ArrayOfContract from the namespace http://www.example.org/benchmark/.

=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

 Contract


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # MyTypes::ArrayOfContract
   Contract =>    { # MyTypes::Contract
     ContractID =>  $some_value, # long
     ContractName =>  $some_value, # string
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

