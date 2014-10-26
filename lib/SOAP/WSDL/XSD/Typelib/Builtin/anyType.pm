package SOAP::WSDL::XSD::Typelib::Builtin::anyType;
use strict;
use warnings;
use Class::Std::Storable;

my %xmlns_of :ATTR(:name<xmlns> :default<()>);

# use $_[1] for performance
sub start_tag { 
    my $opt = $_[1] ||= {};
    return '<' . $opt->{name} . ' >' if $opt->{ name };
    return q{}
}

# use $_[1] for performance
sub end_tag { 
    return $_[1] && defined $_[1]->{ name }
        ? "</$_[1]->{name} >"
        : q{};
};

sub serialize_qualified :STRINGIFY {
    return $_[0]->serialize( { qualified => 1 } );
}

Class::Std::initialize();           # make :STRINGIFY overloading serializable

1;

