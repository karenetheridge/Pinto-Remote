package App::Pinto::Remote::Command::statistics;

# ABSTRACT: report statistics about the remote repository

use strict;
use warnings;

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub command_names { return qw( statistics stats ) }

#-------------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    return (
        [ 'format=s'  => 'Format specification (see documentation)'],
    );
}

#-------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Arguments are not allowed') if @{ $args };

    ## no critic qw(StringyEval)
    ## Double-interpolate, to expand \n, \t, etc.
    $opts->{format} = eval qq{"$opts->{format}"} if $opts->{format};

    return 1;
}

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    $self->pinto->new_batch( %{$opts} );
    $self->pinto->add_action('Statistics', %{$opts});
    my $result = $self->pinto->run_actions();

    return $result->is_success() ? 0 : 1;
}

#-------------------------------------------------------------------------------
1;

__END__

=head1 SYNOPSIS

  pinto-remote --root=URL statistics [OPTIONS]

=head1 DESCRIPTION

This command reports some statistics about the remote Pinto repository.

Note this command never changes the state of your repository.

=head1 COMMAND ARGUMENTS

None.

=head1 COMMAND OPTIONS

=over 4

=item format

This option is not functional yet.

=back
