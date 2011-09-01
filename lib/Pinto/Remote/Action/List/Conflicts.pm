package Pinto::Remote::Action::List::Conflicts;

# ABSTRACT: List the conflicted contents of a remote Pinto repository

use Moose;

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has '+type' => (
    default => 'Conflicts',
);

#------------------------------------------------------------------------------
1;

__END__

