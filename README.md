# Installation

A pre-compiled version of this utility is available as a NPM module. To install
it globally so you can use it from the command line, use

    npm install -g wakeup

By installing it locally, you can use its public API (see index.coffee).

# Usage

This module contains a single binary which sends WOL packets to remote hosts.
To wake a host using its MAC address, simply use

    wakeup 01:23:45:ab:cd:ef

The MAC address must be specified as six hexadecimal bytes separated by colons.
Use `wakeup --help` to get a list of all available options.

# License

This work is licensed under a [Creative Commons Attribution 4.0 International
License](http://creativecommons.org/licenses/by/4.0/).
