# Building a Cross-Compiler

## Table Of Contents

- [Check Dependencies](#Check-Dependencies)
- [Download Source Code](#Download-Source-Code)
- [The Build](#The-Build)
  - [Environment Variables](#Environment-Variables)
  - [Binutils](#Binutils)
  - [GCC](#GCC)

### Check Dependencies

- Compiler
- Make
- Bison
- Flex
- GMP
- MPC
- MPFR
- Texinfo
- CLooG (optional)
- ISL (optional)

For full Details on various systems, please refer to this link [Installing Dependencies](https://wiki.osdev.org/GCC_Cross-Compiler#Installing_Dependencies)

> This script will support Debian(Ubuntu,Mint), Fedora and arch. For other distributions please refer to you distribution package manager and mirror.

you can run the script [dependencies]

```bash
# Mark the script Executable
chmod +x dependencies.sh
# And finally run it
./dependencies.sh
```

[dependencies]: ./dependencies.sh

### Download Source Code

- Check what versions of GCC and Binutils are already installed in you distribution

```bash
user@localhost:$ gcc --version
    gcc (GCC) 12.2.0
    Copyright (C) 2022 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

user@localhost:$ ld --version
    GNU ld (GNU Binutils) 2.39.0
    Copyright (C) 2022 Free Software Foundation, Inc.
    This program is free software; you may redistribute it under the terms of
    the GNU General Public License version 3 or (at your option) a later version.
    This program has absolutely no warranty.
```

- Start by downloading the desired GCC and binutils release
  - [GCC main mirror](https://ftp.gnu.org/gnu/gcc/)
  - [Binutils main mirror](https://ftp.gnu.org/gnu/binutils/)

Or you can edit `lines number 8 and 9` in the [build-compiler] script and change the gcc and binutils version. And the script will automatically download, decompress and build the cross compiler.

```bash
# Declare GCC & Binutils Versions
gcc_version=11.3.0
binutils_version=2.36
#change version according to your desire
```

Then you have to run the [build-compiler]

```bash
chmod +x build-compiler.sh
./build-compiler.sh
```

After the script executes and exits successfully, you will end up will this file structure:

```bash
.
├── build-compiler.sh
├── compressed
│   ├── binutils-2.36.tar.gz
│   └── gcc-11.3.0.tar.gz
├── decompressed
│   ├── binutils-2.36
│   └── gcc-11.3.0
├── dependencies.sh
├── env-variables.sh
└── Readme.md
```

> The downloaded sources ends up in directory `compressed` and the extracted version is in the directory `decompressed` and we will refer to those paths for our build.

[build-compiler]: ./build-compiler.sh

### The Build

#### Environment Variables

Here we will decide where to install our new compiler.It is a very bad idea to install into System directories. You also need to decide whether the new compiler should be intalled globally or just for you.If you want ti install it just for you,installing it into your home directory is a normally a good idea.If you want to install it gloablly, installing it into /usr/local/cross is normally a good idea.

#### Binutils

Running the [build-compiler] script will do it. For further reading, please refer to the [Wiki](https://wiki.osdev.org/GCC_Cross-Compiler).

#### GCC

Running the [build-compiler] script will do it. For further reading, please refer to the [Wiki](https://wiki.osdev.org/GCC_Cross-Compiler).

#### Using the new Compiler

```bash
$HOME/(your_path_to_the_build)/bin/$TARGET --version

```
