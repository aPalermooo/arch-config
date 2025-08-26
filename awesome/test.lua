
-- Ensure dependency is present
pcall(require, "luarocks.loader")


-- Standard Imports
local awful = require("awful")
local beautiful = require("beautiful")

-- Default error handling
require("config.errorhandling")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- init layout
require("config.layouts")

-- init keyboard shortcuts and bind them
local bindings = require("bindings")
root.keys(bindings.global.key)
root.buttons(bindings.global.mouse)

require("rules")





-- Run autostart file
awful.spawn.with_shell("~/.config/awesome/config/autorun.sh")