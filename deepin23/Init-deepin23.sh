## Enable ssh
sudo apt update --fix-missing
sudo apt install openssh-server --fix-missing
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh
ip addr
## Disable system sleep
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
## Update system
sudo apt update --fix-missing
sudo apt dist-upgrade -y --fix-missing
sudo apt autoremove
## Install dev packages
sudo apt install antlr3 apparmor apt-transport-https asciidoc auditd autoconf autojump automake autopoint\
                 binutils bison btop btrfs-progs build-essential bzip2\
                 ca-certificates ccache cmake com.oray.sunlogin.client console-setup cpio cryptsetup curl\
                 deepin-wine-diag deepin-wine-helper device-tree-compiler dirmngr dmsetup dosfstools d-feet\
                 e2fsprogs exuberant-ctags exfat-utils\
                 fastjar flatpak flex\
                 gawk gcc-multilib genisoimage gettext git git-doc git-email gperf gpg g++-multilib\
                 haveged help2man hfsutils htop\
                 intltool iotop\
                 jfsutils\
                 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev libssl-dev libtool\
                 libvirt-clients-qemu libvirt-login-shell libvirt-daemon-driver-storage-gluster libvirt-daemon-driver-storage-iscsi-direct libvirt-daemon-driver-storage-rbd\
                 libvirt-daemon-driver-storage-zfs\
                 linux-firmware linux-headers-deepin-hwe-amd64 linux-image-deepin-hwe-amd64 linux-libc-dev lm-sensors lolcat lrzsz lvm2\
                 mtools\
                 neofetch nfs-common nilfs-tools ninja-build ntfs-3g\
                 ovmf\
                 p7zip p7zip-full packagekit-tools patch pkgconf plymouth-themes python3 python3-pyelftools python3-setuptools\
                 qemu-block-extra qemu-efi qemu-efi-aarch64 qemu-efi-arm qemu-guest-agent qemu-system qemu-system-arm qemu-system-common qemu-system-data qemu-system-gui qemu-system-mips\
                 qemu-system-misc qemu-system-modules-opengl qemu-system-modules-spice qemu-system-ppc qemu-system-sparc qemu-system-x86 qemu-system-xen qemu-user qemu-user-binfmt qemu-utils\
                 reiser4progs rsync\
                 scons seabios snapd software-properties-common squashfs-tools strace subversion swig systemtap\
                 texinfo tmux\
                 uglifyjs unzip util-linux\
                 vde2 vim virtualbox virtualbox-dkms virtualbox-qt virt-manager\
                 wget\
                 xfsdump xfsprogs xmlto xxd\
                 zlib1g-dev zsh zsh-doc zstd\
                 -y --fix-missing
## Install workspace apps
sudo apt update --fix-missing
sudo apt install cn.wps.wps-office com.qq.weixin.deepin com.qq.weixin.work.deepin\
                 linux.qq.com uos-ai -y --fix-missing
## Setup ccache
ccache -M 16G
## Setup flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -v
sudo flatpak update -vy && sudo flatpak install flathub org.gtk.Gtk3theme.deepin flathub org.gtk.Gtk3theme.deepin-dark -vy && sudo flatpak update -vy
sudo flatpak install com.github.tchx84.Flatseal\
                 io.github.cboxdoerfer.FSearch io.github.peazip.PeaZip io.github.prateekmedia.appimagepool io.github.shiftey.Desktop\
                 io.missioncenter.MissionCenter\
                 org.gnome.Boxes org.gnome.Logs org.kde.falkon org.kde.kdiff3 org.kde.kommit org.onionshare.OnionShare\
                 -vy
## Setup snap
sudo snap install core snapd snap-store --edge && sudo snap refresh
sudo snap list
## Setup zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
omz update -v
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
## Install microsoft-edge-dev -- https://www.microsoft.com/zh-cn/edge/download/insider
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm -rvf microsoft.gpg
sudo apt update --fix-missing && sudo apt install microsoft-edge-dev -y --fix-missing
## Install code-insiders -- https://code.visualstudio.com/docs/setup/linux
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -rvf packages.microsoft.gpg
sudo apt update --fix-missing && sudo apt install code-insiders -y --fix-missing
## Install docker -- https://docs.docker.com/engine/install/debian/
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian bookworm test" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update --fix-missing && sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y --fix-missing
sudo docker run hello-world
## Install element (matrix)
sudo wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list
sudo apt update --fix-missing && sudo apt install element-nightly -y --fix-missing
## Install firefox-nightly -- https://support.mozilla.org/en-US/kb/install-firefox-linux
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
sudo apt-get update --fix-missing && sudo apt-get install firefox-nightly firefox-nightly-l10n-zh-cn -y --fix-missing
## Install gh-cli -- https://github.com/cli/cli/blob/trunk/docs/install_linux.md
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update --fix-missing && sudo apt install gh -y --fix-missing
## Install opera -- https://www.linuxcapable.com/install-opera-browser-on-ubuntu-linux/
curl -fsSL https://deb.opera.com/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/opera.gpg > /dev/null
echo deb [arch=amd64 signed-by=/usr/share/keyrings/opera.gpg] https://deb.opera.com/opera-stable/ stable non-free | sudo tee /etc/apt/sources.list.d/opera.list
sudo apt update --fix-missing && sudo apt install opera-developer -y --fix-missing
opera-developer --version
