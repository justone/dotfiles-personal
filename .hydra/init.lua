hydra.alert("Hydra (re)started.", 1.5)

-- launch on startup
autolaunch.set(true)
-- relaunch when config updated
pathwatcher.new(os.getenv("HOME") .. "/.hydra/", hydra.reload):start()

local hyper = {"cmd", "ctrl"}

-- keybindings for apps or actions
hotkey.bind(hyper, "R", repl.open)
hotkey.bind(hyper, "Q", hydra.reload)
hotkey.bind(hyper, "T", function() application.launchorfocus("Terminal") end)
hotkey.bind(hyper, "C", function() application.launchorfocus("iTerm") end)
hotkey.bind(hyper, "B", function() application.launchorfocus("Google Chrome") end)

-- status light options
hotkey.bind(hyper, "S", function() os.execute('/Users/nate/bin/excluded/blink1-tool --red') end)
hotkey.bind(hyper, "D", function() os.execute('/Users/nate/bin/excluded/blink1-tool --green') end)

-- grid stuff, managing windows

-- load in grid extension
dofile(package.searchpath("grid", package.path))

hotkey.bind(hyper, ';', function() ext.grid.snap(window.focusedwindow()) end)
hotkey.bind(hyper, '=', function() ext.grid.adjustwidth( 1) end)
hotkey.bind(hyper, '-', function() ext.grid.adjustwidth(-1) end)

hotkey.bind(hyper, 'A', ext.grid.maximize_window)

hotkey.bind(hyper, 'N', ext.grid.pushwindow_nextscreen)
hotkey.bind(hyper, 'P', ext.grid.pushwindow_prevscreen)

hotkey.bind(hyper, 'J', ext.grid.pushwindow_down)
hotkey.bind(hyper, 'K', ext.grid.pushwindow_up)
hotkey.bind(hyper, 'H', ext.grid.pushwindow_left)
hotkey.bind(hyper, 'L', ext.grid.pushwindow_right)

hotkey.bind(hyper, 'U', ext.grid.resizewindow_taller)
hotkey.bind(hyper, 'O', ext.grid.resizewindow_wider)
hotkey.bind(hyper, 'I', ext.grid.resizewindow_thinner)

-- rest of file basically the same as the stock sample file

-- save the time when updates are checked
function checkforupdates()
  updates.check(function(available)
      -- what to do when an update is checked
      if available then
        notify.show("Hydra update available", "", "Click here to see the changelog and maybe even install it", "showupdate")
      else
        hydra.alert("No update available.")
      end
  end)
  settings.set('lastcheckedupdates', os.time())
end

-- show a helpful menu
menu.show(function()
    local updatetitles = {[true] = "Install Update", [false] = "Check for Update..."}
    local updatefns = {[true] = updates.install, [false] = checkforupdates}
    local hasupdate = (updates.newversion ~= nil)

    return {
      {title = "Reload Config", fn = hydra.reload},
      {title = "Open REPL", fn = repl.open},
      {title = "-"},
      {title = "About", fn = hydra.showabout},
      {title = updatetitles[hasupdate], fn = updatefns[hasupdate]},
      {title = "Quit Hydra", fn = os.exit},
    }
end)

-- show available updates
local function showupdate()
  os.execute('open https://github.com/sdegutis/Hydra/releases')
end


-- check for updates every week
timer.new(timer.weeks(1), checkforupdates):start()
notify.register("showupdate", showupdate)

-- if this is your first time running Hydra, or you're launching it more than a week later, check now
local lastcheckedupdates = settings.get('lastcheckedupdates')
if lastcheckedupdates == nil or lastcheckedupdates <= os.time() - timer.days(7) then
  checkforupdates()
end




-- I've worked hard to make Hydra useful and easy to use. I've also
-- released it with a liberal open source license, so that you can do
-- with it as you please. So, instead of charging for licenses, I'm
-- asking for donations. If you find it helpful, I encourage you to
-- donate what you believe would have been a fair price for a license:

local function donate()
  os.execute("open 'https://www.paypal.com/cgi-bin/webscr?business=sbdegutis@gmail.com&cmd=_donations&item_name=Hydra.app%20donation&no_shipping=1'")
end

hotkey.bind({"cmd", "alt", "ctrl"}, "D", donate)
