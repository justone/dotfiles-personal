
-- because of boxen, add those lua paths
package.path = package.path .. ';/opt/boxen/homebrew/share/lua/5.2/?.lua'
package.cpath = package.cpath .. ';/opt/boxen/homebrew/lib/lua/5.2/?.so'

local application = require "mjolnir.application"
local window = require "mjolnir.window"
local hotkey = require "mjolnir.hotkey"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"
local grid = require "mjolnir.sd.grid"

-- override with my own grid settings
grid.MARGINX = 2
grid.MARGINY = 2
grid.GRIDWIDTH = 8

alert.show("Mjolnir, at your service.")

local mash = {"cmd", "ctrl"}
-- local mashshift = {"cmd", "alt", "shift"}

-- requires: grid, core.fnutils, core.alert

hotkey.bind(mash, "T", function() application.launchorfocus("Terminal") end)
hotkey.bind(mash, "C", function() application.launchorfocus("iTerm") end)
hotkey.bind(mash, "B", function() application.launchorfocus("Google Chrome") end)
hotkey.bind(mash, "V", function() application.launchorfocus("MacVim") end)

-- status light options
hotkey.bind(mash, "S", function() os.execute('/Users/nate/bin/excluded/blink1-tool --red') end)
hotkey.bind(mash, "D", function() os.execute('/Users/nate/bin/excluded/blink1-tool --green') end)

hotkey.bind(mash, ';', function() grid.snap(core.window.focusedwindow()) end)
hotkey.bind(mash, "'", function() core.fnutils.map(core.window.visiblewindows(), grid.snap) end)

hotkey.bind(mash, '=', function() grid.adjustwidth( 1) end)
hotkey.bind(mash, '-', function() grid.adjustwidth(-1) end)

-- hotkey.bind(mashshift, 'H', function() core.window.focusedwindow():focuswindow_west() end)
-- hotkey.bind(mashshift, 'L', function() core.window.focusedwindow():focuswindow_east() end)
-- hotkey.bind(mashshift, 'K', function() core.window.focusedwindow():focuswindow_north() end)
-- hotkey.bind(mashshift, 'J', function() core.window.focusedwindow():focuswindow_south() end)

hotkey.bind(mash, 'A', grid.maximize_window)

hotkey.bind(mash, 'N', grid.pushwindow_nextscreen)
hotkey.bind(mash, 'P', grid.pushwindow_prevscreen)

hotkey.bind(mash, 'J', grid.pushwindow_down)
hotkey.bind(mash, 'K', grid.pushwindow_up)
hotkey.bind(mash, 'H', grid.pushwindow_left)
hotkey.bind(mash, 'L', grid.pushwindow_right)

hotkey.bind(mash, 'U', grid.resizewindow_taller)
hotkey.bind(mash, 'O', grid.resizewindow_wider)
hotkey.bind(mash, 'I', grid.resizewindow_thinner)
