# Module Installation

Over the course of this presentation, we'll be building up a developer's workbench.  All of the tools I'm
about to show you are available on the CPAN, so let's cover how to install them first.

SLIDE

## Installing modules the old way

PAUSE
* Go to `search.cpan.org`, download, build, and install the tarball yourself
PAUSE
* Use the `cpan` command
PAUSE
* Use vendor-provided packages

PAUSE

Note that all of these still have valid uses; some modules require a little more tender love and care and need
to be installed manually; sometimes all you have on a machine is `cpan`, and sometimes you want to only work
with a set of 'blessed' modules in your package repository.

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

PAUSE
* Such as not running the test suite (`-n`)
PAUSE
* Installing from a specific mirror (`--mirror`)
PAUSE
* forcing installation if tests fail (`-f`)
PAUSE
* Only installing a module's dependencies (`--installdeps`)
PAUSE
* Inspecting the contents of a module distribution (`--look`)
PAUSE
* And much, much more!

SLIDE

But what if you don't want to install modules globally? Maybe...

PAUSE
* You're on a box on which you don't have root access
PAUSE
* You don't want modules to be available globally (In case you want to catch debugging statements before deploying to production)
PAUSE
* You want globally installed modules installed via your system package manager, and you don't have a package for a module (Let's say you want to try out several logging modules without having to create an RPM for each)

SLIDE

The solution: **local::lib**

`local::lib` allows you to maintain a project-specific (or user-specific, or whatever) directory for modules.

PAUSE

For example, I have a local::lib under `$HOME/devlib` at work so I can keep my tools isolated from production stuff.
