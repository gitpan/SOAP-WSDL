package SOAP::WSDL::Message;
use strict;
use warnings;
use Class::Std::Storable;
use base qw(SOAP::WSDL::Base);

my %part_of :ATTR(:name<part> :default<[]>);

1;
