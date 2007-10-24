package SOAP::WSDL::Port;
use strict;
use warnings;
use Class::Std::Storable;
use base qw(SOAP::WSDL::Base);

my %binding_of :ATTR(:name<binding> :default<()>);
my %address_of :ATTR(:name<address> :default<()>);

1;