local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local M = {}

-- Your SVG icon directory
local icon_dir = "/home/cinnamon/.config/awesome/theme/icons/candy-icons-master/apps/scalable/"

-- Function to convert SVG -> PNG and update widget when ready
local function load_svg_icon(svg_path, size, widget)
    local cache_dir = gears.filesystem.get_cache_dir() .. "icons/"
    gears.filesystem.make_directories(cache_dir)

    local filename = svg_path:match("([^/]+)%.svg$") or "icon"
    local png_path = cache_dir .. filename .. ".png"

    if gears.filesystem.file_readable(png_path) then
        return png_path
    else
        local cmd = string.format("rsvg-convert -w %d -h %d '%s' -o '%s'",
            size, size, svg_path, png_path)

        awful.spawn.easy_async_with_shell(cmd, function()
            if gears.filesystem.file_readable(png_path) and widget then
                widget.image = png_path
            end
        end)
    end

    return nil
end

function M.create_new(s)

    local tasklist_buttons = gears.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end),
        awful.button({}, 3, function()
            awful.menu.client_list { theme = { width = 250 } }
        end),
        awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
        awful.button({}, 5, function() awful.client.focus.byidx(1) end)
    )

    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal,
        },
        widget_template = {
                {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
            },
            margins = 5,
            widget  = wibox.container.margin
        },
        nil,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
            self:get_children_by_id('clienticon')[1].client = c
        end,
        layout = wibox.layout.align.vertical,
    },
    }

    return s.mytasklist
end

return M
