package SOAP::WSDL::TypeLookup;

my %TYPES = (
    # wsdl:
    'http://schemas.xmlsoap.org/wsdl/' => {
        binding => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Binding',
        },
        definitions => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Definitions',
        },
        portType => {
            type => 'CLASS',
            class => 'SOAP::WSDL::PortType',
        },
        message => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Message',
        },
        part => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Part',
        },
        service => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Service',
        },
        port => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Port',
        },
        operation => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Operation',
        },
        input => {
            type => 'CLASS',
            class => 'SOAP::WSDL::OpMessage',
        },
        output => {
            type => 'CLASS',
            class => 'SOAP::WSDL::OpMessage',
        },
        fault => {
            type => 'CLASS',
            class => 'SOAP::WSDL::OpMessage',
        },
        types => {
            type => 'CLASS',
            class => 'SOAP::WSDL::Types',
        },
        documentation => {
            type => 'CONTENT',
            method => 'set_documentation',
        }
    },
    # soap:
    'http://schemas.xmlsoap.org/wsdl/soap/' => {
        operation => {
            type => 'CLASS',
            class => 'SOAP::WSDL::SoapOperation',
        },
        binding => {
            type => 'PARENT',
        },
        body => {
            type => 'PARENT',
        },
        address => {
            type => 'PARENT',
        }
    },
    'http://www.w3.org/2001/XMLSchema' => {
        schema => {
            type => 'CLASS',
            class => 'SOAP::WSDL::XSD::Schema',
        },
        attribute => {
            type => 'SKIP'      # not implemented yet
        },
        attributeGroup => {
            type => 'SKIP',     # not implemented yet
        },
        key => {
            type => 'SKIP',     # not implemented yet
        },
        keyref => {
            type => 'SKIP',     # not implemented yet
        },
        unique => {
            type => 'SKIP',     # not implemented yet
        },
        notation => {
            type => 'SKIP',     # not implemented yet
        },      
        annotation => {
            type => 'SKIP',     # not implemented yet
        },
        appinfo => {
            type => 'SKIP',     # not implemented yet
        },
        description => {
            type => 'SKIP',     # not implemented yet
        },
        element => {
            type => 'CLASS',
            class => 'SOAP::WSDL::XSD::Element',
        },
        simpleType => {
            type => 'CLASS',
            class => 'SOAP::WSDL::XSD::SimpleType',
        },
        complexType => {
            type => 'CLASS',
            class => 'SOAP::WSDL::XSD::ComplexType',
        },
        simpleContent => {
            type => 'METHOD',
            method => 'set_contentModel',
            value => 'simpleContent'
        },
        complexContent => {
            type => 'METHOD',
            method => 'set_contentModel',
            value => 'complexContent'
        },
        restriction => {
            type => 'METHOD',
            method => 'set_restriction',
        },
        list => {
            type => 'METHOD',
            method => 'set_list',
        },
	union => {
            type => 'METHOD',
            method => 'set_union',
        },
        enumeration => {
            type => 'METHOD',
            method => 'push_enumeration',
        },
        group => {
            type => 'METHOD',
            method => 'set_flavor',
            value => 'all',
        },
	all => {
            type => 'METHOD',
            method => 'set_flavor',
            value => 'all',
        },
        choice => {
            type => 'METHOD',
            method => 'set_flavor',
            value => 'choice',
        },
        sequence => {
            type => 'METHOD',
            method => 'set_flavor',
            value => 'sequence',
        },
    },
);


sub lookup {
	my $self = shift;
	my $namespace = shift || 'http://schemas.xmlsoap.org/wsdl/';
	my $name = shift;
	return $TYPES{ $namespace }->{ $name };
}
