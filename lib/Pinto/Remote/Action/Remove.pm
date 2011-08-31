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

has package  => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

#------------------------------------------------------------------------------

override execute => sub {
  my ($self) = @_;

  my $pkg    = $self->package();
  my $author = $self->author();

  my %ua_args = (
           Content => [ author => $author, package => $pkg, ],
  );

  return $self->_post('remove', %ua_args);
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
