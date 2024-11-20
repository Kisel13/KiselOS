usedScreen = false

window = function(name)
    term.setBackgroundColor(colors.white)
    term.clear()
    term.setCursorPos(1, 1)
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.blue)
    term.clearLine()
    term.setBackgroundColor(colors.red)
    term.write("X")
    term.setBackgroundColor(colors.white)
    term.setCursorPos(2, 1)
    term.setBackgroundColor(colors.blue)
    term.write(" " .. name)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.black)
end

used = function()
    usedScreen = true
    window("Used soft")
    term.setCursorPos(23, 18)
    term.setBackgroundColor(colors.lightBlue)
    term.write(" \17BACK ")
    term.setCursorPos(2, 3)
    term.write("MineExplorerPlus by Missooni")
    -- while true do
    --     local event, button, xPos, yPos = os.pullEvent("mouse_click")
    --     if yPos == 1 and xPos == 1 and button == 1 and usedScreen == true then
    --         error("Terminated")
    --         break
    --     end
    -- end
end

info = function()
    window("System info")
    term.setCursorPos(1, 2)
    term.setCursorPos(22, 4)
    term.write("KiselOS")
    term.setCursorPos(2, 7)
    term.write("Version: KiselOS FRANCISCO 1.0 (BETA)")
    term.setCursorPos(2, 9)
    term.write("Autor: Kisel13")
    term.setCursorPos(21, 18)
    term.setBackgroundColor(colors.lightBlue)
    term.write(" USED SOFT ")
    while true do
        local event, button, xPos, yPos = os.pullEvent("mouse_click")
        if yPos == 1 and xPos == 1 and button == 1 then
            usedScreen = false
            error("Terminated")
            break
        elseif xPos >= 21 and xPos <= 24 and yPos == 18 and button == 1 and usedScreen == false then
            used()
        end
    end
end

info()
