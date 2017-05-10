sudo apt install -y git chromium-browser

### VIM (with lua support)
# Remove previous installations
sudo apt-get remove vim vim-runtime vim-tiny vim-common

# Install dependencies
sudo apt-get install -y libncurses5-dev python-dev libperl-dev ruby-dev liblua5.2-dev

# Fix liblua paths
sudo ln -s /usr/include/lua5.2 /usr/include/lua
sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/local/lib/liblua.so

# Clone vim sources
cd ~
git clone https://github.com/vim/vim.git

cd vim
./configure --prefix=/usr     \
    --enable-luainterp=yes    \
    --enable-perlinterp=yes   \
    --enable-pythoninterp=yes \
    --enable-rubyinterp=yes   \
    --enable-cscope           \
    --disable-netbeans        \
    --enable-multibyte        \
    --enable-largefile        \
    --enable-gui=no           \
    --with-features=huge      \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu

make VIMRUNTIMEDIR=/usr/share/vim/vim80

sudo apt-get install checkinstall
sudo checkinstall

# Silver Searcher
sudo apt install -y silversearcher-ag

### DOTFILES
cd
git clone https://github.com/rentziass/dotfiles.git dotfiles
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt update
sudo apt install rcm
env RCRC=$HOME/dotfiles/rcrc rcup
touch ~/.env
cp -a ~/dotfiles/bin/. ~/bin

### ZSH
sudo apt install -y zsh
zsh

### PREZTO
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# Removing super annoying git alias from prezto
sed -i "/alias g='git'/d" ~/.zprezto/modules/git/alias.zsh

### SOLARIZED TERMINAL, 'coz we all love it right?
cd
wget --no-check-certificate https://raw.github.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
mv dircolors.ansi-dark .dircolors
eval `dircolors ~/.dircolors`

sudo apt-get install git-core
git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized
./set_dark.sh

### SPOTIFY
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

### RUBY & RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -L https://get.rvm.io | bash -s stable --ruby

### Create working dirs
cd
mkdir go
mkdir work
mkdir fun
mkdir sandbox

### Golang
sudo apt install -y golang
vim +GoInstallBinaries +qall

# Secure store for git passwords
sudo apt install -y libgnome-keyring-dev
cd /usr/share/doc/git/contrib/credential/gnome-keyring
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring
cd

### Hub
cd
wget https://github.com/github/hub/releases/download/v2.3.0-pre9/hub-linux-amd64-2.3.0-pre9.tgz
tar x -f  hub-linux-amd64-2.3.0-pre9.tgz
mv hub-linux-amd64-2.3.0-pre9/bin/hub ~/bin/hub
rm -rf hub-linux-amd64-2.3.0-pre9
rm -f hub-linux-amd64-2.3.0-pre9.tgz

### ZSH AS DEFAULT
chsh -s $(which zsh)
