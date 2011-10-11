use inc::Module::Install;
name 'Acme-TatenoIsGoodMan';
all_from 'lib/Acme/TatenoIsGoodMan.pm';
readme_from 'lib/Acme/TatenoIsGoodMan.pm';
readme_markdown_from 'lib/Acme/TatenoIsGoodMan.pm';

requires 'Config::Pit';
requires 'Net::Twitter::Lite';

auto_include;
WriteAll;
