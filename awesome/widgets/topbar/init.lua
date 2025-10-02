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

    local bar_width = screen_width
    local bar_height = screen_height * 0.025


    local bar_spacing = dpi(10)

    -- construct widget
    s.topbar = awful.wibar({
        -- TODO: refactor attributes to theme.lua
        width = bar_width,
        height = bar_height,
        position = "top", -- R 
        type = "dock", -- R
        ontop = true,
        screen = s,
        shape = function (cr, width, height)
            gears.shape.rectangle(cr,width,height)
        end,
        bg = "#101314FF", -- R
        -- bg_dark: 1c2224
    })

    local clock_component = require("widgets.topbar.components.clock")
    local systemctl_component = require("widgets.topbar.components.systemctl")

    local clock = clock_component.create_new(s)
    local systemctl = systemctl_component.create_new(s)

    s.topbar:setup {
        { --Left
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle 
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Right
            { -- wrap clock
                widget = wibox.container.place,
                valign = "center",
                clock,
            },
            { -- wrap systemctl
                widget = wibox.container.place,
                valign = "center",
                systemctl,
            },
            layout = wibox.layout.fixed.horizontal,
            spacing = bar_spacing,
        },
        layout = wibox.layout.align.horizontal,
    }

    awful.screen.padding(s, { top = bar_height })
end)