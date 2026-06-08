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
Bash 4+ and fzf >= 0.52.

## Installation

### Quick Install

    curl -fsSL https://raw.githubusercontent.com/nikoksr/sx/main/install.sh | bash

### From Source

    git clone https://github.com/nikoksr/sx.git
    cd sx
    ./install.sh

### Dependencies

sx requires [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [fzf](https://github.com/junegunn/fzf) >= 0.52, and [bat](https://github.com/sharkdp/bat).
Optional: [ripgrep-all](https://github.com/phiresky/ripgrep-all) for searching PDFs, documents, and archives.

Run `sx --version` to verify the installation.

**Arch Linux:**

    sudo pacman -S fd ripgrep fzf bat

Optional:

    paru -S ripgrep-all   # or your preferred AUR helper

**Debian / Ubuntu:**

    sudo apt install fd-find ripgrep fzf bat

Note: Debian's fzf package may be older than 0.52. Check with `fzf --version`.
If needed, install a newer version from https://github.com/junegunn/fzf.

Optional:

    # ripgrep-all is not packaged for Debian. See:
    # https://github.com/phiresky/ripgrep-all#debian-based

**macOS:**

    brew install fd ripgrep fzf bat

Optional:

    brew install ripgrep-all

## Development

Format and lint checks require `shfmt` and `shellcheck`:

    make check

## License

MIT
