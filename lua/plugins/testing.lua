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
        },
    },
}
