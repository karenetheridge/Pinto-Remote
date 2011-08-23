package Pinto::Remote;

# ABSTRACT:  Interact with a remote Pinto repository

use Moose;

use Carp;
use LWP::UserAgent;
use English qw(-no_match_vars);

use MooseX::Types::Moose qw(Str);
use Pinto::Types qw(URI AuthorID);

use Pinto::Remote::Response;

use namespace::autoclean;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

has host => (
    is       => 'ro',
    isa      => URI,
    coerce   => 1,
    required => 1,
);

has author => (
    is         => 'ro',
    isa        => AuthorID,
    coerce     => 1,
    lazy_build => 1,
);

#------------------------------------------------------------------------------

sub _build_author {                                  ## no critic (FinalReturn)

    # Look at typical environment variables
    for my $var ( qw(USERNAME USER LOGNAME) ) {
        return uc $ENV{$var} if $ENV{$var};
    }

    # Try using pwent.  Probably only works on *nix
    if (my $name = getpwuid($REAL_USER_ID)) {
        return uc $name;
    }

    # Otherwise, we are hosed!
    croak 'Unable to determine your user name';

}

#------------------------------------------------------------------------------

=method add( dist => 'SomeDist-1.2.tar.gz' )

Adds the specified distribution to the remote Pinto repository.
Returns a L<Pinto::Remote::Response> that contains the overall status
and output from the server.

=cut

sub add {
  my ($self, %args) = @_;
  my $dist   = $args{dist};
  my $author = $args{author} || $self->author();

  my %ua_args = (
           Content_Type => 'form-data',
           Content      => [ author => $author, dist => [$dist], ],
  );

  return $self->_post('add', %ua_args);

}

#-------------------------------------------------------------------------------

=method remove( package => 'Some::Package' )

Removes the specified package from the remote Pinto repository.
Returns a L<Pinto::Remote::Response> that contains the overall status
and output from the server.

=cut

sub remove {
  my ($self, %args) = @_;
  my $pkg    = $args{package};
  my $author = $args{author} || $self->author();

  my %ua_args = (
           Content => [ author => $author, package => $pkg, ],
  );

  return $self->_post('remove', %ua_args);
}

#-------------------------------------------------------------------------------

=method list()

Returns a L<Pinto::Remote::Response> that contains a list of all the
packages and distributions that are currently indexed in the remote
repository.

=cut


sub list {
  my ($self, %args) = @_;
  my $type = $args{type} || 'All';

  my %ua_args = (
           Content => [ type => $type, ],
  );

  return $self->_post('list', %ua_args);
}

#-------------------------------------------------------------------------------

sub _post {
  my ($self, $action_name, %args) = @_;
  my $ua  = LWP::UserAgent->new();
  my $url = $self->host() . "/action/$action_name";
  my $response = $ua->post($url, %args);

  return Pinto::Remote::Response->new( status  => $response->is_success(),
                                       content => $response->content() );
}

#-------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-------------------------------------------------------------------------------

1;

__END__
