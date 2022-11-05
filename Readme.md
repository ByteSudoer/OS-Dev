# OS-Dev

![os-dev](https://user-images.githubusercontent.com/88513682/200138941-d30aa341-6f40-487a-8f1f-1026408cb5f8.png)

- This repository is a set of guides and scripts to automate tasks from the OS Dev wiki

### Table Of Contents

- [Building a Cross-Compiler](#Building-a-Cross-Compiler)
- [Bare Bones Tutorial](#Bare-Bones-Tutorial)
- [Tools](#Tools)
- [References](#References)

#### Building a Cross-Compiler

Follow the instructions in this guide [Cross-Compiler].

This script assumes you are using a UNIX-like operating system.Windows users should be able to set up a complete the tutorial from a [WSL](https://wiki.osdev.org/WSL), [MinGW](https://wiki.osdev.org/MinGW) or [Cygwin](https://wiki.osdev.org/Cygwin).

> For full instructions and steps use the links above and refer to the wiki, as the scripts in this project assume you will be building everything with [GCC](https://gnu.org/software/gcc/)

#### Bare Bones Tutorial

The Bare Bones tutorial is a beginners tutorial (used as an introduction in the wiki) that will get you through the basic concepts of OS development like :

- Linkers
- Assembly
- GNU compiler Collection (The Cross Compiler by choice)
- C programming language
- Bootloader (GRUB)
- ElF files (Executables file format)

> check link to tutorial in [References](#References) section

#### Tools

**Virtualisation software :**

- [QEMU](https://www.qemu.org/) you can check this [tutorial](https://linuxhint.com/qemu-tutorial/) to walk through setting up QEMU on your local machine.
- [Virtual Box](https://www.virtualbox.org/)

**Writing imgage to USB :**

- dd a command line utility for Unix and Unix-like operating systems.
- [Balena Etcher](https://www.balena.io/etcher/) a FOSS live image creator.

### References

- [OS-Dev main page](https://wiki.osdev.org/Main_Page)
- [Bare Bones Tutorial](https://wiki.osdev.org/Bare_Bones)

[cross-compiler]: ./Cross-Compiler/Readme.md
