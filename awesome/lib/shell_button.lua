local awful = require("awful")
local wibox = require("wibox")
    
    local M = {}

    -- Used to create buttons in systemctl splash page
    function M.create_button(text, command)
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

return M