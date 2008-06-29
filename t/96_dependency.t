use Test::Dependencies
	exclude => [qw/Test::Dependencies Test::Base Test::Perl::Critic YAIRCBot/],
	style   => 'light';
ok_dependencies();
