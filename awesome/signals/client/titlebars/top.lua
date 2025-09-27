local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local top = {}
function top.create(c)     
    -- Create a titlebar for the client.
    -- By default, awful.rules will create one, but all it does is to call this
    -- function.
    local top_titlebar = awful.titlebar(c, {
        size = 17,
        position = "top",
        bg = '#101314',
    })
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    -- Header (icon + title)
    local header = wibox.widget {
        awful.titlebar.widget.iconwidget(c),
        awful.titlebar.widget.titlewidget(c),
        spacing = 10,
        layout  = wibox.layout.fixed.horizontal,
    }

    -- Centered container
    local centered_header = wibox.widget {
        header,
        halign = "center",
        valign = "center",
        widget = wibox.container.place,
    }

    -- Apply mouse buttons so you can drag/resize
    centered_header:buttons(buttons)

    -- Setup layout (align: left, middle, right)
    top_titlebar:setup {
        nil,
        centered_header,
        nil,
        layout = wibox.layout.align.horizontal,
    }
end

return top