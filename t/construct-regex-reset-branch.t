
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 4;
use Test::Warnings;

expect_known_construct '?|';
expect_known_construct 'regex-reset-branch';

expect_construct_in_perl
    '5.010' => is_supported,
    '5.012' => is_supported,
    '5.014' => is_supported,
    '5.016' => is_supported,
    '5.018' => is_supported,
    '5.020' => is_supported,
    '5.022' => is_supported,
    '5.024' => is_supported,
    '5.026' => is_supported,
    '5.028' => is_supported,
    ;

syntax_error_when_unsupported qr/Sequence .* not recognized in regex/;

expect_sample_code
    returns_when_supported => 'b',
    code => <<'EOCODE',
        "abc" =~ m/(?|(x)|(b))/;
        $1;
EOCODE
    ;

