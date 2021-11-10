dotfiles
========

Installation
------------

```
git clone https://github.com/kevinhughes27/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

Afterwards remember to update to ssh: `git remote set-url origin git@github.com:kevinhughes27/dotfiles`


.localrc
--------

My setup will read a `.localrc` for any system specific settings. This lets me maintain one set of common dotfiles while still having flexability. It is pretty common for programs to manually add config to your dotfiles and when that happens I will see the changes in git and usually move the new code to localrc.

Here is an example of what I have for my OSX machine which has some specific settings for work:

```
export GOPATH="$HOME/clio/Go"
export PATH="$GOPATH/bin:$PATH"

source $HOME/.clio_profile
```


References
----------

I've been collecting bits and pieces for a while and unfortunately I haven't always done a great job of keeping track of references so I can't effectively credit all those deserving. Big thanks to everyone whose ever written about or shared their dotfiles!

* https://github.com/ohmyzsh/ohmyzsh
* https://thoughtbot.com/blog/powerful-git-macros-for-automating-everyday-workflows
* https://gist.github.com/fimmtiu/263192ba21534a63057a034edc218c0b
* https://github.com/sirupsen/dotfiles
* https://github.com/SidOfc/dotfiles
* https://oroques.dev/notes/neovim-init/
* https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030
* https://github.com/siduck76/neovim-dots
* https://github.com/mjlbach/defaults.nvim
* https://github.com/rafamadriz/friendly-snippets
