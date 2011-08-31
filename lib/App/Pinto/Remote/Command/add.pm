package App::Pinto::Remote::Command::add;

# ABSTRACT: add a local distribution to a remote Pinto repository

use strict;
use warnings;

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub opt_spec {

    return (
        [ "author|a=s" => 'Your author ID (like a PAUSE ID)' ]
    );
}

#-------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;
    $self->usage_error("Must specify exactly one distribution file") if @{ $args } != 1;
    return 1;
}

#-------------------------------------------------------------------------------

sub execute {
    my ( $self, $opts, $args ) = @_;

    $self->pinto_remote->new_action_batch( %{$opts} );
    $self->pinto_remote->add_action('Add', %{$opts}, dist => $args->[0]);
    my $result = $self->pinto_remote->run_actions();
    print $result->content();
    return $result->is_success() ? 0 : 1;
}

#-------------------------------------------------------------------------------
1;

__END__
