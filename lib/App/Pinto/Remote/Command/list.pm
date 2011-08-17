package App::Pinto::Remote::Command::list;

# ABSTRACT: list the contents of a remote Pinto repository

use strict;
use warnings;

use base qw(App::Pinto::Remote::Command);

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------


sub execute {
    my ( $self, $opts, $args ) = @_;
    my $result = $self->pinto_remote( $opts )->list();
    print $result->message();
    return not $result->status();
}

#-------------------------------------------------------------------------------
1;

__END__
