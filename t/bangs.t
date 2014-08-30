
use strict;
use warnings;

use Test::More;

# ABSTRACT: Make sure things go bang!

use CPAN::Changes::Dependencies::Details;

is( eval { CPAN::Changes::Dependencies::Details->load;        1 }, undef, 'load explodes' );
is( eval { CPAN::Changes::Dependencies::Details->load_string; 1 }, undef, 'load_string explodes' );

done_testing;

