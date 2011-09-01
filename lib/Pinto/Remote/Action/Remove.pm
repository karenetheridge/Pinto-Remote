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

with qw(Pinto::Role::Authored);

#------------------------------------------------------------------------------

has dist_name  => (
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
        Content => [ author    => $self->author(),
                     dist_name => $self->dist_name(),
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
