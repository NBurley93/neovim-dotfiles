# Cabal's Neovim Dotfiles

## Setup

Ensure you are connected to the internet,
startup nvim and run `:PackerSync` to install required plugins

If the autosetup for the LSP and NullLS doesn't work,
refer to `lua/cabal/lsp.lua` and `lua/cabal/nullls.lua`
to determine what needs to be installed using `:Mason`

## TODO

- Figure out how to get lualine to properly highlight the active buffer with our color scheme, or at least make it clearer which one is active
