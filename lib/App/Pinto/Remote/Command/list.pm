package App::Pinto::Remote::Command::list;

# ABSTRACT: list the contents of a remote Pinto repository

use strict;
use warnings;

use Readonly;
use List::MoreUtils qw(none);

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------
# TODO: refactor constants to the Common dist.

Readonly my @LIST_TYPES => qw(local foreign conflicts all);
Readonly my $LIST_TYPES_STRING => join ' | ', sort @LIST_TYPES;
Readonly my $DEFAULT_LIST_TYPE => 'all';

#-------------------------------------------------------------------------------

sub opt_spec {

    return (
        [ 'type=s'  => "One of: ( $LIST_TYPES_STRING )"],
    );
}

#-------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Arguments are not allowed') if @{ $args };

    $opts->{type} ||= $DEFAULT_LIST_TYPE;
    $self->usage_error('Invalid type') if none { $opts->{type} eq $_ } @LIST_TYPES;

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
