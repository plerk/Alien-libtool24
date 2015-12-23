package My::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );
use File::chdir;
use Capture::Tiny qw( capture );
use File::Spec;
use File::Copy qw( copy );

sub new
{
  my($class, %args) = @_;
  
  #$args{alien_build_commands}   = [ '%c --prefix=%s', 'make' ];
  #$args{alien_install_commands} = [ 'make install' ];
  #
  #if($^O eq 'MSWin32')
  #{
  #  push @{ $args{alien_install_commands} }, [ '%x', '-I../../inc', '-MMy::ModuleBuild', -e => '_install_hunspell_win32(@ARGV)', '%s' ];
  #}

  $args{alien_bin_requires} = {
    'Alien::m4' => '0.04',
  };  
  $args{alien_repository} = {
    protocol => 'http',
    host     => 'ftp.gnu.org',
    location => "/gnu/libtool/",
    pattern  => qr{^libtool-2\.4\..*\.tar\.gz$},
  };

  my $self = $class->SUPER::new(%args);
  
  $self;
}

sub main::_install_hunspell_win32
{
  my($path) = @_;
  foreach my $script (qw( libtool libtoolize ))
  {
    do {
      my $from = "../../win32/$script.pl";
      my $to   = "$path/bin/$script.pl";
      print "copy $from => $to\n";
      copy($from => $to);
    };
    
    do {
      my $pl = "$path/bin/$script.pl";
      print "pl2bat $path/bin/$script.pl";
      __PACKAGE__->pl2bat(
        in     => $pl,
        update => 1,
      );
    };
  }
}

sub alien_check_installed_version
{
  # always build from source on windows
  # because the one that is in the path is
  # probably won't work anyway
  return if $^O eq 'MSWin32';
  
  # probe for the version and see if it is in the range
  # of 2.4.x
  my($out, $err) = capture { system 'libtool', '--version' };
  $out =~ /libtool \(GNU libtool\) (2.4.[0-9\.]+)/ ? $1 : ();
}

sub alien_check_built_version
{
  $CWD[-1] =~ /^libtool-(.*)$/ ? $1 : 'unknown';
}

1;
