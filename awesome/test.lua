
-- Ensure dependency is present
pcall(require, "luarocks.loader")


-- Standard Imports
local awful = require("awful")
local beautiful = require("beautiful")

-- Default error handling
require("config.errorhandling")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4" 






-- Run autostart file
awful.spawn.with_shell("~/.config/awesome/autorun.sh")