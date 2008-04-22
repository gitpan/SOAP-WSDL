use lib '../lib';
use lib '../example/lib';
use lib '../../SOAP-WSDL_XS/blib/lib';
use lib '../../SOAP-WSDL_XS/blib/arch';
use strict;
use Benchmark;
use Storable;
#use SOAP::WSDL::Deserializer::XSD_XS;
use SOAP::WSDL::Factory::Deserializer;
# # register for SOAP 1.1
SOAP::WSDL::Factory::Deserializer->register('1.1' => 'SOAP::WSDL::Deserializer::XSD_XS' );
SOAP::WSDL::Factory::Transport->register('http' => 'Transport');

use MyInterfaces::TestService::TestPort;
my @data = ();
my $soap = MyInterfaces::TestService::TestPort->new();

# Load all classes - XML::Compile has created everything before, too
#timethis 100, sub { $soap->ListPerson({}) };
#timethis 50, sub { push @data, $soap->ListPerson({}) };
#@data = ();
# timethis 50, sub { push @data, $soap->ListPerson({}) };

# for (1..50) { push @data, $soap->ListPerson({}) };
#print $soap->ListPerson({});
my $result = $soap->ListPerson({});

timethis 30 , sub {
    my $frozen = Storable::freeze( $result );
    my $thawed = Storable::thaw($frozen);
};
# print $thawed;


package Transport;
use Class::Std::Fast;
sub send_receive {
return <<'EOT';
<SOAP-ENV:Envelope
  xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<SOAP-ENV:Body>
<ListPersonResponse xmlns="http://www.example.org/benchmark/">
<out><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement><NewElement><PersonID><ID>1</ID></PersonID><Salutation>Salutation0</Salutation><Name>Name0</Name><GivenName>Martin</GivenName><DateOfBirth>1970-01-01</DateOfBirth><HomeAddress><Street>Street 0</Street><ZIP>00000</ZIP><City>City0</City><Country>Country0</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></HomeAddress><WorkAddress><Street>Somestreet 23</Street><ZIP>12345</ZIP><City>SomeCity</City><Country>Germany</Country><PhoneNumber>++499131123456</PhoneNumber><MobilePhoneNumber>++49150123456</MobilePhoneNumber></WorkAddress><Contracts><Contract><ContractID>100000</ContractID><ContractName>SomeContract0</ContractName></Contract><Contract><ContractID>100001</ContractID><ContractName>SomeContract1</ContractName></Contract><Contract><ContractID>100002</ContractID><ContractName>SomeContract2</ContractName></Contract><Contract><ContractID>100003</ContractID><ContractName>SomeContract3</ContractName></Contract></Contracts></NewElement></out></ListPersonResponse>};
</SOAP-ENV:Body>
</SOAP-ENV:Envelope>
EOT
}
