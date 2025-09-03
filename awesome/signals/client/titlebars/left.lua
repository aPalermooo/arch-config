local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi 

local left = {}
function left.create(c) 


    local left_titlebar = awful.titlebar(c, {
        size = 20,
        position = 'left',
        bg = '#101314',
    })

left_titlebar:setup {
    { -- TOP
        awful.titlebar.widget.closebutton    (c),
        awful.titlebar.widget.maximizedbutton (c),
        layout = wibox.layout.fixed.vertical,
    },
    { -- MIDDLE
        layout = wibox.layout.flex.vertical,
    },
        { -- BOTTOM
            {
                awful.titlebar.widget.ontopbutton(c),
                layout = wibox.layout.fixed.vertical,
            },
            bottom = 20,
            widget = wibox.container.margin,
        },
    layout = wibox.layout.align.vertical,
}
end

return left