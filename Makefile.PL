use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Maypole::Plugin::Untaint',
    AUTHOR       => 'Sebastian Riedel (sri@oook.de)',
    VERSION_FROM => 'Untaint.pm',
    PREREQ_PM    => { Maypole => '2.0' }
);
