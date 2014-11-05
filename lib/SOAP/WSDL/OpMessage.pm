package SOAP::WSDL::OpMessage;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

our $VERSION = $SOAP::WSDL::VERSION;

my %body_of         :ATTR(:name<body>           :default<[]>);
my %header_of       :ATTR(:name<header>         :default<[]>);
my %headerfault_of  :ATTR(:name<headerfault>    :default<[]>);
my %message_of      :ATTR(:name<message>        :default<()>);

1;
