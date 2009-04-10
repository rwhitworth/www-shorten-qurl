use Test::More tests => 1;
# Basic test of 'does the module load, damnit!'
use WWW::Shorten::Qurl;

eval { WWW::Shorten::Qurl->import(':invalid') };

ok($@);
