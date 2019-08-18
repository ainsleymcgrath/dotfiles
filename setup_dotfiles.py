"""Utility script for setting up Ainsley's dev tools on macOS

INSTALL_ITEMS has keys for each item to install.
Each value is dictionary specifying installation config.
Items are specified in more-or-less dependency order.

Config options:
    install_command - defaults to `brew install`, otherwise a 1D list to pass to subprocess
    post_install - runs after 'install_command', 1D list to pass to subprocess or 2D for multiple
    dotfile - if specified, the configuration file for the installed tool
    symlink_loc - if 'dotfile' is given, defaults to $HOME, otherwise location to link dotfile to

"""
from pathlib import Path
import subprocess

HOME_DIRECTORY = Path.home()
WORKING_DIRECTORY = Path.cwd()

HOMEBREW_INSTALL_SCRIPT = subprocess.run(
    [
        "curl",
        "-fsSL",
        "https://raw.githubusercontent.com/Homebrew/install/master/install",
    ],
    capture_output=True,
).stdout

INSTALL_ITEMS = {
    "brew": {"install_command": ["/usr/bin/ruby", "-e", HOMEBREW_INSTALL_SCRIPT]},
    "getantibody/tap/antibody": {},
    "zsh": {  # two for one: docs say to do both at once
        "dotfile": ".zshrc",
        "post_install": ["chsh", "-s", "/bin/zsh"],
    },
    "zsh-completions": {},
    "tmux": {"dotfile": ".tmux.conf"},
    "tpm": {
        "install_command": [
            "git",
            "clone",
            "https://github.com/tmux-plugins/tpm",
            "~/.tmux/plugins/tpm",
        ]
    },
    "nvim": {
        "dotfile": "init.vim",
        "symlink_loc": "~/.config/nvim",
        "post_install": [
            ["python3", "-m", "venv", "~/.config/nvim/neovim_venv"],
            ["~/.config/nvim/neovim_venv/bin/python", "install", "neovim"],
        ],
    },
    "vim-plug": {
        "install_command": [
            "curl",
            "-fLo",
            "~/.local/share/nvim/site/autoload/plug.vim",
            "--create-dirs",
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
        ]
    },
    "the_silver_searcher": {},
    "fzf": {"post_install": ["/usr/local/opt/fzf/install"]},
    "bat": {},
    "google-chrome": {"install_command": ["brew", "cask", "install", "google-chrome"]},
    "typora": {"install_command": ["brew", "cask", "install", "typora"]},
}


def do_install(install_item_name, config_dict):
    """Takes an item to install and its config_dict dict.
    Runs `brew install` if command not specified, otherwise runs config_dict["install_command"]."""

    try:
        install_command = config_dict["install_command"]
        subprocess.run(install_command)
    except KeyError:
        subprocess.run(["brew", "install", install_item_name])


def maybe_do_post_install(config_dict):
    """If config_dict["post_install"] if specified, runs 1 or many commands.
    list(str) for 1 and list(list(str)) for many."""

    try:
        post_install = config_dict["post_install"]

        if isinstance(post_install[0], list):
            for command in post_install:
                subprocess.run(command)

            return

        subprocess.run(post_install)

    except KeyError:
        pass


def maybe_do_symlink(config_dict):
    """Checks for presence of config_dict["dotfile"]. Does nothing without it.
    If it's prsesnet, links it to config_dict["symlink_loc"] or $HOME if not specified"""

    try:
        dotfile_loc = Path(WORKING_DIRECTORY, config_dict["dotfile"])
        try:
            symlink_loc = Path(config_dict["symlink_loc"])
            subprocess.run(["ln", "-s", dotfile_loc], cwd=symlink_loc)
        except KeyError:
            subprocess.run(["ln", "-s", dotfile_loc], cwd=HOME_DIRECTORY)

    except KeyError:
        pass


if __name__ == "__main__":
    for name, config in INSTALL_ITEMS.items():
        do_install(name, config)
        maybe_do_post_install(config)
        maybe_do_symlink(config)
