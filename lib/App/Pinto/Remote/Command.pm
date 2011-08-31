package App::Pinto::Remote::Command;

# ABSTRACT: Base class for pinto-remote commands

use strict;
use warnings;

#-----------------------------------------------------------------------------

use App::Cmd::Setup -command;

#-----------------------------------------------------------------------------

# VERSION

#-----------------------------------------------------------------------------

=method pinto_remote()

Returns a reference to a L<Pinto::Remote> object that has been
constructed for this command.

=cut

sub pinto_remote {
  my ($self) = @_;
  return $self->app()->pinto_remote();
}

#-----------------------------------------------------------------------------
1;

__END__
