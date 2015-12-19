function xvm_chruby {
  type chruby >/dev/null || return 1;

  version=
  if { read -r version < .ruby-version; } 2>/dev/null || [[ -n "$version" ]]; then
    version="${version%%[[:space:]]}"
    chruby "$version"
  fi
}

function xvm_evm {
  type evm >/dev/null || return 1;

  version=
  if { read -r version < .xvm-evm; } 2>/dev/null || [[ -n "$version" ]]; then
    evm use "$version"
  fi
}

function xvm_kiex {
  type kiex >/dev/null || return 1;

  version=
  if { read -r version < .xvm-kiex; } 2>/dev/null || [[ -n "$version" ]]; then
    kiex use "$version"
  fi
}

function xvm {
  xvm_chruby && xvm_evm && xvm_kiex
}
