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

    $self->pinto->new_batch( %{$opts} );
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

  Placeholder    Meaning
  -----------------------------------------------------------------------------
  %n             Package name
  %N             Package name-version
  %v             Package version
  %x             Index status:                   (@) = is latest
  %y             Pin status:                     (+) = is pinned
  %m             Distribution maturity:          (d) = developer, (r) = release
  %p             Distribution index path [1]
  %P             Distribution physical path [2]
  %s             Distribution origin:            (l) = local, (f) = foreign
  %S             Distribution source repository
  %a             Distribution author
  %d             Distribution name
  %D             Distribution name-version
  %w             Distribution version
  %u             Distribution url
  %%             A literal '%'


  [1]: The index path is always a Unix-style path fragment, as it
       appears in the 02packages.details.txt index file.

  [2]: The physical path is always in the native style for this OS,
       and is relative to the root directory of the repository.

You can also specify the minimum field widths and left or right
justification, using the usual notation.  For example, this is what
the default format looks like.

  %x%m%s %-38n %v %p\n

=back

=head1 TO DO

In the future, we may permit the use of regular expressions or some
other syntax for narrowing the list to certain distributions and
packages.  You suggestions are welcome.
