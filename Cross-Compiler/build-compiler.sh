#!/usr/bin/env bash
# 

compressed_dir="$PWD/compressed"
decompressed_dir="$PWD/decompressed"

# Declare GCC & Binutils Versions
gcc_version=11.3.0
binutils_version=2.36

gcc_file=gcc-"$gcc_version".tar.gz
binutils_file=binutils-"$binutils_version".tar.gz

function download_gcc_binutils()
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
    mkdir "$PWD"/compressed
  fi
  
}


function decompress_gcc_bintuls
{

  if [ -d "$decompressed_dir"/"$(basename $gcc_file .tar.gz)" ];then
    echo "Folder $(basename $gcc_file .tar.gz) already exists"
  else
    echo "Decompressing GCC to $decompressed_dir "
    sleep 2 
    tar -xvf "$compressed_dir"/$gcc_file -C "$decompressed_dir"
  fi

  if [ -d "$decompressed_dir"/"$(basename $binutils_file .tar.gz)" ];then
    echo "Folder $(basename $binutils_file .tar.gz) already exists"
  else
    echo "Decompressing Binutils to $decompressed_dir "
    sleep 2 
    tar -xvf "$compressed_dir"/$binutils_file -C "$decompressed_dir"
  fi

}
# decompress_gcc_bintuls
download_gcc_binutils

