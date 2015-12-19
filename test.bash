source /usr/local/share/chruby/chruby.sh
source ~/.evm/scripts/evm
source ~/.kiex/scripts/kiex.bash

function test_ruby_version {
  ruby --version | grep "$1"
}

function test_erlangotp_version {
  erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), erlang:display(erlang:binary_to_list(Version)), halt().' -noshell | xargs echo -e | grep $1
}

function test_elixir_version {
  elixir --version | grep "$1"
}

test_ruby_version "2.2" && exit 1 # prereq


function clean {
  rm -f .ruby-version
  rm -f .xvm-evm
  rm -f .xvm-kiex
}

(
  echo "case 1: no config files found"

  clean

  . xvm.source.bash
  if xvm;
  then
    echo "passed"
  else
    echo "failed"
    exit 1
  fi

)

(
  echo "case 2: valid .ruby-version"

  clean
  echo "2.2.2" > .ruby-version

  . xvm.source.bash
  if xvm && test_ruby_version "2.2.2";
  then
    echo "passed"
  else
    echo "failed"
  fi
)

(
  echo "case 3: invalid .ruby-version"

  clean
  echo "nonexistent" > .ruby-version

  . xvm.source.bash
  if xvm;
  then
    echo "failed"
  else
    echo "passed"
  fi
)

(
  echo "case 4: valid OTP release"

  clean
  echo "18.1" > .xvm-evm

  . xvm.source.bash
  if xvm && test_erlangotp_version "18.1";
  then
    echo "passed"
  else
    echo "failed"
  fi
)

(
  echo "case 5: invalid OTP release"

  echo "skipping: evm does not return a proper exit code"; exit
  # see https://github.com/robisonsantos/evm/issues/14
)

(
  echo "case 6: valid elixir version"

  clean
  echo "18.1" > .xvm-evm # rerequisite
  echo "1.1.1" > .xvm-kiex

  . xvm.source.bash
  if xvm && test_elixir_version "1.1.1";
  then
    echo "passed"
  else
    echo "failed"
  fi
)

(
  echo "case 7: invalid elixir version"

  echo "skipping: kiex does not return a proper exit code"; exit
  # see https://github.com/taylor/kiex/issues/35

  clean
  echo "18.1" > .xvm-evm # rerequisite
  echo "elephant" > .xvm-kiex

  . xvm.source.bash
  if xvm
  then
    echo "failed"
  else
    echo "passed"
  fi
)

