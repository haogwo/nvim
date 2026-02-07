local M = {}

function M.setup()
  local ok, neogit = pcall(require, 'neogit')
  if not ok then
    vim.notify('[neogit] not found', vim.log.levels.WARN)
    return
  end

  neogit.setup({
    -- All settings are optional and can be left at their default values.
    -- For a full list of options, see :help neogit-configuration
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    -- Neogit refreshes its internal state after specific events
    auto_refresh = true,
    -- Value used for `--sort` option for `git branch` command
    -- By default, branches are sorted by commit date descending
    branch_sort_order = "committerdate:desc",
    -- Don't show the confirmation prompt when staging/unstaging/reverting normal files
    confirm_changes = false,
    -- Allows specifying the default commit message
    commit_editor = {
      kind = "split",
      -- Can be one of 'split', 'vsplit', 'tabnew'
    },
    -- The split orientation when opening things in a diff.
    -- Can be one of 'horizontal' or 'vertical'
    diff_orientation = "horizontal",
    -- The depth of the repository history to show.
    -- A value of 0 will show all history.
    history_graph_max_commits = 256,
    -- The time in ms to wait before refreshing the status buffer.
    refresh_timeout = 2000,
    -- The icons used to build the status buffer
    signs = {
      -- { CLOSED, OPEN }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    -- The integrations to enable.
    -- See :help neogit-integrations for more details
    integrations = {
      -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
      -- The diffview integration adds the option to open a diff in diffview.
      diffview = true,
    },
  })
end

return M
