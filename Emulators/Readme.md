# Emulators

## Table Of Contents
[virtualbox]

- [VirtualBox](#VirtualBox)
- [Qemu](#Qemu)
- [Real Hardware](#Real-Hardware)

## Goal

This page will help you set up an emulator on your linux machine(support for debian(Ubunut,Mint),Fedora and arch) and you will be able to test your compiled projects.

To run a 64-bit guest OS on a 32-bit host, the CPU must support virtualisation (AMD-V or Intel VT-x) and nested paging (AMD RVI or Intel EPT).

### VirtualBox

you can install VirtualBox on your machine by running the [Script]

```bash
user@localhost $: chmod +x ./installer.sh
user@localhost $: ./installer.sh
```

> Check VirtualBox official Website [Site](http://www.virtualbox.org/)

### Qemu

you can install Qemu and virt-manager on your machine by running the [Script]

```bash
user@localhost $: chmod +x ./installer.sh
user@localhost $: ./installer.sh
```

### Real Hardware

This is not really an "Emulator" but if testing and development on real hardware is more suitable for you case, you can test your operating system on real hardware. But first you need to burn your ISO to an USB stick.

```bash
user@localhost $: sudo dd if=myos.bin of=/dev/sdx && sync
## /dev/sdx is the mount path for you USB stick
```

> Be aware that this operation will erase all data on your USB. Proceed to create a backup if you need to.

[script]: ./installer.sh
