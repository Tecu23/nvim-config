# Neovim Configuration

Welcome to my Neovim configuration! This setup is designed to make development smoother and more efficient, with a focus on frontend development (JavaScript, TypeScript, and React) while leveraging a powerful LSP setup, custom UI enhancements, and cross-platform consistency.

## Features

- **LSP Integration**: Full support for JavaScript, TypeScript, and other languages with language server configurations.
- **Auto-Formatting**: Automatically format code and organize imports on save using `conform.nvim` and `typescript-tools`.
- **Enhanced UI**: Powered by `NvChad` components for an improved statusline, LSP indicators, and overall UI polish.
- **Cross-Platform**: Configured for both macOS and Linux environments, ensuring consistency across systems.
- **Organized Structure**: Clean folder structure for easy management of settings, LSP configurations, and plugins.

## Folder Structure

The configuration is structured for easy navigation and extensibility:

```plaintext
~/.config/nvim/
├── init.lua            # Main Neovim configuration file
├── lua/
│   ├── lsp/
│   │   ├── init.lua    # Main LSP configurations
│   │   ├── setup.lua   # Generic setup functions for LSP
│   │   └── servers/    # Folder for individual server configurations
│   │       ├── ts.lua  # TypeScript LSP configuration
│   │       └── js.lua  # JavaScript LSP configuration
│   ├── plugins/        # Plugin configurations and setup
│   └── settings/       # General editor settings (keybindings, options, etc.)
└── README.md           # This file
```

## Key Plugins

- **[`conform.nvim`](https://github.com/stevearc/conform.nvim)**: Handles auto-formatting and organizing imports on save, making code cleanup effortless.
- **[`typescript-tools.nvim`](https://github.com/someone/typescript-tools.nvim)**: Provides extended TypeScript support for a better coding experience.
- **Additional Utilities**: Plugins for code navigation (`telescope.nvim`), Git integration (`gitsigns.nvim`), syntax highlighting (`nvim-treesitter`), and more.

## Installation

### Prerequisites

- **Neovim 0.10+**: Ensure that you have Neovim installed and up-to-date.
  - For macOS:
    ```bash
    brew install neovim
    ```
  - For Linux (Debian-based):
    ```bash
    sudo apt install neovim
    ```

### Setup

1. **Clone the Configuration**
   Replace your existing Neovim configuration by cloning this repo:

   ```bash
   git clone https://github.com/yourusername/neovim-config ~/.config/nvim
   ```

2. **Install Plugins**
   Launch Neovim and run the following command to install the required plugins:

   ```vim
   :PackerSync
   ```

3. **Install Language Servers**
   Install necessary language servers globally for LSP functionality:

   ```bash
   npm install -g typescript-language-server
   npm install -g vscode-langservers-extracted  # For JavaScript, CSS, HTML, etc.
   ```

4. **macOS/Linux Compatibility**
   - If you're running macOS, there may be differences in behavior for JSX inspection (e.g., `:Inspect` command). Specific configurations for platform differences can be adjusted in the respective `servers` files under `lsp/`.

## Usage

### Common Commands

- **Format on Save**: Triggered automatically for `.ts`, `.js`, `.jsx`, and `.tsx` files.
- **LSP Actions**: Use commands like `:LspHover`, `:LspDefinition`, and `:LspReferences` to interact with the LSP.
- **Telescope**: Quickly search files, symbols, and more with `:Telescope find_files` or `:Telescope live_grep`.

### Custom Keybindings

Keybindings are set up to enhance productivity:

- **Leader Key**: `\` is used as the leader key.
- **File Search**: `<Leader>ff` to find files with Telescope.
- **Code Formatting**: `<Leader>f` to manually format the current buffer.

Keybindings can be adjusted in `lua/settings/keybindings.lua`.

## Troubleshooting

- **`:Inspect` Command on macOS**: If `:Inspect` shows no marks on JSX tags, ensure you have the correct LSP settings for macOS in the `servers/` configurations.
- **Plugin Issues**: Run `:PackerSync` to ensure all plugins are up-to-date.

## Contributing

Feel free to contribute to this configuration by opening issues or submitting pull requests. Any suggestions for improving compatibility, adding features, or fixing bugs are welcome.

## License

This Neovim configuration is open-source and available under the MIT License. See the `LICENSE` file for more details.

---

Thank you for checking out my Neovim configuration! I hope it helps you become more productive and enjoy your development experience even more.
