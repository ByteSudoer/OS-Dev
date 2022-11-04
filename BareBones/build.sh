#!/usr/bin/env bash





function wait()
{
  echo "########################################"
  echo "########################################"

}

function clean()
{
  wait
  echo "Cleaning"
  if [ -f kernel.o ];then
    rm kernel.o
  fi
  if [ -f boot.o ];then
    rm boot.o
  fi
  if [ -f myos.iso ];then
    rm myos.iso
  fi
  
  if [ -f myos.bin ];then
    rm myos.bin
  fi
  if [ -d isodir ];then
    rm -rf isodir
  fi
}

function build()
{
  wait
  echo "Assembling boot.s"
  # if ! command -v i686-elf-as &> /dev/null;then
    i686-elf-as boot.s -o boot.o
  # else
  #   "i686-elf-as command not found. try soursing env_variables file to add Croos*Compiler to PATH"
  #   exit 1
  # fi

  wait
  echo "Compiling Kernel"
  i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
  wait
  echo "Linking the kernel"
  i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

  wait
  echo "Cheking multiBoot"
  if grub-file --is-x86-multiboot myos.bin; then
    echo multiboot confirmed
  else
    echo the file is not multiboot
  fi

  if [ -d isodir ];then
    echo "Build Directory already exsites"
    echo "Cleaning ...."
  else 
    echo "Creating Building Directory"
  fi

  mkdir -p isodir/boot/grub 
  cp -v myos.bin isodir/boot/
  cp -v grub.cfg isodir/boot/grub/
  grub-mkrescue -o myos.iso isodir

}

function help()
{
  echo "Available Options:"
  echo "-h,--help     show help menu"
  echo "-c,--clean    clean Object Files and build build directories"
  echo "-b,--build    build ISO"
  echo "-r,--ruun     run ISO in QEMU"
}

function run()
{
  qemu-system-i386 -cdrom myos.iso
}

if [ "$#" -eq 0 ];then
  help 
  exit 1
else
  case $1 in
    -h|--help)
      help
      ;;
    -c|--clean)
      clean
      ;;
    -b|--build)
      build
      ;;
    -r|--run)
      run
      ;;
    *)
      echo "Invalid Option"
      help
      ;;
  esac
fi
