scottfiles
==========

Scott's Dotfiles

by [Scott Smitelli](mailto:scott@smitelli.com)

Requirements
------------

  * [GNU Stow](http://www.gnu.org/software/stow/)

Usage
-----

First, `cd` into the root of this repository.

Run `stow <package>`, where <package> is the name of one of the directories in
the root of this repository. To remove a package, either run `stow -D <package>`
or just remove the symlinks for that package by hand.
