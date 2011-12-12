package Pinto::Remote::Action::Unpin;

# ABSTRACT: Loosen a package that has been pinned

use Moose;

use MooseX::Types::Moose qw(Str);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action);

#------------------------------------------------------------------------------

has package  => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);


has message => (
    is      => 'ro',
    isa     => Str,
);


has tag => (
    is      => 'ro',
    isa     => Str,
);

#------------------------------------------------------------------------------

override execute => sub {
    my ($self) = @_;

    my %ua_args = (

        Content_Type => 'form-data',

        Content => [

            package   => $self->package(),
            message   => $self->message(),
            tag       => $self->tag(),
        ],
    );

    return $self->post('unpin', %ua_args);
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
