#!/bin/bash
set -e

if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    echo "Installing Swift for Linux"
    sudo apt-get install clang libicu-dev git -qq
    if [[ $OS_VER == '16.04' ]]; then
        echo ">Ubuntu Xenial 16.04"
    elif [[ $OS_VER == '14.04' ]]; then
        echo ">Ubuntu Trusty 14.04"
        echo "-Fetching & Installing Ubuntu Trusty 14.04 dependencies..."
        sudo apt-get install clang-3.6 -qq
        sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100 -qq
        sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100 -qq
    fi
    echo "-Installing Swift through #SwiftEnv#"
    mkdir .swiftenv
    git clone https://github.com/kylef/swiftenv ~/.swiftenv
    echo 'export SWIFTENV_ROOT="$HOME/.swiftenv"' >> ~/.bashrc
    echo 'export PATH="$SWIFTENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(swiftenv init -)"' >> ~/.bashrc
    source ~/.bashrc
    swiftenv install $SWIFT_VER
    echo "Finished installing Swift!"
fi