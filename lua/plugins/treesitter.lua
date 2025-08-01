return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "cpp",
                    "c_sharp",
                    "cmake",
                    "diff",
                    "dot",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "glsl",
                    "html",
                    "http",
                    "ini",
                    "json",
                    "javascript",
                    "make",
                    "regex",
                    "sql",
                    "ssh_config",
                    "latex",
                    "xml",
                    "yaml",
                    "lua",
                    "vim",
                    "vimdoc",
                    "regex",
                    "bash",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "terraform",
                    "go",
                    "rust",
                    "dockerfile",
                },
                auto_install = false,
                ignore_install = {},
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100kb
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
            })
        end,
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufRead",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
            separator = nil,
            zindex = 20,
            on_attach = nil,
        },
    },
}
