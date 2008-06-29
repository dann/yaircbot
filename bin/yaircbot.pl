#!/usr/bin/env perl
use strict;
use warnings;
use FindBin::libs;
use YAIRCBot;

my $nick   = 'commandbot';
my $server = 'irc.freenode.net';
my $port   = 6667;

my $bot = YAIRCBot->new(
    nick   => $nick,
    server => $server,
    port   => $port
);
$bot->run;

__END__
