package Pinto::Remote::Action::Remove;

# ABSTRACT: Remove a package from a remote repository

use Moose;
use MooseX::Types::Moose qw(Str);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action);

#------------------------------------------------------------------------------

with qw(Pinto::Interface::Authorable);

#------------------------------------------------------------------------------

has path     => (
    is       => 'ro',
    isa      => Str,
    required => 1,
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

            author    => $self->author(),
            path      => $self->path(),
            message   => $self->message(),
            tag       => $self->tag(),
        ],
    );

    return $self->post('remove', %ua_args);
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
