local treesitter = require("plugins.treesitter")
local palette = require("xuantong.palette")
local chunk_helper = require("hlchunk.utils.chunkHelper")
local Scope = require("hlchunk.utils.scope")
local get_chunk_range = chunk_helper.get_chunk_range

-- hlchunk requests a parser on cursor movement even when highlighting is disabled.
-- Apply the shared file-size limit before it can parse a large buffer.
chunk_helper.get_chunk_range = function(opts)
  if opts and opts.use_treesitter and opts.pos and not treesitter.allow_treesitter(opts.pos.bufnr) then
    return chunk_helper.CHUNK_RANGE_RET.NO_CHUNK, Scope(opts.pos.bufnr, -1, -1)
  end
  return get_chunk_range(opts)
end

require("hlchunk").setup({
  chunk = {
    enable = true,
    use_treesitter = true,
    -- hlchunk's own limit disables this module for every buffer after one large file.
    -- The guard above applies our shared limit separately to each buffer.
    max_file_size = math.huge,
    style = { { fg = "#42A5F5" } },
    chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        right_arrow = ">",
    },
  },
  indent = {
    enable = false,
    chars = { "│", "¦", "┆", "┊" },
    use_treesitter = true,
  },
  blank = {
    enable = false,
    style = { "#666666", "#555555", "#444444" },
  },
  line_num = {
    enable = true,
    use_treesitter = true,
    style = palette.ansi[5],
  },
})
