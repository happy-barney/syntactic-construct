
use strict;
use warnings;

use Shared::Example::Syntax::Construct;

use Test::More tests => 1 + 5;
use Test::Deep qw[ bool ];
use Test::Warnings;

expect_known_construct 'unicode10.0';
expect_known_construct 'unicode-10.0';

expect_construct_in_perl
    '5.028' => is_supported,
    ;

expect_sample_code
    returns_when_supported => 8_518,
    syntax_error_when_unsupported => qr/Can't find Unicode property definition/,
    code => <<'EOCODE',
        my ($count, $char) = (0, 0);
        chr ($char) =~ m/\p{Age: 10.0}/ and $count++ while ++$char < 0xf_ffff;
        $count;
EOCODE
    ;

expect_sample_code
    returns_when_supported => bool (1),
    $] >= 5.020
        ? (syntax_error_when_unsupported => qr/Unknown charname 'T-REX'/)
        :
    $] >= 5.016
        ? (returns_when_unsupported => bool (0))
        :
    $] < 5.010
        ? (syntax_error_when_unsupported => qr/Constant\(\\N\{...\}\) unknown/)
        : (syntax_error_when_unsupported => qr/Constant\(\\N\{T-REX\}\) unknown/)
        ,
    returns_when_unsupported => bool (0),
    code => <<'EOCODE',
        "\N{T-REX}" eq "\N{U+1F996}"
EOCODE
    ;
