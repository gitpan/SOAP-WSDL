#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More; # TODO: change to tests => N;
use lib '../lib';

my @modules = qw(
    SOAP::WSDL
    SOAP::WSDL::Client
    SOAP::WSDL::Serializer::SOAP11
    SOAP::WSDL::Deserializer::SOAP11
    SOAP::WSDL::Transport::HTTP
    SOAP::WSDL::Definitions
    SOAP::WSDL::Message
    SOAP::WSDL::Operation
    SOAP::WSDL::OpMessage
    SOAP::WSDL::SoapOperation
    SOAP::WSDL::Binding
    SOAP::WSDL::Port
    SOAP::WSDL::PortType
    SOAP::WSDL::Types
    SOAP::WSDL::XSD::Builtin
    SOAP::WSDL::XSD::ComplexType
    SOAP::WSDL::XSD::SimpleType
    SOAP::WSDL::XSD::Element
    SOAP::WSDL::XSD::Schema
);

plan tests => 2* scalar @modules;

for my $module (@modules)
{
    use_ok($module);
    ok($module->new(), "Object creation");
}
