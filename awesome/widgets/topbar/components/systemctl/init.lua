local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local systemctl_component = {}

function systemctl_component.create_new(s) 
    local button = wibox.widget {
        text = "X",
        widget = wibox.widget.textbox
    }

    -- Add a left-click mouse binding
    button:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awesome.emit_signal("systemctl_open")
                -- awful.spawn.with_shell("firefox &")
            end)
        )
    )
    return button 
end

return systemctl_component