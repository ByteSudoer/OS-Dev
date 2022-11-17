#!/usr/bin/env bash 


OS=$(uname -s)
# Color variables
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
# Clear the color after that
clear='\033[0m'

function msg_green()
{
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "${green}%s${clear}\n" "$text"
  printf "%${div_width}s\n" ' ' | tr ' ' -
}

function msg_red()
{
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "${red}%s${clear}\n" "$text"
  printf "%${div_width}s\n" ' ' | tr ' ' -
}

function msg_blue()
{
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "${blue}%s${clear}\n" "$text"
  printf "%${div_width}s\n" ' ' | tr ' ' -
}

function check_virtualization()
{
  if grep -E --color 'vmx|svm' /proc/cpuinfo > /dev/null ;then
    msg_green "Virtualization is enabled"
  else
    msg_red "Virtualization not enables"
    msg_red "Check your BIOS"
    exit 1
  fi
}
function arch_installation()
{
  msg_blue "Running Update"
  sleep 2
  sudo pacman -Syyu --noconfirm

  if [ "$1" -eq 1 ];then
    sudo pacman -S virtualbox --noconfirm
    msg_blue "Creating & Editing Kernel Module File"
    sudo touch /etc/modules-load.d/virtualbox.conf
    echo "vboxdrv" | sudo tee vboxdrv /etc/modules-load.d/virtualbox.conf
    msg_green "Installation Done. You have to reboot for changes to take effect."
    msg_green "After rebotting. Add your login user to the vbox users group."
    msg_green "By Running this command : $(sudo usermod -aG vboxusers $(whoami))"
  elif [ "$1" -eq 2 ];then
    msg_blue "Installing QEMU for Arch"
    msg_blue "Your package manager will ask you for conflict packages. Type y"
    sleep 2 
    sudo pacman -S qemu virt-manager libvirt virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables libguestfs
    msg_blue "Enabling the libvirtd service"
    sudo systemctl enable --now libvirtd
    msg_blue "Allowing non root users to use KVM/QEMU Virtualization"
    sudo sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
    sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf
    sudo usermod -a -G libvirt $(whoami)
    sudo systemctl restart libvirtd 
  fi
}
function debian_installation()
{
  msg_blue "Running Update"
  sleep 2
  sudo apt-get update && sudo apt-get upgrade

  if [ "$1" -eq 1 ];then

    msg_blue "Importing VirtualBox repository GPG Keys"
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    msg_blue "Adding VirtualBox apt repository to system source list"
    sudo apt install software-properties-common
    sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    msg_blue "Updating the package list"
    sudo apt update && sudo apt install virtualbox-6.0
    msg_red "Do you want to install the extension pack"
    msg_red "Yes/No"
    read -r answer
    case $answer in
      ([yY]|[yY]|[eE]|[sS])
        msg_blue "Installing extension pack"
        msg_green "You will be presented with Oracke license Type y and hit Enter"
        wget https://download.virtualbox.org/virtualbox/6.0.10/Oracle_VM_VirtualBox_Extension_Pack-6.0.10.vbox-extpack
        sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.0.10.vbox-extpack
        ;;
      ([nN]|[nN]|[oO])
        msg_blue "Skipping extension pack installation"*
        ;;
    esac
  elif [ "$1" -eq 2 ];then
    msg_blue "Installing Qemu/Virtmanager"
    sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon -y
    sudo apt install virt-manager -y
  fi


}

function detect_os_and_install()
{
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ];then
        msg_green "Arch Linux Detected"
        arch_installation "$1"
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        msg_green "Fedora Linux Detected"
      else # assume debian based
        msg_green "Os is Debian based"
        debian_installation "$1"
      fi
    ;;
    *)
      msg_red "The Operating System "$OS" is currently not supported"
      exit 1
    ;;
  esac
}
function main()
{
  msg_blue "This Script Will Install an Emulator of your choice"
  check_virtualization
  msg_blue "Available Options"
  echo "1 - For Qemu and virt-manager"
  echo "2 - For VirtualBox"
  read -r option
  case $option in
    1)
      echo "Installing VirtualBox"
      ;;
    2)
      echo "Installing QEMU"
      ;;
    *)
      msg_red "Invalid Option"
      ;;
  esac

}
main
