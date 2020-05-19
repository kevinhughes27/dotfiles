Kevin Hughes' dotfiles
======================

I've been collecting bits and pieces for a while and unfortunately I haven't always done a great job of keeping track of references so I can't effectively credit all those deserving. Big thanks to everyone whose ever written about or shared their dotfiles!


Installation
------------

```
cd ~
git clone https://github.com/kevinhughes27/dotfiles
cd dotfiles
./install.sh
```


.localrc
--------

My setup will read a `.localrc` for any system specific settings. Here is an example of what I have for my OSX machine which has some specific settings for work:

```
export GOPATH="$HOME/clio/Go"
export PATH="$GOPATH/bin:$PATH"

source $HOME/.clio_profile
```


References
----------
* https://github.com/ohmyzsh/ohmyzsh
* https://thoughtbot.com/blog/powerful-git-macros-for-automating-everyday-workflows
