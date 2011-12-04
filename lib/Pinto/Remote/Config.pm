package Pinto::Remote::Config;

# ABSTRACT: Internal configuration for Pinto::Remote

use Moose;

use Pinto::Types qw(Uri);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

has repos => (
    is       => 'ro',
    isa      => Uri,
    coerce   => 1,
    required => 1,
);

#------------------------------------------------------------------------------

sub BUILDARGS {
    my ($class, %args) = @_;

    # Add scheme and default port, if the repository URL doesn't
    # already have them.  Gosh, aren't we helpful :)

    $args{repos} = 'http://' . $args{repos}
        if $args{repos} !~ m{^ http:// }mx;

    $args{repos} = $args{repos} . ':3000'
        if $args{repos} !~ m{ :\d+ $}mx;

    return \%args;

}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
