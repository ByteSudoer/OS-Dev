# Building a Cross-Compiler

### Table Of Contents

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

> This script will support Debian(Ubuntu,Mint), Fedora and arch. For other disctributions please refer to you distribution package manager and mirros.

### Download Source Code

- Start by downloading the desired GCC and binutils release
  - [GCC main mirror](https://ftp.gnu.org/gnu/gcc/)
  - [Binutils main mirror](https://ftp.gnu.org/gnu/binutils/)
- Check what versions of GCC and Binutils are already installed in you ditribution

```bash
gcc --version
  gcc (GCC) 12.2.0
  Copyright (C) 2022 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

ld --version
  GNU ld (GNU Binutils) 2.39.0
  Copyright (C) 2022 Free Software Foundation, Inc.
  This program is free software; you may redistribute it under the terms of
  the GNU General Public License version 3 or (at your option) a later version.
  This program has absolutely no warranty.
```

### Install System dependencies

you can run the script [dependencies]

```bash
# Mark the script Executable
chmod +x dependencies.sh
# And finally run it
./dependencies.sh
```

[dependencies]: ./dependencies.sh
