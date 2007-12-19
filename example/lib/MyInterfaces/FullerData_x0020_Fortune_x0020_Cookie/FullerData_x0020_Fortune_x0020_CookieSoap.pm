package MyInterfaces::FullerData_x0020_Fortune_x0020_Cookie::FullerData_x0020_Fortune_x0020_CookieSoap;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);

# only load if it hasn't been loaded before
require MyTypemaps::FullerData_x0020_Fortune_x0020_Cookie
    if not MyTypemaps::FullerData_x0020_Fortune_x0020_Cookie->can('get_class');

sub START {
    $_[0]->set_proxy('http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx') if not $_[2]->{proxy};
    $_[0]->set_class_resolver('MyTypemaps::FullerData_x0020_Fortune_x0020_Cookie')
        if not $_[2]->{class_resolver};
}

sub readNodeCount {
    my ($self, $body, $header) = @_;
    die "readNodeCount must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'readNodeCount',
        soap_action => 'http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx/readNodeCount',
        style => 'document',
        body => {
            
           'use' => 'literal',
            namespace => '',
            encodingStyle => '',
            parts => [qw( MyElements::readNodeCount )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}

sub GetFortuneCookie {
    my ($self, $body, $header) = @_;
    die "GetFortuneCookie must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'GetFortuneCookie',
        soap_action => 'http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx/GetFortuneCookie',
        style => 'document',
        body => {
            
           'use' => 'literal',
            namespace => '',
            encodingStyle => '',
            parts => [qw( MyElements::GetFortuneCookie )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}

sub CountCookies {
    my ($self, $body, $header) = @_;
    die "CountCookies must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'CountCookies',
        soap_action => 'http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx/CountCookies',
        style => 'document',
        body => {
            
           'use' => 'literal',
            namespace => '',
            encodingStyle => '',
            parts => [qw( MyElements::CountCookies )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}

sub GetSpecificCookie {
    my ($self, $body, $header) = @_;
    die "GetSpecificCookie must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'GetSpecificCookie',
        soap_action => 'http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx/GetSpecificCookie',
        style => 'document',
        body => {
            
           'use' => 'literal',
            namespace => '',
            encodingStyle => '',
            parts => [qw( MyElements::GetSpecificCookie )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}



1;



__END__

=pod

=head1 NAME


MyInterfaces::FullerData_x0020_Fortune_x0020_Cookie::FullerData_x0020_Fortune_x0020_CookieSoap - SOAP Interface for the FullerData_x0020_Fortune_x0020_Cookie Web Service

=head1 SYNOPSIS

 use MyInterfaces::FullerData_x0020_Fortune_x0020_Cookie::FullerData_x0020_Fortune_x0020_CookieSoap;
 my $interface = MyInterfaces::FullerData_x0020_Fortune_x0020_Cookie::FullerData_x0020_Fortune_x0020_CookieSoap->new();
 
 my $response;
 $response = $interface->readNodeCount();
 $response = $interface->GetFortuneCookie();
 $response = $interface->CountCookies();
 $response = $interface->GetSpecificCookie();

 

=head1 DESCRIPTION

SOAP Interface for the FullerData_x0020_Fortune_x0020_Cookie web service
located at http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx.

=head1 SERVICE FullerData_x0020_Fortune_x0020_Cookie

Simple XML-based fortune cookie

=head2 Port FullerData_x0020_Fortune_x0020_CookieSoap



=head1 METHODS

=head2 General methods

=head3 new

Constructor.

All arguments are forwarded to L<SOAP::WSDL::Client|SOAP::WSDL::Client>.

=head2 SOAP Service methods

Method synopsis is displayed with hash refs as parameters.

The commented class names in the method's parameters denote that objects
of the corresponding class can be passed instead of the marked hash ref.

You may pass any combination of objects, hash and list refs to these
methods, as long as you meet the structure.



=head3 readNodeCount

Display the number of nodes specified in fortune XML document

 $interface->readNodeCount(,,
 );
 
=head3 GetFortuneCookie

Get a random fortune cookie from the XML document

 $interface->GetFortuneCookie(,,
 );
 
=head3 CountCookies

Count the actual number of nodes in the XML document of fortunes

 $interface->CountCookies(,,
 );
 
=head3 GetSpecificCookie

Get a specific cookie by the XML node number

 $interface->GetSpecificCookie(  {
    index =>  $some_value, # int
  },,
 );
 


=head1 AUTHOR

Generated by SOAP::WSDL on Sun Dec 16 19:58:30 2007

=pod