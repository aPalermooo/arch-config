-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi 

awful.screen.connect_for_each_screen( function(s) 

    -- Screen Dimension dependent geometry 
    local screen_width = s.geometry.width
    local screen_height = s.geometry.height


    s.systemctl_splash = awful.wibar({
        width = screen_width,
        height = screen_height,

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
                s.systemctl_splash.visible = false
                awful.keygrabber.stop(keygrabber)
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
                s.systemctl_splash.visible = false
                awful.keygrabber.stop(keygrabber)
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
                    s.systemctl_splash.visible = false
                    awful.keygrabber.stop(keygrabber)
                    awful.spawn("systemctl suspend")
                end)
            )
    }

    local lock_btn = wibox.widget {
        text = "Lock",
        widget = wibox.widget.textbox,
        align = "center",
        valign = "center",
        buttons = awful.util.table.join(
                awful.button({}, 1, function()
                    s.systemctl_splash.visible = false
                    awful.keygrabber.stop(keygrabber)
                    awesome.quit()
                end)
            )
    }

    local button_layout = wibox.layout.fixed.horizontal()
    button_layout.spacing = 10

    button_layout:add(shutdown_btn)
    button_layout:add(restart_btn)
    button_layout:add(suspend_btn)
    button_layout:add(lock_btn)

    
    s.systemctl_splash:setup {
        button_layout,
        halign = "center",
        valign = "center",
        widget = wibox.container.place,
    }


    awesome.connect_signal("systemctl_open", function()
        s.systemctl_splash.visible = true

        local keygrabber
        keygrabber = awful.keygrabber.run(
            function(_, key, event)
                if key == 'Escape' then 
                    s.systemctl_splash.visible = false
                    awful.keygrabber.stop(keygrabber)
                end
            end
    )  
    end)

    -- Show the splash and start keygrabber
    s.systemctl_splash.visible = false

end )
