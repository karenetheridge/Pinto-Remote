package App::Pinto::Remote::Command;

# ABSTRACT: Base class for pinto-remote commands

use strict;
use warnings;

#-----------------------------------------------------------------------------

use App::Cmd::Setup -command;

#-----------------------------------------------------------------------------

# VERSION

#-----------------------------------------------------------------------------

=method pinto_remote( $options )

Returns a reference to a L<Pinto::Remote> object that has been
constructed for this command.

=cut

sub pinto_remote {
  my ($self, $options) = @_;
  return $self->app()->pinto_remote($options);
}

#-----------------------------------------------------------------------------
1;

__END__
