# Neovim Config

This Neovim configuration is tailored for developers who seek speed, usability, and productivity. It leverages modern plugins and Neovim features to deliver a streamlined, highly customizable coding environment.

## Features

- **File Navigation**: Quickly navigate files with [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua).
- **Syntax Highlighting & LSP**: Enhanced syntax highlighting via [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) and robust language support with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
- **Autocomplete**: Intelligent and fast autocompletion using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with integrated snippets.
- **Git Integration**: Git management directly in Neovim with [fugitive](https://github.com/tpope/vim-fugitive) and in-line diffing via [gitsigns](https://github.com/lewis6991/gitsigns.nvim).
- **Status Line & Tabline**: Dynamic status and tab lines via [lualine](https://github.com/nvim-lualine/lualine.nvim).
- **Fuzzy Finder**: Effortless searching and navigation with [telescope](https://github.com/nvim-telescope/telescope.nvim).
- **Themes**: Popular themes like [gruvbox](https://github.com/morhetz/gruvbox) or [tokyonight](https://github.com/folke/tokyonight.nvim).

## Prerequisites

- **Neovim** version >= 0.8
- **git**
- **lazy.nvim**: This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.
- Optional dependencies for full functionality:
  - **Node.js** (for LSP support with certain languages)
  - **ripgrep** (for faster fuzzy searching with Telescope)
  - **Python 3** (for Python LSP and plugins)

## Installation

1. **Install Neovim** (v0.8 or newer required):

   ```bash
   # macOS
   brew install neovim
   # Ubuntu
   sudo apt install neovim
   ```

2. **Clone this repository**:

   ```bash
   git clone https://github.com/yourusername/your-repo-name ~/.config/nvim
   ```

3. **Install Plugins**:
   This configuration utilizes **lazy.nvim** as a package manager:

   - Lazy.nvim will automatically install itself when you launch Neovim with this config.
   - Open Neovim and run `:Lazy sync` to install all plugins.

## Keybindings

Some of the custom keybindings available in this setup are listed below. Feel free to review `keybindings.lua` for the full list or to customize further:

- **File Navigation**:

  - `Ctrl+n`: Toggle file explorer.
  - `Space+f`: Open fuzzy finder.
  - `Space+e`: Edit/initiate a quick file search.

- **LSP Navigation**:

  - `gd`: Go to definition.
  - `K`: Hover to view documentation.
  - `gr`: List references.

- **Buffer Management**:

  - `Space+b`: Switch buffers.
  - `Ctrl+w`: Close current buffer.
  - `Space+bn`: Move to the next buffer.

- **Git Commands**:
  - `:G`: Open fugitive Git interface.
  - `]c` and `[c`: Navigate between hunks.
  - `Space+gs`: Stage hunk with gitsigns.

## Configuration

This configuration is modular and easy to customize. You can modify plugins, key mappings, themes, and other settings by editing the files in the `lua` directory.

- **Plugins**: Configure plugins in `lua/plugins.lua`.
- **Keybindings**: Update or add keybindings in `lua/keybindings.lua`.
- **LSP Settings**: Configure language servers and diagnostics in `lua/lsp-config.lua`.
- **Themes**: Switch themes or customize theme options in `lua/theme-config.lua`.

### Lazy.nvim Configuration

To add or remove plugins:

1. Open `lua/plugins.lua`.
2. Add plugins using the format:

   ```lua
   return {
       {
           'plugin-name/repo',
           config = function()
               require('plugin-config')
           end,
           lazy = true,
       },
       -- other plugins
   }
   ```

3. Reload Neovim and run :Lazy sync to update plugins.

## Dependencies

- [Packer.nvim](https://github.com/wbthomason/packer.nvim) (recommended plugin manager)
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope
- Optional: [Node.js](https://nodejs.org/) for certain LSPs or plugins.

## Screenshots

| File Explorer                           | Fuzzy Finder                        | LSP Integration               |
| --------------------------------------- | ----------------------------------- | ----------------------------- |
| ![Explorer](./screenshots/explorer.png) | ![Finder](./screenshots/finder.png) | ![LSP](./screenshots/lsp.png) |

## Contributing

Feel free to submit issues or pull requests for new features, plugin integrations, or bug fixes.

## License

This Neovim configuration is open-source under the [MIT License](./LICENSE).
