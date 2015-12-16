FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y mercurial \
    && git \
    && python \
    && curl \
    && vim-nox \
    && strace \
    && diffstat \
    && pkg-config \
    && cmake \
    && build-essential \
    && tcpdump \
    && screen \
    && ruby-dev

# Setup home environment
run useradd dev
run mkdir /home/dev && chown -R dev: /home/dev
run mkdir -p /home/dev/go /home/dev/bin /home/dev/lib /home/dev/include
env PATH /home/dev/bin:$PATH
env PKG_CONFIG_PATH /home/dev/lib/pkgconfig
env LD_LIBRARY_PATH /home/dev/lib

# Create a shared data volume
# We need to create an empty file, otherwise the volume will
# belong to root.
# This is probably a Docker bug.
run mkdir /var/shared/
run touch /var/shared/placeholder
run chown -R dev:dev /var/shared
volume /var/shared

workdir /home/dev
env HOME /home/dev
add vimrc /home/dev/.vimrc
add vim /home/dev/.vim
add bash_profile /home/dev/.bash_profile
add gitconfig /home/dev/.gitconfig

# Link in shared parts of the home directory
run ln -s /var/shared/.ssh
run ln -s /var/shared/.bash_history
run ln -s /var/shared/.maintainercfg

# Run vim stuff
run git clone -q https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
run vim -c 'PluginInstall' -c 'qa!'
run cd ~/.vim/bundle/command-t/ruby/command-t \
    && ruby extconf.rb \
    && make
