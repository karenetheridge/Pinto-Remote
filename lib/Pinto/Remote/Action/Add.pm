package Pinto::Remote::Action::Add;

# ABSTRACT: Add a distribution to a remote repository

use Moose;
use Pinto::Types qw(File);

extends qw(Pinto::Remote::Action);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

with qw(Pinto::Role::Authored);

#------------------------------------------------------------------------------

has dist => (
    is       => 'ro',
    isa      => File,
    required => 1,
);

#------------------------------------------------------------------------------

override execute => sub {
  my ($self) = @_;

  my $dist   = $self->dist();
  my $author = $self->author();

  my %ua_args = (
           Content_Type => 'form-data',
           Content      => [ author => $author, dist => [$dist], ],
  );

  return $self->_post('add', %ua_args);
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
