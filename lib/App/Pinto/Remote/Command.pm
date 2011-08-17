package App::Pinto::Remote::Command;

# ABSTRACT: Base class for pinto-remote commands

use strict;
use warnings;

#-----------------------------------------------------------------------------

use App::Cmd::Setup -command;

#-----------------------------------------------------------------------------

# VERSION

#-----------------------------------------------------------------------------


sub pinto_remote {
  my ($self) = @_;
  return $self->app()->pinto_remote();
}

#-----------------------------------------------------------------------------
1;

__END__
