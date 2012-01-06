package App::Pinto::Remote;

# ABSTRACT: Command line driver for Pinto::Remote

use strict;
use warnings;

use Class::Load qw();
use App::Cmd::Setup -app;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub global_opt_spec {

  return (
      [ 'root|r=s'   => 'Root URL of your Pinto repository' ],
  );
}

#-------------------------------------------------------------------------------

=method pinto()

Returns a reference to a L<Pinto::Remote> object that has been
constructed for this application.

=cut

sub pinto {
    my ($self) = @_;

    return $self->{pinto} ||= do {
        my %global_options = %{ $self->global_options() };

        $global_options{root} ||= $ENV{PINTO_REPOSITORY_ROOT}
            || $self->usage_error('Must specify a repository root URL');

        my $pinto_class = $self->pinto_class();
        Class::Load::load_class($pinto_class);
        my $pinto = $pinto_class->new(%global_options);
    };
}

#-------------------------------------------------------------------------------

sub pinto_class {  return 'Pinto::Remote' }

#-------------------------------------------------------------------------------

1;

__END__
