package SOAP::WSDL::Operation;
use strict;
use warnings;
use Class::Std::Storable;
use base qw/SOAP::WSDL::Base/;

# this class may be used for both soap::operation and wsdl::operation.
# which one it is depends on context...

my %operation_of :ATTR(:name<operation> :default<()>);
my %input_of :ATTR(:name<input> :default<()>);
my %output_of :ATTR(:name<output> :default<()>);
my %fault_of :ATTR(:name<fault> :default<()>);
my %type_of :ATTR(:name<type> :default<()>);
my %style_of :ATTR(:name<style> :default<()>);
my %transport_of :ATTR(:name<transport> :default<()>);
my %parameterOrder_of :ATTR(:name<parameterOrder> :default<()>);

1;


