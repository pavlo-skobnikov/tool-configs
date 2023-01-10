# Tools' Configurations

The repository contains my personal configuration files for the main tools that
I use in my programming workflow.

The tools are as follows:
- Amethyst  -> An automatic tiling window manager
- Zsh       -> An extendable and feature-rich shell
- Kitty     -> Minimal but capable terminal emulator
- NeoVim    -> Blazingly-fast code editor

## Setup Notes

### Amethyst

The configuration file is `.amethyst.yml` is placed in the `~/.config/amethyst` while
the root `~/.amethyst.yml` is actually a symlink.

To achieve this on new computer setups, after installing Amethyst, run the following
commands sequentially:
```
ln -s ~/.config/amethyst/.amethyst.yml ~/.amethyst.yml
```

Please Note! The main programs that I use have their own Spaces/Screens.
Below is a mappings of screens to the applications:
- Space 1 -> Browser
- Space 2 -> Terminal emulator
- Space 3 -> IDE
- Space 4 -> Communication applications (Mail, Slack, Telegram, Skype)
- Space 5 -> Notion
- Space 6 -> Time-management applications (Calendar, Reminders)
- Space 7 -> Everything else

Switching between applications is switching between Spaces, which is done via `^1..7`.

### Zsh

The main configuration file is `.zshrc` is placed in the `~/.config/zsh` while
the root `~/.zshrc` is actually a symlink.

To achieve this on new computer setups, after installing Zsh, run the following
commands sequentially:
```
ln -s ~/.config/zsh/.zshrc ~/.zshrc
```

Please Note! Don't forget to set `Zsh` as the main shell for the system by
running the following command:
```
chsh -s $(which zsh)
```

### Kitty

All the configurations are found in the `~/.config/kitty/kitty.conf` file.

### Helix

All the configurations are found in the `~/.config/helix/` file.

### Intellij Which-Key Mappings

This folder is just a personalization of WhichKey plugin mappings originally done by Marceloni
in his [intellimacs](https://github.com/MarcoIeni/intellimacs).

#### What's Different Here?

- The configurations are placed in the `~/.config/intellij` directory. This groups the mappings 
in this repository with all your other configurations.
- Many duplicate and nested mappings are either removed or remapped to allow for 1 file per 1 group
  of mappings strategy.
- A lot of mappings are regrouped semantically, which moves the mappings away from the
  "Spacemacs-style" but makes them more straightforward (in my humble opinion, of course).
- Some additional plugins and settings are present.

#### Setup

1. Install [IdeaVim](https://plugins.jetbrains.com/plugin/164-ideavim) and [WhichKey]
   (https://plugins.jetbrains.com/plugin/15976-which-key) plugins for Intellij IDEA
2. Clone this repository:
```shell
git clone https://github.com/pavlo-skobnikov/simple-which-key-mappings ~/.config/intellij
```
3. Add the following line to your `~/.ideavimrc` (-> create the file it doesn't exist).
```vimrc
source ~/.config/intellij/which_key/simple-which-key-mappings.vim
```
4. Reload the IDEA vimrc.
5. ???
6. Profit by easily dispatching commands to Intellij IDEA without having to remember all the default
   keymaps.
