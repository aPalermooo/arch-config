local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

M = {}

function M.create_new(s) 
    local tasklist_buttons = gears.table.join(
        awful.button({}, 1, function(c)
            c:jump_to(false)
            awesome.emit_signal("dashboard::close")
        end), awful.button({}, 3, function()
            awful.menu.client_list({theme = {width = 250}})
        end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                                awful.button({}, 5, function()
            awful.client.focus.byidx(-1)
        end)
    )

    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing_widget = {
                {
                    forced_width  = 5,
                    forced_height = 24,
                    thickness     = 1,
                    color         = "#777777",
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            spacing = 1,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                id            = "background_role",
                widget        = wibox.container.background,
            },
            {
                awful.widget.clienticon,
                margins = 5,
                widget  = wibox.container.margin
            },
            nil,
            layout = wibox.layout.align.vertical,
        },
    }

    return s.mytasklist
end

return M