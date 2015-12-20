function xvm_chruby {
  type chruby >/dev/null || return 1;

  version=
  if { read -r version < .ruby-version; } 2>/dev/null || [[ -n "$version" ]]; then
    version="${version%%[[:space:]]}"

    if [ "$version" == "$XVM_CHRUBY" ]; then
      return 0
    fi
    XVM_CHRUBY="$version"

    echo "xvm: calling chruby $version"
    chruby "$version"
  fi
}

function xvm_evm {
  type evm >/dev/null || return 1;

  version=
  if { read -r version < .xvm-evm; } 2>/dev/null || [[ -n "$version" ]]; then
    if [ "$version" == "$XVM_EVM" ]; then
      return 0
    fi
    XVM_EVM="$version"

    echo "xvm: calling evm use $version"
    evm use "$version"
  fi
}

function xvm_kiex {
  type kiex >/dev/null || return 1;

  version=
  if { read -r version < .xvm-kiex; } 2>/dev/null || [[ -n "$version" ]]; then
    if [ "$version" == "$XVM_KIEX" ]; then
      return 0
    fi
    XVM_KIEX="$version"

    echo "xvm: calling kiex use $version"
    kiex use "$version"
  fi
}

function xvm {
  xvm_chruby && xvm_evm && xvm_kiex
}
