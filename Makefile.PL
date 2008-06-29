use inc::Module::Install;
name 'YAIRCBot';
all_from 'lib/YAIRCBot.pm';

requires $_ for (qw/ /);

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
