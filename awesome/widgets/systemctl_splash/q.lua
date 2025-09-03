local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi 

awful.screen.connect_for_each_screen( function(s) 

    s.systemctl_splash = awful.wibar({
        width = 300,
        height = 150,
        type = "splash",
        ontop = true,
        screen = s,
        shape = function (cr, width, height)
            gears.shape.rectangle(cr,width,height)
        end,
        bg = "#101314"
    })

    local shutdown_btn = wibox.widget {
        text = "Shutdown",
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
        buttons = awful.util.table.join(
            awful.button({}, 1, function()
                awful.spawn("systemctl poweroff")
            end)
        )
    }

    local restart_btn = wibox.widget {
        text = "Restart",
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
        buttons = awful.util.table.join(
            awful.button({}, 1, function()
                awful.spawn("systemctl reboot")
            end)
        )
    }

    local suspend_btn = wibox.widget {
        text = "Suspend",
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
        buttons = awful.util.table.join(
            awful.button({}, 1, function()
                awful.spawn("systemctl suspend")
            end)
        )
    }

    s.systemctl_splash : setup {
        {
            shutdown_btn,
            restart_btn,
            suspend_btn,
            layout = wibox.layout.flex.horizontal
        },
        widget = wibox.container.margin,
        margins = 20
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

    s.systemctl_splash.visible = true

end )