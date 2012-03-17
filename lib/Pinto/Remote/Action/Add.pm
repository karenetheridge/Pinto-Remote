package Pinto::Remote::Action::Add;

# ABSTRACT: Add a distribution to a remote repository

use Moose;

use MooseX::Types::Moose qw(Str Bool);
use Pinto::Types qw(File);

use namespace::autoclean;

#------------------------------------------------------------------------------

# VERSION

#------------------------------------------------------------------------------

extends qw(Pinto::Remote::Action);

#------------------------------------------------------------------------------

with qw(Pinto::Interface::Authorable);

#------------------------------------------------------------------------------

has archive  => (
    is       => 'ro',
    isa      => File,
    coerce   => 1,
    required => 1,
);


has norecurse => (
   is      => 'ro',
   isa     => Bool,
   default => 0,
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

            author    => $self->author(),
            archive   => [ $self->archive->stringify() ],
            norecurse => $self->norecurse(),
            message   => $self->message(),
            tag       => $self->tag(),
        ],
    );

    return $self->post('add', %ua_args);
};

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#------------------------------------------------------------------------------
1;

__END__
