
-- because of boxen, add those lua paths
package.path = package.path .. ';/opt/boxen/homebrew/share/lua/5.2/?.lua'
package.cpath = package.cpath .. ';/opt/boxen/homebrew/lib/lua/5.2/?.so'

mjolnir.application = require "mjolnir.application"
mjolnir.window = require "mjolnir.window"
mjolnir.hotkey = require "mjolnir.hotkey"
mjolnir.fnutils = require "mjolnir.fnutils"
local grid = require "grid"

local mash = {"cmd", "ctrl"}
-- local mashshift = {"cmd", "alt", "shift"}

-- requires: grid, core.fnutils, core.alert

mjolnir.hotkey.bind(mash, "T", function() mjolnir.application.launchorfocus("Terminal") end)
mjolnir.hotkey.bind(mash, "C", function() mjolnir.application.launchorfocus("iTerm") end)
mjolnir.hotkey.bind(mash, "B", function() mjolnir.application.launchorfocus("Google Chrome") end)

-- status light options
mjolnir.hotkey.bind(mash, "S", function() os.execute('/Users/nate/bin/excluded/blink1-tool --red') end)
mjolnir.hotkey.bind(mash, "D", function() os.execute('/Users/nate/bin/excluded/blink1-tool --green') end)

mjolnir.hotkey.bind(mash, ';', function() grid.snap(core.window.focusedwindow()) end)
mjolnir.hotkey.bind(mash, "'", function() core.fnutils.map(core.window.visiblewindows(), grid.snap) end)

mjolnir.hotkey.bind(mash, '=', function() grid.adjustwidth( 1) end)
mjolnir.hotkey.bind(mash, '-', function() grid.adjustwidth(-1) end)

-- mjolnir.hotkey.bind(mashshift, 'H', function() core.window.focusedwindow():focuswindow_west() end)
-- mjolnir.hotkey.bind(mashshift, 'L', function() core.window.focusedwindow():focuswindow_east() end)
-- mjolnir.hotkey.bind(mashshift, 'K', function() core.window.focusedwindow():focuswindow_north() end)
-- mjolnir.hotkey.bind(mashshift, 'J', function() core.window.focusedwindow():focuswindow_south() end)

mjolnir.hotkey.bind(mash, 'A', grid.maximize_window)

mjolnir.hotkey.bind(mash, 'N', grid.pushwindow_nextscreen)
mjolnir.hotkey.bind(mash, 'P', grid.pushwindow_prevscreen)

mjolnir.hotkey.bind(mash, 'J', grid.pushwindow_down)
mjolnir.hotkey.bind(mash, 'K', grid.pushwindow_up)
mjolnir.hotkey.bind(mash, 'H', grid.pushwindow_left)
mjolnir.hotkey.bind(mash, 'L', grid.pushwindow_right)

mjolnir.hotkey.bind(mash, 'U', grid.resizewindow_taller)
mjolnir.hotkey.bind(mash, 'O', grid.resizewindow_wider)
mjolnir.hotkey.bind(mash, 'I', grid.resizewindow_thinner)
