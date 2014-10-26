use strict;
use lib '../lib';
use Test::More tests => 4;
use SOAP::WSDL;
use Cwd;
use Data::Dumper;
use File::Basename;

print "# Using SOAP::WSDL Version $SOAP::WSDL::VERSION\n";

my $name = '02_port';

# chdir to my location
my $soap = undef;

my $path = cwd;

$path =~s{(/t)?/SOAP/WSDL}{}xms;

my $url = 'http://127.0.0.1/testPort';


ok( $soap = SOAP::WSDL->new(
	wsdl => 'file:///' . $path . '/t/acceptance/wsdl/' . $name . '.wsdl'
) );

ok $soap->wsdlinit( url => $url );
ok $soap->servicename('testService');
ok $soap->portname('testPort');
