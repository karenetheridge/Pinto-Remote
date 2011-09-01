package App::Pinto::Remote::Command::list;

# ABSTRACT: list the contents of a remote Pinto repository

use strict;
use warnings;

use Pinto::Constants qw(:list);

use List::MoreUtils qw(none);

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    # TODO: Use the "one_of" feature of Getopt::Long::Descriptive to
    # define and validate the different types of lists.

    return ( $self->SUPER::opt_spec(),

        [ 'type=s'  => "One of: ( $PINTO_LIST_TYPES_STRING )"],
    );
}

#-------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->SUPER::validate_args($opts, $args);

    $self->usage_error('Arguments are not allowed') if @{ $args };

    $opts->{type} ||= $PINTO_DEFAULT_LIST_TYPE;
    $self->usage_error('Invalid type') if none { $opts->{type} eq $_ } @PINTO_LIST_TYPES;

    return 1;
}

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    $self->pinto->new_action_batch( %{$opts} );
    my $list_class = 'List::' . ucfirst $opts->{type};
    $self->pinto->add_action($list_class, %{$opts});
    my $result = $self->pinto->run_actions();

    return $result->is_success() ? 0 : 1;
}

#-------------------------------------------------------------------------------
1;

__END__

=head1 SYNOPSIS

  pinto-remote --repos=URL list [OPTIONS]

=head1 DESCRIPTION

This command lists the distributions and packages that are indexed in
your repository.  You can see all of them, only foreign ones, only
local ones, or only the local ones that conflict with a foreign one.

Note this command never changes the state of your repository.

=head1 COMMAND ARGUMENTS

None.

=head1 COMMAND OPTIONS

=over 4

=item --type=(all | local | foreign | conflicts)

Specifies what type of packages and distributions to list. In all
cases, only packages and distributions that are indexed will appear.
If you have outdated distributions in your repository, they will never
appear be listed.  Valid types are:

=over 8

=item all

Lists all the packages and distributions.  This is the default type.

=item local

Lists only the local packages and distributions that were added with
the C<add> command.

=item foreign

Lists only the foreign packages and distributions that were pulled in
with the C<update> command.

=item conflicts

Lists only the local distributions that conflict with a foreign
distribution.  In other words, the local and foreign distribution
contain a package with the same name.

=back

=back
