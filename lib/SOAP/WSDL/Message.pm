package SOAP::WSDL::Message;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

our $VERSION = $SOAP::WSDL::VERSION;

my %part_of :ATTR(:name<part> :default<[]>);

1;
