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
    
    local clock_component = require("widgets/topbar/components/clock")
    local clock = clock_component.create_new(s)

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
    
    s.systemctl_splash:setup {
        suspend_btn,
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
