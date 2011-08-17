package App::Pinto::Remote::Command::add;

# ABSTRACT: add a local distribution to a remote Pinto repository

use strict;
use warnings;

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub execute {
    my ( $self, $opt, $args ) = @_;
    my $result = $self->pinto_remote->add( dist => $args->[0] );
    print $result->message();
    return not $result->status();
}

#-------------------------------------------------------------------------------
1;

__END__
