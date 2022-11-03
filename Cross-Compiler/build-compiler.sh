#!/usr/bin/env bash
# 
#
# set -xe
#
#cores=$(nproc)

compressed_dir="$PWD/compressed"
decompressed_dir="$PWD/decompressed"

# Declare GCC & Binutils Versions
gcc_version=11.3.0
binutils_version=2.36

gcc_file=gcc-"$gcc_version".tar.gz
binutils_file=binutils-"$binutils_version".tar.gz

function wait()
{
  echo "#####################################################"
  echo "#####################################################"

}

function setup_directories()
{
  if [ -d "$compressed_dir" ];then
    echo "Destination Directory already exists"
  else 
    echo "$compressed_dir created"
    mkdir "$PWD"/compressed
  fi
  if [ -d "$decompressed_dir" ];then
    echo "Source Directory already exists"
  else 
    echo "$decompressed_dir created"
    mkdir "$PWD"/decompressed
  fi

}
function download_gcc_binutils()
{
  if [ -f "$compressed_dir"/$gcc_file ];then
    echo "GCC version : $gcc_version already downloaded"
    echo "Skipping this Step"
  else 
    echo "Downloading gcc"
    sleep 2
    wget -v https://ftp.gnu.org/gnu/gcc/gcc-"$gcc_version"/"$gcc_file" -P "$compressed_dir"/
  fi
  wait
  
  if [ -f "$compressed_dir"/$binutils_file ];then
    echo "Binutils version : $binutils_version already downloaded"
    echo "Skipping this Step"
  else
    echo "Downloading binutils"
    sleep 2 
    wget -v https://ftp.gnu.org/gnu/binutils/binutils-"$binutils_version".tar.gz -P "$compressed_dir"/
  fi

}


function decompress_gcc_bintuls
{

  if [ -d "$decompressed_dir"/"$(basename $gcc_file .tar.gz)" ];then
    echo "Folder $(basename $gcc_file .tar.gz) already exists"
    wait
  else
    wait
    echo "Decompressing GCC to $decompressed_dir "
    sleep 2 
    tar -xvf "$compressed_dir"/$gcc_file -C "$decompressed_dir"
  fi

  if [ -d "$decompressed_dir"/"$(basename $binutils_file .tar.gz)" ];then
    echo "Folder $(basename $binutils_file .tar.gz) already exists"
    wait
  else
    wait
    echo "Decompressing Binutils to $decompressed_dir "
    sleep 2 
    tar -xvf "$compressed_dir"/$binutils_file -C "$decompressed_dir"
  fi

}

function sourcing_environment()
{
  echo "Source Environment Variables."
  wait
  sleep 2
  source "$PWD"/env-variables.sh
}

function building_binutils()
{
  cd "$decompressed_dir"
  if [ -d "$decompressed_dir"/build_binutils ];then
    echo "Binutils Build directory already exists"
    echo "If you faced any errors in the build try removing its content and re-running the script"
  else
    mkdir "$decompressed_dir"/build_binutils
  fi

  wait
  echo "Building Binutils"
  cd "$decompressed_dir"/build_binutils
  "$decompressed_dir"/$(basename $binutils_file .tar.gz)/configure --target="$TARGET" \
    --prefix="$PREFIX" \
    --with-sysroot \
    --disable-nls \
    --disable-werror
  
  make -j$(nproc)
  make install -j$(nproc)
}
function building_gcc()
{
  cd "$decompressed_dir"
  which -- "$TARGET"-as || echo "$TARGET"-as is not in the PATH

  if [ -d "$decompressed_dir"/build-gcc ];then
    echo "GCC Build directory already exists"
    echo "If you faced any errors in the build try removing its content and re-running the script"
  else
    mkdir "$decompressed_dir"/build-gcc
  fi
  wait
  echo "Building GCC"
  cd "$decompressed_dir"/build-gcc
  "$decompressed_dir"/$(basename $gcc_file .tar.gz)/configure --target="$TARGET" \
    --prefix="$PREFIX" \
    --disable-nls \
    --enable-languages=c,c++ \
    --without-headers \

  make -j$(nproc) all-gcc
  make -j$(nproc) all-target-libgcc
  make -j$(nproc) install-gcc
  make -j$(nproc) install-target-libgcc


}


setup_directories
download_gcc_binutils
decompress_gcc_bintuls
sourcing_environment
building_binutils
building_gcc

