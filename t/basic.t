
use strict;
use warnings;

use Test::More;
use Test::Differences;

# FILENAME: basic.t
# CREATED: 08/01/14 22:58:44 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Test basic functionality

require CPAN::Changes::Dependencies::Details;

my $instance = CPAN::Changes::Dependencies::Details->new( preamble => 'This is a test', );

$instance->add_release(
  {
    version     => '0.001',
    date        => '2014-01-01',
    new_prereqs => { runtime => { requires => { 'Moo' => '1.0' } } },
    old_prereqs => {},
  }
);
$instance->add_release(
  {
    version     => '0.002',
    date        => '2014-01-02',
    new_prereqs => { runtime => { requires => { 'Moo' => '1.2' } } },
    old_prereqs => { runtime => { requires => { 'Moo' => '1.0' } } },
  }
);
$instance->add_release(
  {
    version     => '0.003',
    date        => '2014-01-03',
    new_prereqs => {},
    old_prereqs => { runtime => { requires => { 'Moo' => '1.0' } } },
  }
);

use utf8;

my $expected = <<'EOF';
This is a test

0.003 2014-01-03
 [Removed / runtime requires]
 - Moo 1.0

0.002 2014-01-02
 [Changed / runtime requires]
 - Moo 1.0 → 1.2

0.001 2014-01-01
 [Added / runtime requires]
 - Moo 1.0

EOF

eq_or_diff( $instance->serialize, $expected, 'Serialize works as intended' );

done_testing;

