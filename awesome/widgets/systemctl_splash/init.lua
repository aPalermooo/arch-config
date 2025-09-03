-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi 

awful.screen.connect_for_each_screen( function(s) 

    s.systemctl_splash = awful.wibar({

        width = 200,
        height = 100,

        type = "splash",
        ontop = true,
        screen = s,
        shape = function (cr, width, height)
            gears.shape.rectangle(cr,width,height)
        end,
        bg = "#101314"
    })

    s.systemctl_splash : setup {
        layout = wibox.layout.align.horizontal
    }

    local keygrabber
    keygrabber = awful.keygrabber.run(
        function(_, key, event)
            if key == 'Escape' then 
                s.systemctl_splash.visible = false
                awful.keygrabber.stop(keygrabber)
            end
        end
    )  

    -- Show the splash and start keygrabber
    s.systemctl_splash.visible = true

end )