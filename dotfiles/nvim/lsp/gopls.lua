return {
  cmd = { "gopls" },
  root_markers = { 'go.mod', 'go.work' },
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
