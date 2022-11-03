#!/usr/bin/env bash

OS="$(uname -s)"

declare -a debian_dependencies=(
  "build-essential"
  "bison"
  "flex"
  "libgmp3-dev"
  "libmpc-dev"
  "libmpfr-dev"
  "texinfo"
  "libcloog-isl-dev"
  "libisl-dev"
)

declare -a fedora_dependencies=(
  "gcc"
  "gcc-c++"
  "make"
  "bison"
  "flex"
  "gmp-devel"
  "libmpc-devel"
  "mpfr-devel"
  "texinfo"
  "cloog-devel"
  "isl-devel"
)

declare -a arch_dependencies=(
  "base-devel"
  "gmp"
  "libmpc"
  "mpfr"
)

function detect_os()
{
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ];then
        echo "OS is Arch based"
        sudo pacman -S "${arch_dependencies[@]}" --noconfirm
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        echo "OS is Fedore based"
        sudo dnf install "${fedora_dependencies[@]}" -y
      else # assume debian based
        echo "Os is Debian based"
        sudo apt-get install --yes "${debian_dependencies[@]}"
      fi
    ;;
    *)
      echo "The operating System "$OS" is currently not supported"
      exit 1
    ;;
  esac
}
detect_os
