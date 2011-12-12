package Pinto::Remote::Action::Pin;

# ABSTRACT: Force a package into the index

use Moose;

use MooseX::Types::Moose qw(Str);
use Pinto::Types qw(Vers);

use version;
use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action);

#------------------------------------------------------------------------------

has package  => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);


has version  => (
    is       => 'ro',
    isa      => Vers,
    default  => 0,
    coerce   => 1,
);


has message => (
    is      => 'ro',
    isa     => Str,
);


has tag => (
    is      => 'ro',
    isa     => Str,
);

#------------------------------------------------------------------------------

override execute => sub {
    my ($self) = @_;

    my %ua_args = (

        Content_Type => 'form-data',

        Content => [

            package   => $self->package(),
            version   => $self->version->stringify(),
            message   => $self->message(),
            tag       => $self->tag(),
        ],
    );

    return $self->post('pin', %ua_args);
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
