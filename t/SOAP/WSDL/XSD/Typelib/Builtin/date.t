use Test::More tests => 31;
use strict;
use warnings;
#use Carp qw(cluck);
#
#$SIG{__WARN__} = sub { cluck @_ };
#use warnings;
use lib '../lib';
use Date::Format;
use Date::Parse;
use_ok('SOAP::WSDL::XSD::Typelib::Builtin::date');
my $obj;

sub timezone {
    my @time = map { defined $_ ? $_ : 0 } strptime shift;
    my $tz = strftime('%z', @time);
    substr $tz, -2, 0, ':';
    return $tz;
}

my %dates = (
    '2007/12/31' => '2007-12-31',
    '2007:08:31' => '2007-08-31',
    '30 Aug 2007' => '2007-08-30',
);

my %localized_date_of = (
    '2007-12-31T00:00:00.0000000+0000' => '2007-12-31+00:00',
    '2007-12-31T00:00:00.0000000+0130' => '2007-12-31+01:30',
    '2007-12-31T00:00:00.0000000+0200' => '2007-12-31+02:00',
    '2007-12-31T00:00:00.0000000+0300' => '2007-12-31+03:00',
    '2007-12-31T00:00:00.0000000+0400' => '2007-12-31+04:00',
    '2007-12-31T00:00:00.0000000+0500' => '2007-12-31+05:00',
    '2007-12-31T00:00:00.0000000+0600' => '2007-12-31+06:00',
    '2007-12-31T00:00:00.0000000+0700' => '2007-12-31+07:00',
    '2007-12-31T00:00:00.0000000+0800' => '2007-12-31+08:00',
    '2007-12-31T00:00:00.0000000+0900' => '2007-12-31+09:00',
    '2007-12-31T00:00:00.0000000+1000' => '2007-12-31+10:00',
    '2007-12-31T00:00:00.0000000+1100' => '2007-12-31+11:00',
    '2007-12-31T00:00:00.0000000+1200' => '2007-12-31+12:00',
    '2007-12-31T00:00:00.0000000-0100' => '2007-12-31-01:00',
    '2007-12-31T00:00:00.0000000-0200' => '2007-12-31-02:00',
    '2007-12-31T00:00:00.0000000-0300' => '2007-12-31-03:00',
    '2007-12-31T00:00:00.0000000-0400' => '2007-12-31-04:00',
    '2007-12-31T00:00:00.0000000-0500' => '2007-12-31-05:00',
    '2007-12-31T00:00:00.0000000-0600' => '2007-12-31-06:00',
    '2007-12-31T00:00:00.0000000-0700' => '2007-12-31-07:00',
    '2007-12-31T00:00:00.0000000-0800' => '2007-12-31-08:00',
    '2007-12-31T00:00:00.0000000-0900' => '2007-12-31-09:00',
    '2007-12-31T00:00:00.0000000-1000' => '2007-12-31-10:00',
    '2007-12-31T00:00:00.0000000-1100' => '2007-12-31-11:00',
    '2007-12-31T00:00:00.0000000-1200' => '2007-12-31-12:00',


);

$obj = SOAP::WSDL::XSD::Typelib::Builtin::date->new();
$obj = SOAP::WSDL::XSD::Typelib::Builtin::date->new({});
$obj = SOAP::WSDL::XSD::Typelib::Builtin::date->new({
    value => '2007-12-31'
});

while (my ($date, $converted) = each %localized_date_of ) {

    $obj = SOAP::WSDL::XSD::Typelib::Builtin::date->new();
    $obj->set_value( $date );

    is $obj->get_value() , $converted , 'conversion';
}

while (my ($date, $converted) = each %dates ) {

    $obj = SOAP::WSDL::XSD::Typelib::Builtin::date->new();
    $obj->set_value( $date );

    is $obj->get_value() , $converted . timezone($date), 'conversion';
}

$obj->set_value( '2037-12-31+12:00' );
is $obj->get_value() , '2037-12-31+12:00', 'no conversion on match';

$obj->set_value('2007-12-31+01:00');
is $obj->get_value(), '2007-12-31+01:00';
