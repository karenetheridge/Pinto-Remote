package Pinto::Remote;

# ABSTRACT:  Interact with a remote Pinto repository

use Moose;

use LWP::UserAgent;

use MooseX::Types::Moose qw(Str);
use Pinto::Types qw(URI AuthorID);

use Pinto::Remote::Response;

use namespace::autoclean;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

with qw(Pinto::Role::Configurable);

#-------------------------------------------------------------------------------

sub add {
  my ($self, %args) = @_;
  my $dist   = $args{dist};
  my $author = $args{author} || $self->config->author();

  my %ua_args = (
           Content_Type => 'form-data',
           Content      => [ author => $author, dist => [$dist], ],
  );

  return $self->_post('add', %ua_args);

}

#-------------------------------------------------------------------------------

sub remove {
  my ($self, %args) = @_;
  my $pkg    = $args{package};
  my $author = $args{author} || $self->config->author();

  my %ua_args = (
           Content => [ author => $author, package => $pkg, ],
  );

  return $self->_post('remove', %ua_args);
}

#-------------------------------------------------------------------------------

sub list {
  my ($self, %args) = @_;
  return $self->_post('list', ());
}

#-------------------------------------------------------------------------------

sub _post {
  my ($self, $action, %args) = @_;
  my $ua = LWP::UserAgent->new();
  my $url = $self->config->host() . "/$action";
  my $response = $ua->post($url, %args);

  return Pinto::Remote::Response->new( status  => $response->is_success(),
                                       message => $response->content() );
}

#-------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable();

#-------------------------------------------------------------------------------

1;

__END__
