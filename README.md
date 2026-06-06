# sx

Universal search tool for the terminal. An interactive fzf-driven interface that combines file search, content search, and search across PDFs, documents, and archives into one unified experience.

## How It Works

sx wraps several CLI tools into a single interface:

- **[fd](https://github.com/sharkdp/fd)**: file discovery
- **[ripgrep](https://github.com/BurntSushi/ripgrep)**: content search
- **[ripgrep-all](https://github.com/phiresky/ripgrep-all)**: content search in PDFs, documents, archives (optional)
- **[fzf](https://github.com/junegunn/fzf)**: interactive filtering and selection
- **[bat](https://github.com/sharkdp/bat)**: syntax-highlighted file previews

Results appear in an fzf window. Text files open in `$EDITOR`, everything else
opens with the system handler (`xdg-open`, `open`, or `wslview`). Requires
Bash 4+ and fzf >= 0.36.

## Installation

### Arch Linux

Install dependencies:

    sudo pacman -S fd ripgrep fzf bat

Optional:

    paru -S ripgrep-all   # or your preferred AUR helper

Install sx:

    sudo cp sx /usr/local/bin/

### Debian / Ubuntu

Install dependencies:

    sudo apt install fd-find ripgrep fzf bat shellcheck

On Debian, `fd` and `bat` install under different names. Create symlinks:

    mkdir -p ~/.local/bin
    ln -sf /usr/bin/fdfind ~/.local/bin/fd
    ln -sf /usr/bin/batcat ~/.local/bin/bat

Ensure `~/.local/bin` is in your `$PATH`.

Optional: ripgrep-all is not packaged for Debian. Read install instructions [here](https://github.com/phiresky/ripgrep-all#debian-based).

Install sx:

    sudo cp sx /usr/local/bin/

## Development

Format and lint checks require `shfmt` and `shellcheck`:

    make check

## License

MIT
