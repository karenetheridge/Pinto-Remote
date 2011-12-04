package App::Pinto::Remote::Command::list;

# ABSTRACT: list the contents of a remote Pinto repository

use strict;
use warnings;

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub command_names { return qw( list ls ) }

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

    $self->pinto->new_action_batch( %{$opts} );
    $self->pinto->add_action('List', %{$opts});
    my $result = $self->pinto->run_actions();

    return $result->is_success() ? 0 : 1;
}

#-------------------------------------------------------------------------------
1;

__END__

=head1 SYNOPSIS

  pinto-remote --repos=URL list [OPTIONS]

=head1 DESCRIPTION

This command lists the distributions and packages that are in your
repository.  You also can customize the format and content of the
output.

Note this command never changes the state of your repository.

=head1 COMMAND ARGUMENTS

None.

=head1 COMMAND OPTIONS

=over 4

=item format

Sets the format of the output using C<printf>-style placeholders.
Valid placeholders are:

  Placeholder    Meaning                     Example
  --------------------------------------------------------------
  %n             Package name                Foo::Bar
  %N             Package vname               Foo::Bar-1.2
  %v             Package version             1.2
  %x             Index status                (* = in the index )
  %m             Distribution maturity       (D = developer, R = release)
  %p             Distribution index path     /A/AU/AUTHOR/Foo-Bar-1.2.tar.gz [1]
  %P             Distribution archive path   authors\id\A\AU\AUTHOR\Foo-1.2.tar.gz [2]
  %s             Distribution origin         (L = local, F = foreign)
  %S             Distribution source         http://cpan.perl.org
  %a             Distribution author         AUTHOR
  %d             Distribution name           Foo-Bar
  %D             Distribution vname          Foo-Bar-1.2
  %w             Distribution version        1.2
  %u             Distribution url            http://cpan.perl.org/authors/id/A/AU/AUTHOR/Foo-Bar-1.2.tar.gz


  [1]: The index path is always a Unix-style path.
  [2]: The archive path is always in the native style for this OS.

You can also specify the minimum field widths and left or right
justification, using the usual notation.  For example, this is what
the default format looks like.

  %x%m%s %-38n %v %p\n

=back

=head1 TODO

In the future, we may permit the use of regular expressions or some
other syntax for narrowing the list to certain distributions and
packages.  You suggestions are welcome.
