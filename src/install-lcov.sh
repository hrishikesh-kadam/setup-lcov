#!/usr/bin/env bash

# Arguments:
#   $1 REF Git reference like branch or tag of linux-test-project/lcov repository. 
#      Use HEAD for the default branch.
#      Empty for stable versions.

set -e -o pipefail

REF=$1

#######################################
# Arguments:
#   $1 REF Git reference like branch or tag of linux-test-project/lcov repository. 
#      Use HEAD for the default branch.
#######################################
make_install() {
  REF=$1
  # https://github.com/linux-test-project/lcov/blob/d465f73117ac3b66e9f6d172346ae18fcfaf0f69/README#L116-L162
  # https://www.cpan.org/modules/INSTALL.html
  if [[ $(uname -s) =~ ^"Darwin" ]]; then
    brew install cpanm
  else
    sudo cpan App::cpanminus
  fi
  sudo cpanm \
    --notest \
    Capture::Tiny \
    DateTime
  LCOV_DIR="/tmp/lcov"
  BRANCH_ARG=()
  if [[ $REF != "HEAD" ]]; then
    BRANCH_ARG=(--branch "$REF")
  fi
  git clone \
    "${BRANCH_ARG[@]}" \
    --depth 1 \
    https://github.com/linux-test-project/lcov.git \
    $LCOV_DIR
  pushd $LCOV_DIR &> /dev/null
  sudo make install
  popd &> /dev/null
}

OS_NAME=$(uname -s)
if [[ $OS_NAME =~ ^"Linux" ]]; then
  if [[ $REF == "" ]]; then
    sudo apt-get -y install lcov
  else
    make_install "$REF"
  fi
elif [[ $OS_NAME =~ ^"Darwin" ]]; then
  if [[ $REF == "" ]]; then
    brew install lcov
  elif [[ $REF == "HEAD" ]]; then
    brew install --HEAD lcov
  else
    make_install "$REF"
  fi
elif [[ $OS_NAME =~ ^"MINGW" ]]; then
  choco install lcov
  : "${ChocolateyInstall:=C:\ProgramData\chocolatey}"
  LCOV_ROOT_WIN="$ChocolateyInstall\lib\lcov\tools\bin"
  LCOV_ROOT_NIX=$(cygpath "$LCOV_ROOT_WIN")
  if [[ ! $PATH =~ $LCOV_ROOT_NIX ]]; then
    if [[ $GITHUB_ACTIONS == "true" ]]; then
      echo "$LCOV_ROOT_WIN" >> "$GITHUB_PATH"
      PATH="$LCOV_ROOT_NIX:$PATH"
      # For pwsh, cmd and powershell
      # shellcheck disable=SC2028
      echo "$GITHUB_ACTION_PATH\bin" >> "$GITHUB_PATH"
    else
      # Deliberately avoiding to set PATH by setx command
      echo "$LCOV_ROOT_NIX directory not found on PATH"
    fi
  fi
else
  echo "Unknown OS: $OS_NAME"
  exit 1
fi
