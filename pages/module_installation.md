# Module Installation

% All of what I'm about to show you is available on the CPAN, so let's cover how to install them first.

% Who here does *not* know how to install a Perl module?

SLIDE

## Installing modules the old way

PAUSE
* Go to `search.cpan.org`, download, build, and install the tarball yourself
PAUSE
* Use the `cpan` command
PAUSE
* Use vendor-provided packages

SLIDE

So now that we've talked about the old way...

...what's the new way?

SLIDE

**cpanminus** (aka **cpanm**)

PAUSE

Unlike `cpan`, `cpanm` stays out of your way.

PAUSE
* It doesn't ask you for a boatload of configuration on first start
PAUSE
* It assumes you want to follow dependencies
PAUSE
* It doesn't bore you with reams of configure/build/test output unless you ask for it

SLIDE

`cpanm` is a zero-configuration tool, but it *does* support special options if you need them.

% Such as not running the test suite
% Installing from a specific mirror
% forcing installation if tests fail
% Only installing a module's dependencies
% Inspecting the contents of a module distribution

SLIDE

But what if you don't want to install modules globally? Maybe...

PAUSE
* You're on a box on which you don't have root access
PAUSE
* You don't want modules to be available globally
% In case you want to catch debugging statements before deploying to production
PAUSE
* You want globally installed modules installed via your system package manager, and you don't have a package for a module

% These are all very applicable to the developer's toolbox we're working to create!

SLIDE

The solution: **local::lib**

`local::lib` allows you to maintain a project-specific (or user-specific, or whatever) directory for modules.

% talk about work setup using local::lib

