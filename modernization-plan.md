# Neovim Configuration Modernization Plan

**Date:** October 25, 2025  
**Configuration:** NBurley93/neovim-dotfiles

---

## Executive Summary

Your Neovim configuration is well-structured and modern in many aspects, utilizing cutting-edge plugins like `blink.cmp` and Neovim's native LSP. However, there are several areas where improvements can enhance maintainability, performance, consistency, and leverage newer Neovim 0.10+ features.

---

## Areas for Improvement

### 1. **LSP Configuration - Transition Fully to Native `vim.lsp.config()`**

**Current State:**

- Using custom `lsp_backend.lua` wrapper around `vim.lsp.config()` and `vim.lsp.enable()`
- Good adoption of Neovim 0.10+ native LSP configuration
- Some redundancy in the abstraction layer

**Issues:**

- The `make_lsp_config()` helper adds minimal value but increases indirection
- Could leverage more of the native LSP features directly
- Capabilities aren't being extended with completion plugin capabilities

**Recommendations:**

- [ ] **Simplify LSP backend** - Remove the `make_lsp_config()` wrapper and use `vim.lsp.config()` directly in `lua/config/lsp.lua`
- [ ] **Add blink.cmp capabilities** - Integrate `blink.cmp` capabilities into LSP server configurations:
  ```lua
  local capabilities = require('blink.cmp').get_lsp_capabilities()
  ```
- [ ] **Consolidate on_attach logic** - Move all keybindings and on_attach logic to a single location for better maintainability
- [ ] **Use vim.lsp.config defaults** - Leverage the new default configuration system instead of manually setting common options

**Priority:** High  
**Estimated Effort:** 2-3 hours

---

### 2. **Keymap Organization and Discoverability**

**Current State:**

- Keymaps split across multiple files in `lua/config/keymaps/`
- Base mappings in `init.lua`, LSP in `lsp.lua`, etc.
- Using `which-key.nvim` but not fully leveraging it for organization

**Issues:**

- No consistent naming convention for leader key groups
- Some keymaps lack descriptions
- Difficult to discover available keybindings
- LSP keymaps are set per-buffer but not well-documented

**Recommendations:**

- [ ] **Create keymap groups with which-key** - Define all leader groups explicitly:
  ```lua
  require('which-key').add({
    { "<leader>f", group = "Find/Telescope" },
    { "<leader>g", group = "Git" },
    { "<leader>u", group = "Unit Testing" },
    { "<leader>w", group = "Word/Window" },
  })
  ```
- [ ] **Add descriptions to all keymaps** - Ensure every keymap has a meaningful description
- [ ] **Create a keymap reference document** - Generate a markdown file listing all keybindings
- [ ] **Consolidate similar mappings** - Group related functionality (e.g., all git operations under `<leader>g`)

**Priority:** Medium  
**Estimated Effort:** 2-4 hours

---

### 3. **Plugin Management and Lazy Loading**

**Current State:**

- Using `lazy.nvim` for plugin management
- Some plugins lazy-load on events/commands
- Several plugins load unnecessarily early or not lazy at all

**Issues:**

- `blink.cmp` is set to `lazy = false` - could use better loading strategy
- Many plugins load on `BufReadPost` and `BufNewFile` which happens frequently
- No clear loading strategy documentation
- Some plugins that could be command-lazy aren't

**Recommendations:**

- [ ] **Optimize blink.cmp loading** - Consider loading on `InsertEnter` instead of immediately:
  ```lua
  event = "InsertEnter",
  ```
- [ ] **Defer non-essential UI plugins** - Load colorizers, statusline enhancements after VimEnter
- [ ] **Use VeryLazy event** - For plugins that don't need immediate loading (e.g., git-conflict, rainbow_csv)
- [ ] **Profile startup time** - Use `:Lazy profile` to identify slow plugins
- [ ] **Document loading strategies** - Add comments explaining why each plugin loads when it does

**Priority:** Medium  
**Estimated Effort:** 3-4 hours

---

### 4. **Completion Configuration Enhancement**

**Current State:**

- Using `blink.cmp` which is excellent and modern
- Copilot integration working
- Basic configuration in place

**Issues:**

- Not leveraging all blink.cmp features
- Menu and documentation borders are commented out
- Could benefit from signature help integration
- No snippet configuration beyond defaults

**Recommendations:**

- [ ] **Enable signature help** - Add signature help window configuration
- [ ] **Customize completion menu** - Uncomment and configure menu borders/highlighting to match theme
- [ ] **Add snippet keybindings** - Configure explicit snippet expansion keybindings
- [ ] **Configure source priorities** - Fine-tune source priorities based on context:
  ```lua
  sources = {
    default = function(ctx)
      if ctx.filetype == "gitcommit" then
        return { "git", "buffer" }
      end
      return { "lsp", "path", "buffer", "copilot" }
    end,
  }
  ```
- [ ] **Add completion transformers** - Use blink.cmp transformers for better filtering

**Priority:** Low-Medium  
**Estimated Effort:** 2 hours

---

### 5. **Null-ls/None-ls Modernization**

**Current State:**

- Using `none-ls.nvim` (maintained fork of null-ls)
- Multiple formatters and linters configured
- Custom unwrapping function for source groups

**Issues:**

- Many tools (ruff, yamlfmt, stylua) now have native LSP support
- Duplicate functionality with LSP servers
- `unwrap_groups()` function is unnecessary complexity
- terraform_validate may conflict with terraformls

**Recommendations:**

- [ ] **Migrate to native LSP formatters** - Remove formatters that have LSP equivalents:
  - Use `ruff` LSP for Python formatting (already configured)
  - Use `terraformls` built-in formatting
  - Keep `stylua` via none-ls (no LSP alternative)
- [ ] **Simplify source configuration** - Remove the grouping system:
  ```lua
  sources = {
    formatting.stylua,
    diagnostics.yamllint,
    diagnostics.hadolint,
    diagnostics.commitlint,
  }
  ```
- [ ] **Use conform.nvim** - Consider migrating to `conform.nvim` for formatting:
  - Better async support
  - More flexible configuration
  - Active development

**Priority:** Medium-High  
**Estimated Effort:** 3-4 hours

---

### 6. **Autocommand Organization**

**Current State:**

- Autocommands defined in `lua/config/autocommands.lua`
- Using modern `vim.api.nvim_create_autocmd` API
- Multiple autogroups for organization

**Issues:**

- `AutoformatFTCommands()` uses silent shell command which can fail silently
- No error handling for external formatters
- `realpath()` function defined but never used
- Copilot autocommands could be moved to the Copilot plugin config

**Recommendations:**

- [ ] **Add error handling** - Wrap shell commands in pcall:
  ```lua
  callback = function()
    local fname = vim.api.nvim_buf_get_name(0)
    local ok, err = pcall(function()
      vim.cmd(":!tex-fmt " .. vim.fn.shellescape(fname))
    end)
    if not ok then
      vim.notify("tex-fmt failed: " .. err, vim.log.levels.ERROR)
    end
  end,
  ```
- [ ] **Move plugin-specific autocommands** - Relocate Copilot autocommands to `lua/plugins/ai.lua`
- [ ] **Remove unused code** - Delete the `realpath()` function
- [ ] **Use FileType events** - Replace BufReadPost/BufNewFile with FileType where appropriate

**Priority:** Low-Medium  
**Estimated Effort:** 1-2 hours

---

### 7. **Error Handling and Robustness**

**Current State:**

- Minimal error handling in most module configs
- Some use of pcall (e.g., treesitter update)
- No graceful degradation for missing dependencies

**Issues:**

- Configuration will break if required modules are missing
- No user-friendly error messages
- Silent failures in some places (e.g., theme loading prints to command line)

**Recommendations:**

- [ ] **Add error handling to all configs** - Wrap require calls in pcall:
  ```lua
  local ok, module = pcall(require, "module-name")
  if not ok then
    vim.notify("Failed to load module-name: " .. module, vim.log.levels.ERROR)
    return
  end
  ```
- [ ] **Use vim.notify for user feedback** - Replace print statements with vim.notify
- [ ] **Validate plugin availability** - Check if plugins exist before configuring them
- [ ] **Create fallback configurations** - Provide minimal functionality if plugins fail to load

**Priority:** Medium  
**Estimated Effort:** 2-3 hours

---

### 8. **Testing Infrastructure**

**Current State:**

- Neotest configured for Python with pytest
- Basic configuration in place
- Custom keybindings defined

**Issues:**

- Hardcoded Python path (`.venv/bin/python`) won't work on Windows
- No testing support for other languages (C++, Go, Rust mentioned in LSP config)
- Limited test discovery configuration

**Recommendations:**

- [ ] **Platform-aware Python path** - Detect virtual environment dynamically:
  ```lua
  python = function()
    local venv = vim.fn.getcwd() .. "/.venv"
    if vim.fn.has("win32") == 1 then
      return venv .. "\\Scripts\\python.exe"
    else
      return venv .. "/bin/python"
    end
  end,
  ```
- [ ] **Add language-specific adapters** - Install adapters for other languages:
  - `neotest-rust` for Rust
  - `neotest-go` for Go
  - `neotest-gtest` or similar for C++
- [ ] **Configure test output** - Better integration with diagnostics
- [ ] **Add debug testing** - Integrate with DAP for debugging tests

**Priority:** Low  
**Estimated Effort:** 2-3 hours

---

### 9. **Documentation and Comments**

**Current State:**

- README.md is minimal
- Some inline comments in configs
- No architecture documentation

**Issues:**

- README doesn't explain the structure
- No plugin selection rationale documented
- Custom backends (ai_backend, lsp_backend) lack documentation
- No contribution guidelines

**Recommendations:**

- [ ] **Expand README.md** - Add sections for:
  - Directory structure explanation
  - Plugin philosophy and selection criteria
  - Installation instructions (including dependencies)
  - Configuration approach (why certain plugins were chosen)
  - Customization guide
- [ ] **Document custom modules** - Add module-level documentation:
  ```lua
  --- LSP Backend Configuration
  --- This module provides a wrapper around Neovim's native LSP configuration
  --- to standardize server setup across the configuration.
  --- @module lsp_backend
  ```
- [ ] **Create ARCHITECTURE.md** - Document the configuration architecture
- [ ] **Add inline comments** - Explain non-obvious configuration choices
- [ ] **Document external dependencies** - List all tools needed (ripgrep, fd, etc.)

**Priority:** Medium  
**Estimated Effort:** 3-4 hours

---

### 10. **Configuration Module Loading**

**Current State:**

- Custom module loader in `lua/config/init.lua`
- Optional profiling support (disabled)
- Sequential loading with error messages

**Issues:**

- `PROFILE_CONFIG_MODULES` code path is dead code (always false)
- Profiling uses `os.clock()` which isn't accurate for async operations
- Error handling prints to stdout instead of using notifications
- Loading order is implicit in the array

**Recommendations:**

- [ ] **Remove dead code** - Delete the profiling code or make it functional:
  ```lua
  local PROFILE_CONFIG_MODULES = vim.env.NVIM_PROFILE_CONFIG == "1"
  ```
- [ ] **Use vim.notify for errors** - Replace print statements
- [ ] **Add dependency tracking** - Document why modules load in specific order
- [ ] **Use Neovim's profiling** - Leverage `:profile` command instead of custom solution
- [ ] **Add load failure recovery** - Continue loading other modules if one fails

**Priority:** Low  
**Estimated Effort:** 1-2 hours

---

### 11. **Git Integration Optimization**

**Current State:**

- Multiple git plugins: fugitive, rhubarb, gitsigns, diffview, octo, git-conflict
- Good coverage of git functionality

**Issues:**

- `vim-fugitive` and `vim-rhubarb` are VimScript plugins (heavier than Lua alternatives)
- Potential feature overlap between plugins
- `octo.nvim` uses deprecated `requires` instead of `dependencies`
- No lazy loading for git plugins

**Recommendations:**

- [ ] **Consider Neogit** - Evaluate replacing fugitive with neogit.nvim (pure Lua):
  ```lua
  { "NeogitOrg/neogit", dependencies = "nvim-lua/plenary.nvim" }
  ```
- [ ] **Lazy load git plugins** - Most git plugins only needed when working with git:
  ```lua
  event = { "BufReadPre", "BufNewFile" },
  cond = function()
    return vim.fn.isdirectory(".git") == 1
  end,
  ```
- [ ] **Fix octo.nvim config** - Update `requires` to `dependencies`
- [ ] **Consolidate git keybindings** - Ensure all git commands use consistent leader group

**Priority:** Low-Medium  
**Estimated Effort:** 2-3 hours

---

### 12. **Theming and UI Consistency**

**Current State:**

- Multiple colorschemes installed (catppuccin, girlfailure, mallgoth, hackerman, cyberpunk_scarlet)
- Currently using "girlfailure"
- Theme system with dynamic loading exists but is commented out
- Border styles inconsistent across plugins

**Issues:**

- Many unused colorschemes taking up space
- Commented-out theme system suggests indecision
- Border styles vary: "solid", "rounded", "single", default
- Transparency settings commented out
- No consistent UI design language

**Recommendations:**

- [ ] **Choose and stick with one theme** - Remove unused colorschemes:
  - Keep 1-2 favorites
  - Remove the rest to reduce clutter
- [ ] **Standardize border styles** - Pick one border style and apply consistently:
  ```lua
  local border = "rounded" -- or "single" or "solid"
  ```
- [ ] **Create UI constants** - Define borders, highlights in one place:
  ```lua
  -- lua/common/ui.lua
  return {
    border = "rounded",
    winblend = 0,
    pumblend = 15,
  }
  ```
- [ ] **Either use or remove theme system** - Uncomment and use the dynamic theme system, or remove it
- [ ] **Consistent highlight groups** - Ensure plugins use same highlight groups for similar elements

**Priority:** Low  
**Estimated Effort:** 2 hours

---

### 13. **Platform-Specific Configuration**

**Current State:**

- Good Windows/WSL detection in `lua/config/options.lua`
- PowerShell configuration for Windows
- WSL clipboard handling
- Shell detection for Unix systems

**Issues:**

- WSL detection logic may not work correctly (`isWSLWindows` seems wrong)
- No macOS-specific configuration
- Path handling isn't consistently platform-aware (see testing.lua)

**Recommendations:**

- [ ] **Fix WSL detection** - The logic `isWindows and isWSL` would always be false:
  ```lua
  local isWindows = vim.fn.has('win32') == 1
  local isWSL = vim.fn.has('wsl') == 1
  -- WSL won't have both true at the same time
  ```
- [ ] **Add macOS support** - Detect and configure for macOS:
  ```lua
  local isMac = vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1
  ```
- [ ] **Create platform utility module** - Centralize platform detection:
  ```lua
  -- lua/common/platform.lua
  local M = {}
  M.is_windows = vim.fn.has('win32') == 1
  M.is_wsl = vim.fn.has('wsl') == 1
  M.is_mac = vim.fn.has('mac') == 1
  M.is_linux = not (M.is_windows or M.is_mac)
  return M
  ```
- [ ] **Use platform-aware paths** - Apply throughout configuration

**Priority:** High (if using WSL)  
**Estimated Effort:** 2 hours

---

### 14. **Telescope Configuration Enhancement**

**Current State:**

- Telescope configured with good defaults
- UI-select integration
- Undo and git-branch extensions
- Custom borderchars

**Issues:**

- Commented-out prompt and selection icons
- No file ignore patterns configured
- Default ripgrep args not customized
- No custom pickers defined
- Missing useful extensions (e.g., fzf-native for performance)

**Recommendations:**

- [ ] **Add telescope-fzf-native** - Significantly faster fuzzy finding:
  ```lua
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  }
  ```
- [ ] **Configure ignore patterns** - Exclude node_modules, .git, etc.:
  ```lua
  file_ignore_patterns = { "%.git/", "node_modules/", "%.cache/" }
  ```
- [ ] **Add custom pickers** - Create project-specific search patterns
- [ ] **Configure preview settings** - Limit preview size for large files
- [ ] **Add more extensions** - Consider: aerial (symbol search), project (project management)

**Priority:** Medium  
**Estimated Effort:** 1-2 hours

---

### 15. **Treesitter Configuration**

**Current State:**

- Good language coverage
- Context plugin installed
- File size-based disabling
- Textobjects dependency

**Issues:**

- `auto_install = false` means languages must be manually specified
- `context_commentstring` is configured but the plugin isn't installed
- Not using textobjects features
- No incremental selection configured
- Missing some useful parsers (bash, regex fully featured)

**Recommendations:**

- [ ] **Enable auto_install** - Or keep false but document why:
  ```lua
  auto_install = true, -- Auto-install parsers when entering buffer
  ```
- [ ] **Remove context_commentstring** - Plugin is archived, use `Comment.nvim`'s built-in support
- [ ] **Configure textobjects** - Add textobject keybindings:
  ```lua
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
  }
  ```
- [ ] **Add incremental selection** - Enable smart selection expansion
- [ ] **Document language choices** - Explain which parsers are installed and why

**Priority:** Low-Medium  
**Estimated Effort:** 1-2 hours

---

### 16. **Harpoon Integration**

**Current State:**

- Harpoon 2 installed
- No configuration or keybindings found

**Issues:**

- Plugin installed but not configured
- No keybindings set up
- Likely not being used effectively
- Using deprecated `requires` instead of `dependencies`

**Recommendations:**

- [ ] **Add Harpoon keybindings** - Create useful mappings:
  ```lua
  local harpoon = require('harpoon')
  vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
  vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
  -- etc.
  ```
- [ ] **Configure Harpoon** - Set up Harpoon 2 properly in plugin config
- [ ] **Update dependencies syntax** - Change `requires` to `dependencies`
- [ ] **Document or remove** - Either use it properly or remove the plugin

**Priority:** Low  
**Estimated Effort:** 1 hour

---

### 17. **Diagnostic Configuration**

**Current State:**

- Trouble.nvim configured
- Diagnostic signs defined in `common/defines.lua`
- LSP colors plugin included

**Issues:**

- No virtual text configuration
- Float preview settings not customized
- Severity sorting not configured
- Update in insert mode could be distracting
- No jump to diagnostic keybindings centralized

**Recommendations:**

- [ ] **Configure virtual text** - Customize or disable based on preference:
  ```lua
  vim.diagnostic.config({
    virtual_text = {
      prefix = '●',
      source = 'if_many',
    },
  })
  ```
- [ ] **Add diagnostic keybindings** - Centralize in base keymaps:
  ```lua
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
  ```
- [ ] **Configure float appearance** - Match UI theme
- [ ] **Set update timing** - Control when diagnostics update

**Priority:** Low  
**Estimated Effort:** 1 hour

---

### 18. **Custom AI Backend Architecture**

**Current State:**

- Custom AI backend system with provider abstraction
- Support for GitHub Copilot Business endpoint
- Chutes provider support
- Well-organized backend system

**Issues:**

- No documentation explaining what Chutes is
- Environment variable check for business endpoint is undocumented
- Provider override happens globally
- No error handling if provider fails

**Recommendations:**

- [ ] **Document AI backends** - Add README in `lua/common/ai_backends/`:
  - Explain what each backend is
  - How to configure environment variables
  - When to use each provider
- [ ] **Add error handling** - Validate environment before overriding provider
- [ ] **Make provider selection explicit** - Use configuration file instead of env vars:
  ```lua
  -- lua/config/ai.lua
  return {
    provider = "copilot", -- or "chutes"
    use_business_endpoint = false,
  }
  ```
- [ ] **Add provider validation** - Check if selected provider is available

**Priority:** Low  
**Estimated Effort:** 1-2 hours

---

### 19. **Performance Optimization**

**Current State:**

- Using Snacks.nvim for bigfile handling
- Some lazy loading in place
- No comprehensive performance monitoring

**Issues:**

- No startup time benchmarking
- Bigfile threshold is 1.5MB (could be lower)
- Many plugins load on common events
- No caching strategy documented

**Recommendations:**

- [ ] **Benchmark startup** - Measure and document baseline:
  ```bash
  nvim --startuptime startup.log
  ```
- [ ] **Optimize bigfile threshold** - Reduce to 500KB or 1MB
- [ ] **Defer UI plugins** - Load non-essential UI after startup:
  ```lua
  event = "VeryLazy"
  ```
- [ ] **Profile plugin load times** - Use `:Lazy profile` to identify slow plugins
- [ ] **Consider compilation** - Use lazy.nvim's compilation feature:
  ```lua
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = { "netrw", "tohtml", "tutor" },
    },
  }
  ```
- [ ] **Document performance targets** - Set and maintain startup time goals

**Priority:** Medium  
**Estimated Effort:** 2-3 hours

---

### 20. **Missing Functionality Opportunities**

**Current State:**

- Solid foundation with modern plugins
- Good LSP, completion, and git support

**Potential Additions:**

- Debug Adapter Protocol (DAP) support
- Session management
- Project management
- Todo comments highlighting
- Better markdown support
- Terminal integration

**Recommendations:**

- [ ] **Add DAP support** - For debugging:
  ```lua
  { "mfussenegger/nvim-dap" }
  { "rcarriga/nvim-dap-ui" }
  ```
- [ ] **Add todo-comments.nvim** - Highlight TODO, FIXME, etc.
- [ ] **Improve markdown** - Add markdown preview and better rendering
- [ ] **Add project management** - `ahmedkhalf/project.nvim` or similar
- [ ] **Consider session management** - Auto-save/restore sessions
- [ ] **Add better terminal** - `akinsho/toggleterm.nvim` or similar
- [ ] **Add snippet management** - Better snippet workflow with LuaSnip

**Priority:** Low (Quality of life)  
**Estimated Effort:** Varies (1-4 hours per feature)

---

## Implementation Roadmap

### Phase 1: Critical Fixes (Week 1)

1. Fix WSL detection logic (#13)
2. Add blink.cmp capabilities to LSP (#1)
3. Simplify LSP backend (#1)
4. Migrate formatters from null-ls to native LSP (#5)

### Phase 2: Quality Improvements (Week 2-3)

5. Add error handling throughout (#7)
6. Standardize keymaps with which-key (#2)
7. Optimize plugin loading (#3)
8. Fix platform-specific paths (#13)

### Phase 3: Polish and Documentation (Week 4)

9. Improve documentation (#9)
10. Standardize UI/theming (#12)
11. Configure Telescope enhancements (#14)
12. Add diagnostic keybindings (#17)

### Phase 4: Optional Enhancements (Ongoing)

13. Performance optimization (#19)
14. Add missing functionality (#20)
15. Enhance testing infrastructure (#8)

---

## Metrics for Success

- **Startup time:** < 100ms (current: measure with `nvim --startuptime`)
- **LSP attach time:** < 500ms
- **Code coverage:** 80%+ of config has error handling
- **Documentation:** Every custom module documented
- **Consistency:** All plugins use same border style
- **Keymap discoverability:** All leader keys registered with which-key

---

## Notes

- This configuration is already quite good and modern
- Many suggestions are polish/nice-to-have rather than critical
- Focus on Phase 1 for immediate improvements
- Consider your actual usage patterns when prioritizing
- The "cutting-edge" approach is commendable but be prepared for breaking changes

---

## Questions for Consideration

1. Do you actually use all the installed themes? (Remove unused ones)
2. Is Harpoon configured elsewhere or should it be removed?
3. What's the Chutes AI backend? (Add documentation)
4. Do you need both fugitive and potential Neogit?
5. What languages do you primarily work in? (Optimize for those)
