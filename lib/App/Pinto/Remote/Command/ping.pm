package App::Pinto::Remote::Command::ping;

# ABSTRACT: check if a remote Pinto repository is alive

use strict;
use warnings;

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub command_names { return qw( ping nop ) }

#-------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Arguments are not allowed') if @{ $args };

    return 1;
}

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    $self->pinto->new_batch( %{$opts} );
    $self->pinto->add_action('Nop', %{$opts});
    my $result = $self->pinto->run_actions();
    print $result->to_string();

    return $result->is_success() ? 0 : 1;
}

#-------------------------------------------------------------------------------
1;

__END__

=head1 SYNOPSIS

  pinto-remote --repos=URL ping

=head1 DESCRIPTION

This command checks that a remote L<Pinto::Server> is alive and
currently able to get a lock on the repository.

=head1 COMMAND ARGUMENTS

None.

=head1 COMMAND OPTIONS

None.
