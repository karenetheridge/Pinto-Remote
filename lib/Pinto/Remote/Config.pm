package Pinto::Remote::Config;

# ABSTRACT: Internal configuration for Pinto::Remote

use Moose;

use URI;
use Pinto::Types qw(Uri);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has root => (
    is       => 'ro',
    isa      => Uri,
    coerce   => 1,
    default  => sub { URI->new('http://localhost:3000') },
);

#------------------------------------------------------------------------------

sub BUILDARGS {
    my ($class, %args) = @_;

    # Add scheme and default port, if the repository root URL doesn't
    # already have them.  Gosh, aren't we helpful :)

    $args{root} = 'http://' . $args{root}
        if defined $args{root} && $args{root} !~ m{^ https?:// }mx;

    $args{root} = $args{root} . ':3000'
        if defined $args{root} && $args{root} !~ m{ :\d+ $}mx;

    return \%args;

}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
