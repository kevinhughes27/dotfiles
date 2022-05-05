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
