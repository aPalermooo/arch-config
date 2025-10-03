-- Tasklist bottom bar

-- Imports
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local rubato = require("lib.rubato") -- Animation lib

local xresources = require ("beautiful.xresources")
local dpi = xresources.apply_dpi

awful.screen.connect_for_each_screen( function(s)

    -- Screen Dimesnion dependent geometry
    local screen_width = s.geometry.width
    local screen_height = s.geometry.height

    local bar_width = screen_width * 0.75
    local bar_height = screen_height * 0.04

    local peak_height = bar_height * 0.20

    local bar_spacing = dpi(10)

    -- Construct Widget
    s.dock = wibox({
        x = (screen_width - bar_width) / 2,
        y = (screen_height - peak_height),

        width = bar_width,
        height = bar_height,
        visible=true,
        type = "dock", -- R
        ontop = true,
        screen = s,
        shape = function (cr, width, height)
            gears.shape.rectangle(cr,width,height)
        end,
        bg = "#101314FF", -- R
    })

    -- Init Lua Widget Modules
    local tasklist_component = require("widgets.dock.components.tasklist")

    -- Create instances of widgets
    s.tasklist = tasklist_component.create_new(s)

    -- Arrange Children on Widget
    s.dock:setup {
        { -- Left
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            { -- Wrap Textbox
                widget = wibox.container.place,
                valign = "center",
                s.tasklist,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.align.horizontal,
    }

    awful.screen.padding(s, { bottom = bar_height })

    local show = true

    awesome.connect_signal("widgets::hide", function(screen)
        if screen == s then
            show = false
            s.dock.visible = false
        end
    end)

    awesome.connect_signal("widgets::show", function(screen)
        if screen == s then
            show = true
            s.dock.visible = true
        end
    end)

    -- Animation
    local dock_animation = rubato.timed {
        pos = screen_height - s.dock.height,
        duration = 0.3,
        intro = 0.1,
        subscribed = function(pos)
            s.dock.y = pos
        end,
    }


    s.dock:connect_signal("mouse::enter", function()
        dock_animation.target = screen_height - bar_height
    end)

    s.dock:connect_signal("mouse::leave", function()
        dock_animation.target = screen_height - peak_height
    end)

    dock_animation.target = screen_height - peak_height -- init update

end)

