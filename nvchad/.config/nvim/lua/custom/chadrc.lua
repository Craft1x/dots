-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

--M.ui = {
 --  theme = "gruvchad",
--}

M.mappings = {
   -- custom = {}, -- custom user mappings

   misc = {
      copy_whole_file = "<leader>a" -- copy all contents of current buffer
   }
 }
return M
