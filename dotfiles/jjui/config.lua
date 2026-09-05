---@param config jjui.config
function setup(config)
  config.action("copy-change-id", function()
    local id = context.change_id()
    if id then
      copy_to_clipboard(id)
      flash("Copied change id: " .. id)
    end
  end, { key = "Y", scope = "revisions", desc = "copy change id" })
end
