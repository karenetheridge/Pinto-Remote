package App::Pinto::Remote;

# ABSTRACT: Command line driver for Pinto::Remote

use strict;
use warnings;

use App::Cmd::Setup -app;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub global_opt_spec {

  return (
      [ "repos|r=s"   => "URL of your Pinto repository server" ],
  );
}

#-------------------------------------------------------------------------------

=method pinto()

Returns a reference to a L<Pinto::Remote> object that has been
constructed for this application.

=cut

sub pinto {
    my ($self) = @_;

    return $self->{pinto_remote} ||= do {
        my %global_options = %{ $self->global_options() };

        $global_options{repos}
            or $self->usage_error('Must specify a repository server');

        require Pinto::Remote;
        my $pinto_remote = Pinto::Remote->new(%global_options);
    };
}


1;

__END__
