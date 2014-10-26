package SOAP::WSDL::XSD::ComplexType;
use strict;
use warnings;
use Carp;
use Class::Std::Storable;
use Scalar::Util qw(blessed);
use base qw/SOAP::WSDL::Base/;

our $VERSION='2.00_17';

my %annotation_of   :ATTR(:name<annotation> :default<()>);
my %element_of      :ATTR(:name<element>    :default<()>);
my %flavor_of       :ATTR(:name<flavor>     :default<()>);
my %base_of         :ATTR(:name<base>       :default<()>);
my %itemType_of     :ATTR(:name<itemType>   :default<()>);
my %enumeration_of  :ATTR(:name<enumeration>   :default<()>);
my %abstract_of     :ATTR(:name<abstract>   :default<()>);
my %mixed_of        :ATTR(:name<mixed>      :default<()>);      # default is false

# is set to simpleContent/complexContent
my %content_model_of    :ATTR(:name<contentModel>   :default<()>);

sub get_variety; *get_variety = \&get_flavor;

sub push_element {
    my $self = shift;
    my $element = shift;
    if ($flavor_of{ ident $self } eq 'all')
    {
        $element->set_minOccurs(0) if not defined ($element->get_minOccurs);
        $element->set_maxOccurs(1) if not defined ($element->get_maxOccurs);
    }
    elsif ($flavor_of{ ident $self } eq 'sequence')
    {
        $element->set_minOccurs(1) if not defined ($element->get_minOccurs);
        $element->set_maxOccurs(1) if not defined ($element->get_maxOccurs);
    }
    push @{ $element_of{ ident $self } }, $element;
}

sub set_restriction {
    my $self = shift;
    my $element = shift;
    $flavor_of{ ident $self } = 'restriction';
    $base_of{ ident $self } = $element->{ Value };
}


sub init {
	my $self = shift;
	my @args = @_;
	$self->SUPER::init( @args );
}

sub serialize {
    my ($self, $name, $value, $opt) = @_;

    $opt->{ indent } ||= q{};
    $opt->{ attributes } ||= [];
    my $flavor = $self->get_flavor();
    my $xml = ($opt->{ readable }) ? $opt->{ indent } : q{};    # add indentation


    if ( $opt->{ qualify } ) {
        $opt->{ attributes } = [ ' xmlns="' . $self->get_targetNamespace .'"' ];
        delete $opt->{ qualify };
    }      


    $xml .= join q{ } , "<$name" , @{ $opt->{ attributes } };
    delete $opt->{ attributes };                                # don't propagate...
    
    if ( $opt->{ autotype }) {
      my $ns = $self->get_targetNamespace();
      my $prefix = $opt->{ namespace }->{ $ns }
        || die 'No prefix found for namespace '. $ns;
      $xml .= join q{}, " type=\"$prefix:", $self->get_name(), '" '
        if ($self->get_name() );
    }
    $xml .= '>';
    $xml .= "\n" if ( $opt->{ readable } );				# add linebreak
    if ( ($flavor eq "sequence") or ($flavor eq "all") )
    {
        $opt->{ indent } .= "\t";
        for my $element (@{ $self->get_element() }) {
            # might be list - listify
            $value = [ $value ] if not ref $value eq 'ARRAY';

            for my $single_value (@{ $value }) {
    		my $element_value;
	       	if (blessed $single_value) {
                    my $method = 'get_' . $element->get_name();
		    $element_value = $single_value->$method();
                }
    		else {
                    $element_value = $single_value->{ $element->get_name() };
                }
    		$element_value = [ $element_value ]
                    if not ref $element_value eq 'ARRAY';

    		$xml .= join q{}
                  , map { $element->serialize( undef, $_, $opt ) }
	              @{ $element_value };
            }
        }
      $opt->{ indent } =~s/\t$//;
    }
    else {
      die "sorry, we just handle all and sequence types yet...";
    }
    $xml .= $opt->{ indent } if ( $opt->{ readable } ); # add indentation
    $xml .= '</' . $name . '>';
    $xml .= "\n" if ($opt->{ readable } );              # add linebreak
    return $xml;
}

1;

