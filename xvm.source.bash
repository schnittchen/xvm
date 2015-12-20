function xvm_chruby {
  local version

  if { read -r version < .ruby-version; } 2>/dev/null || [[ -n "$version" ]]; then
    version="${version%%[[:space:]]}"

    if [ "$version" == "$XVM_CHRUBY" ]; then
      return 0
    fi

    type chruby >/dev/null || return 1;

    echo "xvm: calling chruby $version"
    chruby "$version" && XVM_CHRUBY="$version"
  fi
}

function xvm_evm {
  local version

  if { read -r version < .xvm-evm; } 2>/dev/null || [[ -n "$version" ]]; then
    if [ "$version" == "$XVM_EVM" ]; then
      return 0
    fi

    type evm >/dev/null || return 1;

    echo "xvm: calling evm use $version"
    evm use "$version" && XVM_EVM="$version"
  fi
}

function xvm_kiex {
  local version

  if { read -r version < .xvm-kiex; } 2>/dev/null || [[ -n "$version" ]]; then
    if [ "$version" == "$XVM_KIEX" ]; then
      return 0
    fi

    type kiex >/dev/null || return 1;

    echo "xvm: calling kiex use $version"
    kiex use "$version" && XVM_KIEX="$version"
  fi
}

function xvm {
  local failed

  xvm_chruby || failed=true
  # calling kiex only makes sense after evm was a success
  xvm_evm && xvm_kiex || failed=true

  [ -z $failed ]
}
