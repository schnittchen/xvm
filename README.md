# xvm - a bash snippet operating a few version managers

Currently supported are chruby, evm and kiex. kiex support requires evm.

## Usage

First up, set up chruby, evm and kiex.
Then, put this in your .bashrc:

```
source path-to-xvm/xvm.source.bash

# only needed if you want auto-change behaviour
if [ -n "$PS1" ]; then
  trap xvm DEBUG
fi
```

You can then call `xvm` to have versions set up according to version files (see below) in your current working directory.
If you decide to use the auto-change behaviour, xvm is called automatically for you when you change directories (and at
other times, too, so changes to version files are usually picked up immediately)

## Version files

The well-known `.ruby-version` file is detected and used by xvm to call chruby.
A `.xvm-evm` file will be used for calling `evm use` with the version in that file as argument.
A `.xvm-kiex` file will be used for calling `kiex use` with the version in that file as argument.
Kiex is only called after evm has been, since elixir versions often require a certain minimal erlang version.

