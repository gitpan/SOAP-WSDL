package FOO;
use strict; use warnings;
use Class::Std::Fast;
sub serialize_qualified { 'FOO' };

package main;
use strict;
use warnings;
use Test::More qw(no_plan);

use_ok qw(SOAP::WSDL::Serializer::XSD);

my $serializer = SOAP::WSDL::Serializer::XSD->new();

like $serializer->serialize(), qr{<SOAP-ENV:Body></SOAP-ENV:Body>}, 'empty body';
like $serializer->serialize({ body => {} }), qr{<SOAP-ENV:Body></SOAP-ENV:Body>}, 'empty body';
like $serializer->serialize({ body => [] }), qr{<SOAP-ENV:Body></SOAP-ENV:Body>}, 'empty body';
like $serializer->serialize({ header => {}, body => [] }),
    qr{<SOAP-ENV:Header></SOAP-ENV:Header><SOAP-ENV:Body></SOAP-ENV:Body>}, 'empty header and body';

like $serializer->serialize({
    header => {},
    body => [] ,
    options => {
    namespace => {
                'http://schemas.xmlsoap.org/soap/envelope/' => 'SOAP',
                'http://www.w3.org/2001/XMLSchema-instance' => 'xsi',
        }
    }})
    , qr{xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"}
    , 'namespace';

like $serializer->serialize({ header => {}, body => [ undef ] }),
    qr{<SOAP-ENV:Header></SOAP-ENV:Header><SOAP-ENV:Body></SOAP-ENV:Body>}, 'empty header and body';
like $serializer->serialize({ header => {}, body => [ undef, FOO->new() ] }),
    qr{<SOAP-ENV:Header></SOAP-ENV:Header><SOAP-ENV:Body>FOO</SOAP-ENV:Body>}, 'empty header and body';
