return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = 'rounded',
        max_width = 100,
      }
    )

    lspconfig.gopls.setup {
      settings = {
        gopls = {
          staticcheck = true,
          gofumpt = true,
          analyses = {
            nilness = true,
            unusedwrite = true,
            shadow = false,
          },
          experimentalPostfixCompletions = false,
          hoverKind = "FullDocumentation",
          linksInHover = "gopls",
        },
      },
    }

    lspconfig.nil_ls.setup {
      settings = {
        ['nil'] = {
          formatting = {
            command = { "nixpkgs-fmt" },
          },
        },
      },
    }

    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      },
    }

    lspconfig.clangd.setup {
    }

    lspconfig.ts_ls.setup {
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false
    }

    lspconfig.svelte.setup {}

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>gd', ':vsplit | lua vim.lsp.buf.definition()<CR>', opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      end,
    })
  end
}
