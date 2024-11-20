local commonicons = require("common.icons")
local map = function(keys, action, desc)
    vim.keymap.set("n", keys, action, { desc = desc })
end

return {
    {
        "nvim-neotest/neotest",
        config = function()
            require("neotest").setup({
                icons = {
                    failed = commonicons.testing.Fail,
                    passed = commonicons.testing.Pass,
                    running = commonicons.testing.Running,
                    skipped = commonicons.testing.Skipped,
                    unknown = commonicons.testing.Unknown,
                },
                output = {
                    enabled = true,
                    open_on_run = "short",
                },
                status = {
                    virtual_text = true,
                },
                adapters = {
                    require("neotest-python")({
                        runner = "pytest",
                        dap = { justMyCode = false },
                        pytest_discover_instances = true,
                        python = ".venv/bin/python",
                        args = { "tests", "-vv", "--no-cov" },
                    }),
                },
                output_panel = {
                    enabled = true,
                    open = "botright split | resize 15",
                },
                summary = {
                    animated = false,
                },
            })
        end,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
        },
        keys = {
            map("<leader>us", function()
                require("neotest").summary.open()
            end, "Open unit-test summary window"),

            map("<leader>ut", function()
                require("neotest").run.run()
            end, "Run the nearest unit-test"),

            map("<leader>uT", function()
                require("neotest").run.run(vim.fn.expand("%"))
            end, "Run all unit-tests in the active buffer's file"),

            map("<leader>ud", function()
                require("neotest").run.run({ strategy = "dap" })
            end, "Run test with dap-ui debugging"),

            map("<leader>uD", function()
                require("neotest").run.run({ strategy = "dap" })
            end, "Run all tests in file with dap-ui debugging"),
        },
    },
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        event = VeryLazy,
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            {"theHamsta/nvim-dap-virtual-text", opts = {}, },
            "jay-babu/mason-nvim-dap.nvim",
            "williamboman/mason.nvim"
        },
        keys = {
            map("<F5>", function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    require("require('dap').ext.vscode").load_launchjs(nil, {
                        ["cppdbg"] = {
                            "cpp",
                            "c",
                            "rust",
                        },
                    })
                end
                require('dap').continue()
            end, "Continue"),
            map("<F1>", function() require('dap').step_into() end, "Step into"),
            map("<F2>", function() require('dap').step_over() end, "Step over"),
            map("<F3>", function() require('dap').step_out() end, "Step out"),
            map("<leader>dbb", function() require('dap').toggle_breakpoint() end, "Set breakpoint"),
            map("<leader>dbB", function()
                require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, "Set conditional breakpoint"),
            map("<leader>dbo", function() require('dapui').open() end, "Open"),
            map("<leader>dbc", function() require('dapui').close() end, "Close"),
            map("<leader>dbe", function() require('dapui').eval() end, "Evaluate"),
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            local icons = require('common.icons')

            require("config.dap.cpp").setup()
            require("config.dap.python").setup()

            vim.fn.sign_define("DapBreakpoint",
                { text = icons.ui.Circle, texthl = "DiagnosticError", linehl = "", numhl = "" })
            vim.fn.sign_define(
                "DapStopped",
                { text = icons.ui.ChevronRight, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" }
            )
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = icons.ui.CircleWithGap, texthl = "DiagnosticWarn", linehl = "", numhl = "" }
            )

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end

            dapui.setup({
                icons = { expanded = "", collapsed = "", current_frame = "" },
                expand_lines = true,
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                controls = {
                    element = "repl",
                    icons = {
                        pause = "󱤳",
                        play = "󱤵",
                        run_last = "󱑞",
                        step_back = "",
                        step_into = "󰆹",
                        step_out = "󰆸",
                        step_over = "󰆷",
                        terminate = "󱤷",
                    },
                },
                layouts = {
                    {
                        elements = {
                            { id = "repl",    size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 0.25,
                        position = "bottom",
                    },
                    {
                        elements = {
                            { id = "scopes",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                        },
                        size = 0.25,
                        position = "left",
                    },
                },
                floating = {
                    max_height = 0.9,
                    max_width = 0.5,
                    border = "rounded",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
            })

            require('mason-nvim-dap').setup({
                automatic_setup = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    python = function(config)
                        config.adapters = {
                            type = "executable",
                            command = require("mason-registry").get_package("debugpy"):get_install_path() ..
                                "/venv/bin/python3",
                            args = {
                                "-m",
                                "-debugpy.adapter",
                            },
                            require("mason-nvim-dap").default_setup(config)
                        }
                    end,
                },

                ensure_installed = {
                    "debugpy",
                    "cpptools",
                },
            })
        end,
    },
}
