package SOAP::WSDL::XSD::Schema::Builtin;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use SOAP::WSDL::XSD::Schema;
use SOAP::WSDL::XSD::Builtin;
use base qw(SOAP::WSDL::XSD::Schema);

use version; our $VERSION = qv('2.00.02');

# all builtin types - add validation (e.g. content restrictions) later...
my %BUILTINS = (
    'anyURI'            => {},
    'boolean'           => {},
    'base64Binary'      => {},
    'byte'              => {},
    'date'              => {},
    'dateTime'          => {},
    'decimal'           => {},
    'double'            => {},
    'duration'          => {},
    'ENTITY'            => {},
    'float'             => {},
    'gDay'              => {},
    'gMonth'            => {},
    'gMonthDay'         => {},
    'gYearMonth'        => {},
    'gYear'             => {},
    'hexBinary'         => {},
    'ID'                => {},
    'IDREF'             => {},
    'IDREFS'            => {},
    'int'               => {},
    'integer'           => {},
    'language'          => {},
    'long'              => {},
    'negativeInteger'   => {},
    'nonPositiveInteger' => {},
    'nonNegativeInteger' => {},
    'normalizedString'  => {},
    'Name'              => {},
    'NCName'            => {},
    'NMTOKEN'           => {},
    'NOTATION'          => {},
    'positiveInteger'   => {},
    'QName'             => {},
    'short'             => {},
    'string'            => {},
    'time'              => {},
    'token'             => {},
    'unsignedByte'      => {},
    'unsignedInt'       => {},
    'unsignedLong'      => {},
    'unsignedShort'     => {},
);

sub START {
    my $self = shift;
    my @args = @_;

    while (my ($name, $value) = each %BUILTINS )
    {
        $self->push_type( SOAP::WSDL::XSD::Builtin->new({
                name => $name,
                targetNamespace => 'http://www.w3.org/2001/XMLSchema',
            } )
        );
    }
    return $self;
}

1;


=pod

=head1 NAME

SOAP:WSDL::XSD::Schema::Builtin - Provides builtin XML Schema datatypes for parsing WSDL

=head1 DESCRIPTION

Used internally by SOAP::WSDL's WSDL parser.

See <SOAP::WSDL::XSD::Typelib::Builtin|SOAP::WSDL::XSD::Typelib::Builtin> for
SOAP::WSDL::XSD's builtin XML Schema datatypes.

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2007 Martin Kutter. All rights reserved.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 672 $
 $LastChangedBy: kutterma $
 $Id: Builtin.pm 672 2008-05-16 09:37:59Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/XSD/Schema/Builtin.pm $

=cut

