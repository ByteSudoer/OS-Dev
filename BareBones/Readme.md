# Bare Bones Tutorial

### Project Documentation

For full guide and complete steps and details check the [tutorial](https://wiki.osdev.org/Bare_Bones)

### Compiling

First you have to make sure that the previously compiled cross-compiler is in the `PATH` of your current shell.
You can compile files individually or by just running :

```bash
user@localhost:$ ./build.sh -r
```

Available Options:

```bash
user@localhost:$ ./build.sh --help
Available Options:
-h,--help     show help menu
-c,--clean    clean Object Files and build build directories
-b,--build    build ISO
-r,--ruun     run ISO in QEMU

```

> The run Option will start a VM in VNC server.You will need A VNC client to check the progress.
