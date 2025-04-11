return {
	"sindrets/diffview.nvim",
	config = function()
		local actions = require("diffview.actions")

		require("diffview").setup({
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
			keymaps = {
				view = {
					{
						"n",
						"<up>",
						actions.prev_conflict,
						{
							desc = "In the merge-tool: jump to the previous conflict",
						},
					},
					{
						"n",
						"<down>",
						actions.next_conflict,
						{ desc = "In the merge-tool: jump to the next conflict" },
					},
					{
						"n",
						"<left>",
						actions.conflict_choose("ours"),
						{ desc = "Choose the OURS version of a conflict" },
					},
					{
						"n",
						"<right>",
						actions.conflict_choose("theirs"),
						{ desc = "Choose the THEIRS version of a conflict" },
					},
				},
			},
		})
	end,
}
