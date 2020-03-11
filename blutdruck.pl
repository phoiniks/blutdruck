#!/usr/bin/perl
use strict;
use warnings;
# use diagnostics;

use POSIX qw( strftime );
use DBI;
use Carp qw( croak );
use File::Copy qw( copy );
use Cwd qw( getcwd );

my $lz = strftime "%A_%d_%B_%Y", localtime;

if ( -e 'blutdruck.db' ) {
    copy('blutdruck.db', 'blutdruck.db.kopie')
	or die "Kann blutdruck.db nicht nach ../ kopieren: $!\n";
}

if ( @ARGV < 4 ) {
    croak "Bitte nicht vergessen, die Parameter für Systole, Diastole und Puls einzugeben.\nBeispiel für vollständigen Programmaufruf: ./herz.pl Name 120 80 70.\n";
}

my $dbh = DBI->connect('DBI:SQLite:dbname=blutdruck.db', '', '', { RaiseError => 0, PrintError => 1 })
    or die "Kann Datenbank blutruck.db nicht öffnen: $DBI::errstr\n";

my $sql = "CREATE TABLE IF NOT EXISTS blutdruck(id INTEGER PRIMARY KEY, name TEXT, systole INTEGER, diastole INTEGER, puls INTEGER, datum DATE DEFAULT (DATETIME('now', 'localtime')))";

$dbh->do($sql)
    or die "Kann SQL-Anweisung nicht ausführen: $DBI::errstr\n";

$sql = "INSERT INTO blutdruck (name, systole, diastole, puls) VALUES(?, ?, ?, ?)";

my $sth = $dbh->prepare($sql)
    or die "Kann SQL-Anweisung nicht vorbereiten: $DBI::errstr\n";

$sth->execute($ARGV[0], $ARGV[1], $ARGV[2], $ARGV[3])
    or die "Kann SQL-Anweisung nicht ausführen: $dbh->errstr()\n";

system(getcwd . "/blutdruck.r");
copy("Rplots.pdf", "blutdruck_datiert_" . $ARGV[0] . "_$lz.pdf");

system(getcwd . "/blutdruck_separat.r");
copy("Rplots.pdf", "blutdruck_separat_" . $ARGV[0] . "_$lz.pdf");

system(getcwd . "/blutdruck_zusammen.r");
copy("Rplots.pdf", "blutdruck_zusammen_" . $ARGV[0] . "_$lz.pdf");
