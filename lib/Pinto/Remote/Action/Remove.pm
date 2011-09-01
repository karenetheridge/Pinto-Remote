package Pinto::Remote::Action::Remove;

# ABSTRACT: Remove a package from a remote repository

use Moose;
use MooseX::Types::Moose qw(Str);

extends qw(Pinto::Remote::Action);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

with qw(Pinto::Role::Authored);

#------------------------------------------------------------------------------

has dist_name  => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

#------------------------------------------------------------------------------

override execute => sub {
  my ($self) = @_;

  my $dist_name = $self->dist_name();
  my $author    = $self->author();

  my %ua_args = (
           Content => [ author => $author, dist_name => $dist_name, ],
  );

  return $self->post('remove', %ua_args);
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
