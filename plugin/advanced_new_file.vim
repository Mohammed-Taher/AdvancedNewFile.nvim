" Title:        Advanced New File
" Description:  A plugin to provide an advanced method to create new files
" Last Change:  1 August 2022
" Maintainer:   Mohammed Taher <https://github.com/Mohammed-Taher>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_advenced_new_file")
    finish
endif
let g:loaded_advanced_new_file = 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/advanced_new_file/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 AdvancedNewFile lua require("advanced_new_file").run()
