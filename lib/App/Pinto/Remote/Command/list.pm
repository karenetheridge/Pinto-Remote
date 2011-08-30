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

    # TODO: Use the "one_of" feature of Getopt::Long::Descriptive to
    # define and validate the different types of lists.

    return (

        [ 'type=s'  => "One of: ( $PINTO_LIST_TYPES_STRING )"],
    );
}

#-------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Arguments are not allowed') if @{ $args };

    $opts->{type} ||= $PINTO_DEFAULT_LIST_TYPE;
    $self->usage_error('Invalid type') if none { $opts->{type} eq $_ } @PINTO_LIST_TYPES;

    return 1;
}

#-------------------------------------------------------------------------------

sub execute {
    my ( $self, $opts, $args ) = @_;
    my $result = $self->pinto_remote()->list( %{$opts} );
    print $result->content();
    return not $result->status();
}

#-------------------------------------------------------------------------------
1;

__END__
