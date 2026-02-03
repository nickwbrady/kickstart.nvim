# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a fork of kickstart.nvim - a minimal, single-file Neovim configuration. The design philosophy is intentionally simple: one main `init.lua` file with optional modular plugins in `lua/kickstart/plugins/`.

## Commands

**Lua formatting:**
```bash
stylua .                    # Format all Lua files
stylua --check .            # Check formatting (used in CI)
```

**Neovim health check:**
```vim
:checkhealth kickstart      " Check config requirements
```

**Plugin management (inside Neovim):**
```vim
:Lazy                       " View plugin status
:Lazy update                " Update all plugins
:Mason                      " Manage LSP servers and tools
```

## Code Style

Lua files must follow `.stylua.toml`:
- 2 spaces for indentation
- 160 column width
- Single quotes preferred
- No call parentheses for simple function calls
- Collapse simple statements to single line

## Architecture

**Entry point:** `init.lua` (~1200 lines)
- Contains all core configuration: options, keymaps, autocommands
- Bootstraps lazy.nvim plugin manager
- Defines all plugin specifications inline
- Configures LSP servers (clangd, pyright, ruff, cmake, lua_ls)

**Plugin structure:**
- `lua/kickstart/plugins/` - Optional plugins (autopairs, debug, gitsigns, indent_line, lint, neo-tree)
- `lua/custom/plugins/` - User customizations (currently empty, import commented out in init.lua)

**Key files:**
- `lazy-lock.json` - Plugin version lock file (28 plugins pinned)
- `color` - Single word file controlling light/dark theme mode
- `doc/kickstart.txt` - Vim help documentation

## External Dependencies

Required: git, make, unzip, gcc, ripgrep (rg)
Optional: fd-find, Nerd Font, clipboard tool (xclip/xsel)

Neovim version: 0.11+ required

## LSP Configuration

Language servers are configured in `init.lua` under the `servers` table. Mason auto-installs configured servers. To add a new language server, add it to the `servers` table with its configuration options.
