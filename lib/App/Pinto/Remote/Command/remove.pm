package App::Pinto::Remote::Command::remove;

# ABSTRACT: remove a package from a remote Pinto repository

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
    $self->usage_error("Must specify exactly one package name") if @{ $args } != 1;
    return 1;
}

#-------------------------------------------------------------------------------

sub execute {
    my ( $self, $opts, $args ) = @_;
    my $result = $self->pinto_remote->remove( %{$opts}, package => $args->[0] );
    print $result->content();
    return not $result->status();
}

#-------------------------------------------------------------------------------
1;

__END__
