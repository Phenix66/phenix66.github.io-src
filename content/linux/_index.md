+++
archetype = "chapter"
title = "Linux"
weight = 1
+++

9001 times better than Windows.

### Misc

Random reference I saved for some reason, IDK I don't use VIM: http://vimregex.com/

#### Fix perl locale message

`update-locale LC_CTYPE=en_US.UTF-8`

#### Show current shell

`ps -p $$`

#### Removing a Git submodule

```
git submodule deinit <path_to_submodule>
git rm <path_to_submodule>
git commit-m "Removed submodule "
rm -rf .git/modules/<path_to_submodule>
```
