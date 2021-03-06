#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use mop;

eval '
class Foo {
    has $!foo bar;
}
';
like($@, qr/^Couldn't parse attribute \$!foo/);

eval '
class Bar:Bar { }
';
like($@, qr/^Invalid identifier: Bar:Bar/);

eval '
    has $!x
';
like($@, qr/^has must be called from within a class or role block/, '\'has...\' outside of Class has a good error');

eval '
    method foo { }
';
like($@, qr/^method must be called from within a class or role block/, '\'method...\' outside of Class has a good error');

eval '
class Baz {
    method {}
}
';
like($@, qr/^{} is not a valid method name/, "syntax errors in class blocks are propagated properly");

done_testing;
