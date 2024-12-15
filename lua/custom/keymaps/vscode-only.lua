-- TODO: Change Leader from 'Space' to 'Ctrl+Space' to allow using it in Insert mode
-- TODO: Change LocalLeader from '\' to 'Ctrl+\' to allow using it in Insert mode
-- TODO: Use settings.cycler to replace multiple commands with a single toggle eg. pin/unpin etc.

-- [[ GLOBAL ]]---------------------------------------------------------------------------------------------------------
-- vim.keymap.set('n', 'z=', '<Cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>', {remap=true})
vim.keymap.set('n', '[d', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>', { remap = true })
vim.keymap.set('n', ']d', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>', { remap = true })

vim.keymap.set({ 'n', 'o', 'x' }, 'gc', '<Plug>VSCodeCommentary', { remap = true })
vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine', { remap = true })

-- [[ LEADER ]] --------------------------------------------------------------------------------------------------------
-- The Leader is used for global maps.
-- It needs to be defined before the first map is called so it's defined in init.lua

local mapL = function(key, cmd)
  vim.keymap.set('n', '<Leader>' .. key, '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>', { remap = true })
end

mapL('<Leader>', 'workbench.action.quickOpen') -- Ctrl+P
mapL(':', 'workbench.action.showCommands') -- Ctrl+Shift+P
-- mapL('`', 'workbench.action.quickOpenPreviousRecentlyUsedEditor')
-- mapL(',', 'workbench.action.showAllEditorsByMostRecentlyUsed')
mapL('<Tab>', 'workbench.action.showAllEditors')

-- [[ LOCAL-LEADER ]]---------------------------------------------------------------------------------------------------
-- The LocalLeader is used for mode/filetype specific maps
-- It needs to be defined before the first map is called so it's defined in init.lua

local mapLL = function(key, cmd)
  vim.keymap.set('n', '<LocalLeader>' .. key, '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>', { remap = true })
end
-- mapLL('<LocalLeader>', 'editor.action.goToDeclaration')

-- [[ BUFFER ]] --------------------------------------------------------------------------------------------------------
-- Bindings related to the buffer (editor)
local mapb = function(key, cmd)
  vim.keymap.set(
    'n',
    '<Plug>(leader-buffer-map)' .. key,
    '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>',
    { remap = true }
  )
end

-- mapb('a', 'workbench.action.showAllEditorsByMostRecentlyUsed')
mapb('b', 'workbench.action.showEditorsInActiveGroup')
mapb('B', 'workbench.action.showAllEditors')
mapb('c', 'workbench.action.closeActiveEditor')
mapb('C', 'workbench.action.closeUnmodifiedEditors')
mapb('d', 'workbench.action.closeEditorInAllGroups') -- similar to vim's buf(d)elete
mapb('H', 'workbench.action.moveEditorLeftInGroup')
mapb('J', 'workbench.action.moveEditorToFirstGroup')
mapb('K', 'workbench.action.moveEditorToLastGroup')
mapb('L', 'workbench.action.moveEditorRightInGroup')
mapb('n', 'workbench.action.nextEditorInGroup')
mapb('o', 'workbench.action.closeOtherEditors')
mapb('p', 'workbench.action.previousEditorInGroup')
mapb('r', 'workbench.action.files.revert')
mapb('s', 'workbench.action.toggleSplitEditorInGroup')
mapb('S', 'workbench.action.toggleSplitEditorInGroupLayout')
mapb('u', 'workbench.action.reopenClosedEditor') --  (u)ndo close
mapb('x', 'workbench.action.pinEditor')
mapb('X', 'workbench.action.unpinEditor')
mapb('y', 'copyFilePath') -- (y)ank file-path. doom also uses 'y'
mapb('`', 'workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')

-- [[ EDITOR-GROUPS ]] -------------------------------------------------------------------------------------------------
-- Bindings related to the editor-group (window)
local mapw = function(key, cmd)
  vim.keymap.set(
    'n',
    '<Plug>(leader-window-map)' .. key,
    '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>',
    { remap = true }
  )
end

mapw('c', 'workbench.action.closeGroup')
mapw('C', 'workbench.action.closeAllGroups')
mapw('h', 'workbench.action.focusLeftGroup')
mapw('j', 'workbench.action.focusBelowGroup')
mapw('k', 'workbench.action.focusAboveGroup')
mapw('l', 'workbench.action.focusRightGroup')
mapw('H', 'workbench.action.moveActiveEditorGroupLeft')
mapw('J', 'workbench.action.moveActiveEditorGroupDown')
mapw('K', 'workbench.action.moveActiveEditorGroupUp')
mapw('L', 'workbench.action.moveActiveEditorGroupRight')
mapw('u', 'workbench.action.joinAllGroups') --  (u)nite all groups
mapw('w', 'workbench.action.navigateEditorGroups')
mapw('z', 'workbench.action.toggleMaximizeEditorGroup') --  (z)oom in/out or maximi(z)e
mapw('=', 'workbench.action.evenEditorWidths')

-- [[ CODE ]] ----------------------------------------------------------------------------------------------------------
-- Bindings that act upon or affect the code
local mapc = function(key, cmd)
  vim.keymap.set('n', '<Plug>(leader-code-map)' .. key, '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>', { remap = true })
end

mapc('r', 'editor.action.rename')
-- mapc('cc', 'editor.action.transformToCamelcase')
-- mapc('cm', 'editor.action.transformToCamelcase')
-- mapc('cp', 'editor.action.transformToCamelcase')
-- mapc('ck', 'editor.action.transformToKebabcase')
-- mapc('c-', 'editor.action.transformToKebabcase')
-- mapc('cl', 'editor.action.transformToLowercase')
-- mapc('cs', 'editor.action.transformToSnakecase')
-- mapc('ct', 'editor.action.transformToTitlecase')
-- mapc('cu', 'editor.action.transformToUppercase')
-- mapc('cU', 'editor.action.transformToUppercase')

-- [[ GOTO ]] ----------------------------------------------------------------------------------------------------------
local mapg = function(key, cmd)
  vim.keymap.set('n', '<Plug>(leader-goto-map)' .. key, '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>', { remap = true })
end

-- General pattern followed in defining these bindings
--   (d)efinitions, (h)ierarchy, de(k)larations, (i)mplementation, symb(o)l, (r)eferences, (t)ypes
-- These are then combined with modifiers to specify how it should be shown
--   k      : to peek as 'K' is used to show hover information and this is kinda similar
--   Ctrl+W : Open on the side

mapg('d', 'editor.action.revealDefinition')
mapg('kd', 'editor.action.peekDefinition')
mapg('<C-w>d', 'editor.action.revealDefinitionAside')

mapg('D', 'editor.action.revealDeclaration')
mapg('kD', 'editor.action.peekDeclaration')
vim.keymap.set('n', '<Plug>(leader-goto-map)<C-w>D', function()
  VSCodeNotify 'editor.action.openDeclarationToTheSide'
  VSCodeNotify 'editor.action.revealDeclaration'
end, { remap = true })
-- editor.action.previewDeclaration

mapg('h', 'references-view.showCallHierarchy')
mapg('o', 'workbench.action.gotoSymbol')
mapg('O', 'workbench.action.showAllSymbols')
mapg('r', 'editor.action.goToReferences')
mapg('kr', 'editor.action.referenceSearch.trigger') -- VSCode calls this 'Peek References'

-- [[ FILE ]] ----------------------------------------------------------------------------------------------------------
-- Bindings that act upon or affect the code
local mapf = function(key, cmd)
  vim.keymap.set('n', '<Plug>(leader-file-map)' .. key, '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>', { remap = true })
end

mapf('y', 'copyFilePath') -- (y)ank file-path. doom also uses 'y'

-- [[ INFO ]] ----------------------------------------------------------------------------------------------------------
local mapi = function(key, cmd)
  vim.keymap.set('n', '<Plug>(leader-info-map)' .. key, '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>', { remap = true })
end

mapi('k', 'workbench.action.openGlobalKeybindings')
mapi('K', 'workbench.action.openDefaultKeybindingsFile')
mapi('p', 'workbench.actions.view.problems')

-- [[ PROJECTS/FOLDERS/WORKSPACES ]] -----------------------------------------------------------------------------------
local mapp = function(key, cmd)
  vim.keymap.set(
    'n',
    '<Plug>(leader-project-map)' .. key,
    '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>',
    { remap = true }
  )
end

mapp('p', 'workbench.action.openRecent')

-- [[ SEARCH ]] --------------------------------------------------------------------------------------------------------
local maps = function(key, cmd)
  vim.keymap.set(
    'n',
    '<Plug>(leader-search-map)' .. key,
    '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>',
    { remap = true }
  )
end

maps('r', 'references-view.findReferences')

-- [[ TOGGLE ]] --------------------------------------------------------------------------------------------------------
-- Editor-agnostic toggle keybinds go here while anything that is specific to VSCode should go in '<Leader>k'
local mapt = function(key, cmd)
  vim.keymap.set(
    'n',
    '<Plug>(leader-toggle-map)' .. key,
    '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>',
    { remap = true }
  )
end

mapt('i', 'settings.cycle.editor-guides-indentation')
mapt('b', 'settings.cycle.editor-guides-bracketPairs')
mapt('n', 'settings.cycle.editor-lineNumbers')
mapt('s', 'settings.cycle.editor-occurencesHighlight')
mapt('t', 'workbench.action.toggleLightDarkThemes')
mapt('w', 'editor.action.toggleWordWrap')
mapt('<Tab>', 'workbench.action.toggleTabsVisibility')

-- [[ UI ]] ------------------------------------------------------------------------------------------------------------
-- Bindings specific to the VSCode application. VSCode seems to use Ctrl+K a lot
-- Other editor-agnostic toggle keybinds go in '<Leader>t'
local mapu = function(key, cmd)
  vim.keymap.set(
    'n',
    '<Plug>(leader-kustomize-map)' .. key,
    '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>',
    { remap = true }
  )
end

mapu('b', 'workbench.action.toggleSidebarVisibility')
mapu('B', 'workbench.action.toggleAuxiliaryBar')
mapu('e', 'workbench.view.explorer')
mapu('f', 'workbench.explorer.fileView.focus')
mapu('x', 'workbench.view.extensions')
mapu('o', 'outline.focus')
mapu('p', 'workbench.action.togglePanel')
mapu('P', 'workbench.action.toggleMaximizedPanel')
mapu('s', 'workbench.action.toggleStatusbarVisibility')
mapu('t', 'workbench.action.selectTheme')
mapu('v', 'workbench.view.scm') -- version-control
mapu('z', 'workbench.action.toggleZenMode')
mapu(',', 'workbench.action.openSettings2') -- Similar to MacOS
mapu('_', 'workbench.action.toggleMenuBar') -- Menus have underscores for selection
mapu('>', 'breadcrumbs.toggle') -- breadcrumbs use '>' for separators
mapu('`', 'workbench.action.terminal.toggleTerminal')

-- Menu-like behavior use Ctrl maps
mapu('<C-v>', 'workbench.action.quickOpenView')
mapu('<C-l>', 'workbench.action.customizeLayout')

-- [[ VCS ]] -----------------------------------------------------------------------------------------------------------
local mapv = function(key, cmd)
  vim.keymap.set('n', '<Plug>(leader-vcs-map)' .. key, '<Cmd>call VSCodeNotify("' .. cmd .. '")<CR>', { remap = true })
end

mapv('a', 'perforce.annotate')
mapv('d', 'perforce.diff')
mapv('e', 'perforce.edit')
mapv('s', 'perforce.opened') -- (s)tatus
