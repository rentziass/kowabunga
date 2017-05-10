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

make VIMRUNTIMEDIR=/usr/share/vim/vim74

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

### ZSH
sudo apt install -y zsh
chsh -s $(which zsh)
zsh

### PREZTO
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"


