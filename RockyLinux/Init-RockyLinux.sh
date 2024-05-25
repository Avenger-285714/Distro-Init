## Enable ssh
sudo systemctl enable sshd && sudo systemctl start sshd
ip a
## Disable system sleep
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
## Update system
sudo dnf update -v -y
## Update grub2
sudo grub2-mkconfig --update-bls-cmdline -o /boot/grub2/grub.cfg
## Install dev packages
sudo dnf install epel-release -v -y
sudo dnf makecache -v
sudo dnf groupinstall "Development Tools" -v -y
sudo dnf install "gcc-toolset-13*" -v -y
sudo dnf install autoconf autojump automake\
                 binutils bison btop\
                 ccache ctags\
                 dnf-plugins-core\
                 elfutils exfatprogs\
                 fastfetch flatpak flex\
                 gettext gnome-tweaks golang gparted\
                 hfsplus-tools hfsutils htop\
                 indent\
                 leveldb libtool libxml2 libxml2-devel libxslt libxslt-devel\
                 neofetch nginx npm ntfsprogs ntfs-3g\
                 patch patchutils pkgconfig\
                 redhat-rpm-config redis rpm-build rpm-sign ruby ruby-devel\
                 snapd sqlite\
                 timeshift\
                 udftools\
                 yum-utils\
                 zsh\
                 -v -y
## Setup ccache
ccache -M 16G
## Setup flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install com.github.tchx84.Flatseal com.mattjakeman.ExtensionManager\
                 io.github.cboxdoerfer.FSearch io.github.peazip.PeaZip io.github.prateekmedia.appimagepool io.github.shiftey.Desktop\
                 io.missioncenter.MissionCenter\
                 org.gnome.Boxes org.gnome.Extensions org.gnome.Logs org.kde.falkon org.kde.kdiff3 org.kde.kommit org.onionshare.OnionShare\
                 -vy
## Setup snap
sudo systemctl enable snapd --now
sudo snap install core snapd snap-store --edge && sudo snap refresh
sudo snap list
sudo snap switch bare --channel=edge
sudo snap switch gnome-42-2204 --channel=edge
sudo snap switch core22 --channel=edge
sudo snap switch gtk-common-themes --channel=edge
sudo snap refresh
## Install docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -v
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -v -y
sudo systemctl --now enable docker && sudo systemctl start docker
sudo docker run hello-world
## Setup docker Portainer
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
sudo docker ps
## Install code-insiders -- https://code.visualstudio.com/docs/setup/linux
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc -v
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update -v
sudo dnf install code-insiders -v  -y
## Install microsoft-edge-dev -- https://www.microsoft.com/zh-cn/edge/download/insider
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc -v
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge -v
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-dev.repo -v
sudo dnf install microsoft-edge-dev -v -y
## Update newer kernel
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org -v
sudo dnf install https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm -v -y
sudo dnf makecache -v
sudo dnf install kernel-ml.x86_64 kernel-lt.x86_64 -v -y
## Install gh-cli -- https://github.com/cli/cli/blob/trunk/docs/install_linux.md
sudo dnf install 'dnf-command(config-manager)' -v
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo -v
sudo dnf install gh -v -y
