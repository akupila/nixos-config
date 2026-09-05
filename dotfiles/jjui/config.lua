---@param config jjui.config
function setup(config)
  config.action("copy-change-id", function()
    local id = context.change_id()
    if id then
      copy_to_clipboard(id)
      flash("Copied change id: " .. id)
    end
  end, { key = "Y", scope = "revisions", desc = "copy change id" })

  config.action("new-after-selected", function()
    local id = context.change_id()
    if not id then
      return
    end
    local _, err = jj("new", "-A", id)
    if err then
      flash({ text = err, error = true })
      return
    end
    revisions.refresh()
  end, { key = "ctrl+n", scope = "revisions", desc = "new change after selected" })
end
