package Maypole::Plugin::Untaint;

use strict;
use NEXT;

Maypole::Config->mk_accessors('untaint_columns');

our $VERSION = '0.04';

=head1 NAME

Maypole::Plugin::Untaint - Simple Untaint for Maypole

=head1 SYNOPSIS

Simple example:

    package MyApp;

    use Maypole::Application qw(Untaint);

    MyApp->config->untaint_columns(
        table1 => { html      => [qw(name email)] },
        table2 => { printable => [qw(lalala)] }
    );
    MyApp->setup( 'dbi:Pg:dbname=myapp', 'myuser', 'mypass' );

With Maypole::Plugin::Config::YAML:

    package MyApp;

    use Maypole::Application qw(Config::YAML Untaint -Setup);

    __DATA__
    --- #YAML:1.0
    application_name: MyApp
    dsn: dbi:Pg:dbname=myapp
    user: postgres
    pass: 0
    opts:
      AutoCommit: 1
    template_root: '/home/sri/MyApp/templates'
    uri_base: http://localhost/myapp
    untaint_columns:
      table1:
        html:
          - name
          - email
      table2:
        printable:
          - lalala
    
=head1 DESCRIPTION

Useful in combination with Maypole::Config::YAML.

Note that you need Maypole 2.0 or newer to use this module!

=cut

sub setup {
    my $r = shift;
    $r->NEXT::DISTINCT::setup(@_);
    while ( my ( $t, $u ) = each %{ $r->config->untaint_columns } ) {
        $r->config->model->class_of( $r, $t )->untaint_columns( %{$u} );
    }
}

=head1 AUTHOR

Sebastian Riedel, C <sri@oook.de>

=head1 THANKS TO

Stephen Quinney

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
