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
        [ "author|a=s" => 'Your author ID (like a PAUSE ID' ]
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
    my $result = $self->pinto_remote->add( %{$opts}, dist => $args->[0] );
    print $result->message();
    return not $result->status();
}

#-------------------------------------------------------------------------------
1;

__END__
