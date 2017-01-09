Kevin Hughes' dotfiles
======================

I finally started my own proper set of dotfiles. I've been collecting bits and pieces for a while and unfortunately I didn't do a great job of keeping track of where I got everything so I can't effectively credit all those deserving. You might be able to find some authors' details in the src files. Big thanks to everyone whose ever written about or shared their dotfiles!

Installation
------------

    cd ~
    git clone https://github.com/pickle27/dotfiles
    cd dotfiles
    ./install.sh

localrc
-------

My setup will read a `.localrc` for any system specific settings. Here is an example of what I have for my OSX machine which has some specific settings for work:

```
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$HOME/.yarn/bin:$PATH"

source /usr/local/share/chruby/chruby.sh
chruby 2.3.1

source /opt/dev/dev.sh

git config --system gpg.program "/usr/local/bin/gpg2"
```
