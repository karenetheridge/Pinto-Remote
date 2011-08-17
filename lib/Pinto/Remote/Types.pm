package Pinto::Remote::Types;

# ABSTRACT: Moose types used within Pinto

use strict;
use warnings;

use MooseX::Types -declare => [ qw( AuthorID URI Dir File IO) ];
use MooseX::Types::Moose qw( Str ScalarRef ArrayRef FileHandle Object Int);

use URI;
use Path::Class::Dir;
use Path::Class::File;
use File::HomeDir;
use IO::String;
use IO::Handle;
use IO::File;

use namespace::autoclean;

#-----------------------------------------------------------------------------

# VERSION

#-----------------------------------------------------------------------------

subtype AuthorID,
    as Str,
    where { not m/[^A-Z0-9-]/x },
    message { "The author ($_) must be alphanumeric" };

coerce AuthorID,
    from Str,
    via  { uc $_ };

#-----------------------------------------------------------------------------

class_type URI, {class => 'URI'};

coerce URI,
    from Str,
    via { 'URI'->new($_) };

#-----------------------------------------------------------------------------

subtype Dir, as 'Path::Class::Dir';

coerce Dir,
    from Str,             via { Path::Class::Dir->new( expand_tilde($_) ) },
    from ArrayRef,        via { Path::Class::Dir->new( expand_tilde( @{$_} ) ) };

#-----------------------------------------------------------------------------

subtype File, as 'Path::Class::File';

coerce File,
    from Str,             via { Path::Class::File->new( expand_tilde($_) ) },
    from ArrayRef,        via { Path::Class::File->new( @{$_} ) };

#-----------------------------------------------------------------------------

sub expand_tilde {
    my (@paths) = @_;

    $paths[0] =~ s|\A ~ (?= \W )|File::HomeDir->my_home()|xe;

    return @paths;
}

#-----------------------------------------------------------------------------

subtype IO, as Object;

coerce IO,
    from Str,        via { my $fh = IO::File->new(); $fh->open($_);   return $fh },
    from File,       via { my $fh = IO::File->new(); $fh->open("$_"); return $fh },
    from ArrayRef,   via { IO::Handle->new_from_fd( @$_ ) },
    from ScalarRef,  via { IO::String->new( ${$_} ) };

#-----------------------------------------------------------------------------

1;

__END__

=head1 DESCRIPTION

L<Pinto::Remote::Types> provides Moose types that are used throughout
Pinto.  Many of these were stolen from various C<MooseX::Types::*>
modules on CPAN.  This module is identical to L<Pinto::Types>, but it
is duplicated here to avoid creating a dependency -- installing
L<Pinto::Remote> does not require you to have all the dependencies of
L<Pinto> iteself.

=cut
