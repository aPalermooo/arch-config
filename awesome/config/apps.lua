return {
    terminal = "xterm",
    editor = os.getenv("EDITOR") or "nano",
    editor_cmd = "xterm -e " .. (os.getenv("EDITOR") or "nano")
}