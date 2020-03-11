#!/usr/bin/perl
use strict;
use warnings;
# use diagnostics;

use POSIX qw( strftime );
use Carp qw( croak );
use File::Copy qw( copy );
use Cwd;

$ARGV[0] or die "Bitte Name eingeben!\n";

my $lz = strftime "%A_%d_%B_%Y", localtime;

system(getcwd . '/blutdruck_separat.r');
copy("Rplots.pdf", "blutdruck_separat_" . $ARGV[0] . "_$lz.pdf");
