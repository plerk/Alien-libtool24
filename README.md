# Alien::libtool24 [![Build Status](https://secure.travis-ci.org/plicease/Alien-libtool24.png)](http://travis-ci.org/plicease/Alien-libtool24)

Built or find libtool 2.4.x

# SYNOPSIS

From your [Alien::Base](https://metacpan.org/pod/Alien::Base) based Build.PL:

    Alien::Base::ModuleBuild->new(
      ...
      alien_bin_requires => {
        'Alien::libtool24' => 0,
      },
      alien_build_commands => [
        ...
        'libtool ...',
        ...
      ],
      ...
    );

From regular Perl:

    use Alien::libtool24;
    use env qw( @PATH );
    
    # puts libtook in the PATH if it isn't already there
    unshift @PATH, Alien::libtool24->bin_dir;
    system 'libtool ...';

# DESCRIPTION

This module will download and install libtool 2.4.x if it is not already
available on your system.  As with other [Alien::Base](https://metacpan.org/pod/Alien::Base) based distributions
it will install into a distribution based share directory which will not
override or otherwise malign your system software.

# METHODS

## bin\_dir

    my $dir = Alien::libtool24->bin_dir;

Returns the directory which contains the `libtool` and `libtoolize` scripts.
Adding this to the `PATH` usually means that you can run these commands without
fully qualifying them.  Returns empty list if libtool is _already_ in the `PATH`.

## dist\_dir

    my $dir = Alien::libtool24->dist_dir;

Returns the base install directory of `libtool` if it was installed by building
it from source, rather than using your system's version of libtool.

# CAVEATS

This works(ish) on Windows, in that it installs, but `libtool` installs itself
as a shell script which can be used with [Alien::MSYS](https://metacpan.org/pod/Alien::MSYS), but is not very useful
by itself.  [Alien::Hunspell](https://metacpan.org/pod/Alien::Hunspell) uses this module successfully, but somewhat
hackishly on Windows.

# SEE ALSO

- Alien
- Alien::Base

# AUTHOR

Graham Ollis &lt;plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
