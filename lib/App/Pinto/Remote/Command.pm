package App::Pinto::Remote::Command;

# ABSTRACT: Base class for pinto-remote commands

use strict;
use warnings;

#-----------------------------------------------------------------------------

use App::Cmd::Setup -command;

#-----------------------------------------------------------------------------

# VERSION

#-----------------------------------------------------------------------------

sub usage_desc {
    my ($self) = @_;

    my ($command) = $self->command_names();

    return "%c --root=URL $command [OPTIONS] [ARGS]"
}

#-----------------------------------------------------------------------------

sub pinto {
    my ($self) = @_;
    return $self->app->pinto();
}

#-----------------------------------------------------------------------------
1;

__END__
