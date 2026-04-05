vim.g.dbs = {
  {
    name = "Starpro",
    url = "mysql://oms:ay2RHtC0X33bAzx2vAUC@192.168.1.133:3306/starpro?socket=/tmp/mysql.sock"
  },
}
return {
  -- 核心数据库引擎
  {
    "tpope/vim-dadbod",
  },

  -- UI 界面
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
