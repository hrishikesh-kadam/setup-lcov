#!/usr/bin/env bash

# Arguments:
#   $1 INSTALL_HEAD_VERSION true / false

set -e -o pipefail

if [[ $(uname -s) =~ ^"Linux" ]]; then
  if [[ $INSTALL_HEAD_VERSION != "true" ]]; then
    sudo apt-get -y install lcov
  else
    # https://github.com/linux-test-project/lcov/blob/d465f73117ac3b66e9f6d172346ae18fcfaf0f69/README#L116-L162
    # https://www.cpan.org/modules/INSTALL.html
    sudo cpan App::cpanminus
    sudo cpanm \
      --notest \
      Capture::Tiny \
      DateTime
    LCOV_DIR="/tmp/lcov"
    git clone \
      --depth 1 \
      https://github.com/linux-test-project/lcov.git \
      $LCOV_DIR
    pushd $LCOV_DIR &> /dev/null
    sudo make install
    popd &> /dev/null
  fi
elif [[ $(uname -s) =~ ^"Darwin" ]]; then
  brew install lcov
elif [[ $(uname -s) =~ ^"MINGW" ]]; then
  choco install lcov
  if [[ $GITHUB_ACTIONS == "true" ]]; then
    # For bash
    # shellcheck disable=SC2028,SC2154
    echo "$ChocolateyInstall\lib\lcov\tools\bin" >> "$GITHUB_PATH"
    # For pwsh, cmd and powershell
    echo "GITHUB_ACTION_PATH=$GITHUB_ACTION_PATH"
    # shellcheck disable=SC2028
    echo "$GITHUB_ACTION_PATH\bin" >> "$GITHUB_PATH"
  fi
else
  echo "Unknown OS: $(uname -s)"
  exit 1
fi