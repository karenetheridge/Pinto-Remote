package App::Pinto::Remote::Command::unpin;

# ABSTRACT: loosen a package that has been pinned

use strict;
use warnings;

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    return (
        [ 'message|m=s' => 'Prepend a message to the VCS log' ],
        [ 'tag=s'       => 'Specify a VCS tag name' ],
    );
}

#-------------------------------------------------------------------------------

sub usage_desc {
    my ($self) = @_;

    my ($command) = $self->command_names();

    return "%c --repos=URL $command [OPTIONS] PACKAGE";
}

#-------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error("Must specify exactly one package") if @{ $args } != 1;

    return 1;
}

#-------------------------------------------------------------------------------

sub execute {
    my ( $self, $opts, $args ) = @_;

    $self->pinto->new_batch( %{$opts} );
    $self->pinto->add_action('Unpin', %{$opts}, package => $args->[0]);
    my $result = $self->pinto->run_actions();
    print $result->to_string();

    return $result->is_success() ? 0 : 1;
}

#-------------------------------------------------------------------------------
1;

__END__

=head1 SYNOPSIS

  pinto-remote --repos=URL unpin [OPTIONS] PACKAGE

=head1 DESCRIPTION

This command unpins a package from the index, so that the latest
version will appear in the index.  Note that local packages still have
precedence over foreign packages.

=head1 COMMAND ARGUMENTS

The arguments to this command are just package names.  For example:

  Foo::Bar

=head1 COMMAND OPTIONS

=over 4

=item --message=MESSAGE

Prepends the MESSAGE to the VCS log message that L<Pinto> generates.
This is only relevant if you are using a VCS-based storage mechanism
for L<Pinto>.

=item --tag=NAME

Instructs L<Pinto> to tag the head revision of the repository at NAME.
This is only relevant if you are using a VCS-based storage mechanism.
The syntax of the NAME depends on the type of VCS you are using.

=back
