package SOAP::WSDL::XSD::Typelib::Builtin::integer;
use strict;
use warnings;
use Class::Std::Storable;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::decimal);

sub as_num :NUMERIFY {
    return $_[0]->get_value();
}

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::XSD::Typelib::Builtin::integer - integer objects

=head1 LICENSE

This file is part of SOAP-WSDL. You may distribute/modify it under 
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=cut