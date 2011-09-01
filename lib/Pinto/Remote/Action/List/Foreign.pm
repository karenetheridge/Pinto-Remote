package Pinto::Remote::Action::List::Foreign;

# ABSTRACT: List the foreign contents of a remote Pinto repository

use Moose;

extends qw(Pinto::Remote::Action::List);

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has '+type' => (
    default => 'Foreign',
);

#------------------------------------------------------------------------------
1;

__END__

