return {
    terminal = "kitty",
    editor = os.getenv("EDITOR") or "nano",
    editor_cmd = "kitty -e " .. (os.getenv("EDITOR") or "nano")
}