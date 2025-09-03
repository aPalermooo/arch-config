local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

awful.screen.connect_for_each_screen( function(s) 

    s.systemctl_splash = awful.wibar({
        width = 300,
        height = 120,
        type = "splash",
        ontop = true,
        screen = s,
        shape = gears.shape.rectangle,
        bg = "#101314"
    })

    local function create_button(text, command)
        return wibox.widget {
            {
                text = text,
                align = "center",
                widget = wibox.widget.textbox
            },
            bg = "#222222",
            fg = "#aaaaaa",
            widget = wibox.container.background,
            buttons = awful.button({}, 1, function()
                s.systemctl_splash.visible = false
                awful.spawn(command)
            end)
        }
    end

    s.systemctl_splash:setup {
        {
            create_button("Shutdown", "systemctl poweroff"),
            create_button("Restart", "systemctl reboot"),
            create_button("Suspend", "systemctl suspend"),
            spacing = 10,
            layout = wibox.layout.flex.horizontal
        },
        margins = 15,
        widget = wibox.container.margin
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