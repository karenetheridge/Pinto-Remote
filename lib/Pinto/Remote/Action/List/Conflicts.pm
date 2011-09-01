package Pinto::Remote::Action::List::Conflicts;

# ABSTRACT: List the conflicted contents of a remote Pinto repository

use Moose;

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

has '+type' => (
    default => 'Conflicts',
);

#------------------------------------------------------------------------------
1;

__END__

