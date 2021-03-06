#!/usr/bin/env perl

use strict;

sub main {
    my $input = do { local $/; <> };
    $input =~ s/.*?\n= Commands\n//s;
    $input =~ s/(.*?\n== Configuration Commands\n.*?\n)==? .*/$1/s;
    my @list;
    while ($input =~ s/.*?^- (.*?)(?=\n- |\n== |\z)//ms) {
        my $text = $1;
        $text =~ /\A(.*)\n/
            or die "Bad text '$text'";
        my $usage = $1;
        $usage =~ s/\A`(.*)`\z/$1/
            or die "Bad usage: '$text'";
        (my $name = $usage) =~ s/ .*//;
        push @list, $name;
    }
    @list = sort @list;

    print <<"...";
#!bash

# DO NOT EDIT. This file generated by tool/generate-completion.pl.

_git_hub() {
  __gitcomp "@list"
}
...
}

main;
