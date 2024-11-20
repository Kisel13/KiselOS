KiselOSLib = {}

KiselOSLib.alert = function(text)
    _onMenu=false
    _rcm = false
    otherScreen = true
    drawDesktop()
    term.setCursorPos(5, 5)
    term.setBackgroundColor(colors.red)
    term.write("X")
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.blue)
    for i = 0, string.len(text) do
        term.write(" ")
    end
    term.setCursorPos(5, 6)
    term.setTextColor(colors.black)
    term.setBackgroundColor(colors.white)
    term.write(" " .. text .. " ")
    while true do
        event, button, x, y = os.pullEvent("mouse_click")
        if x == 5 and y == 5 then
            init()
            break
        end
    end
end

return KiselOSLib