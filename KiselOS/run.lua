-- Imports
	Lib = require "/KiselOS/KiselOSLib"

-- Variables
	running = true

	_onMenu = false
	_rcm = false
	otherScreen = false
	
	-- Images

	local file = io.open("/Home/Wallpapers/.dtpath", "r")
	
	if file then
		local _dtPath = file:read("*a")

		file:close()
		
		_dt = paintutils.loadImage("/Home/Wallpapers/" .. _dtPath)
	
	end

--Functions

    clear = function()
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
        term.clear()
        term.setCursorPos(1, 1)
    end
    
	drawMenu1 = function()
		term.setCursorPos(1, 2)
		term.setBackgroundColor(colors.white)
		
		if onMon then
			term.setTextColor(colors.blue)
		else
			term.setTextColor(colors.lightGray)
		end
		print(" RETURN TO COMPUTER   ")
	end	

    drawMenu2 = function()
        term.setCursorPos(1, 3)
        term.setBackgroundColor(colors.white)
        term.setTextColor(colors.red)
        print(" SHUTDOWN             ")
    end
	drawMenu3 = function()
        term.setCursorPos(1, 4)
        term.setBackgroundColor(colors.white)
        term.setTextColor(colors.red)
        print(" REBOOT               ")
    end
	drawMenu4 = function()
        term.setCursorPos(1, 5)
        term.setBackgroundColor(colors.white)
        term.setTextColor(colors.black)
        print(" LUA                  ")
    end
	drawMenu5 = function()
        term.setCursorPos(1, 6)
        term.setBackgroundColor(colors.white)
        term.setTextColor(colors.black)
        print(" PAINT                ")
    end
	drawMenu6 = function()
        term.setCursorPos(1, 7)
        term.setBackgroundColor(colors.white)
        term.setTextColor(colors.black)
        print(" INFO                 ")
    end
	drawMenu7 = function()
        term.setCursorPos(1, 8)
        term.setBackgroundColor(colors.white)
        term.setTextColor(colors.black)
        print(" EXPLORER             ")
    end
	drawMenu8 = function()
		term.setCursorPos(1, 9)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print(" SHELL                ")
	end
	drawMenu9 = function()
		term.setCursorPos(1, 10)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print(" CONNECT TO MONITOR   ")
	end
	drawMenu10 = function()
		term.setCursorPos(1, 11)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		print(" PROGRAMS           \16 ")
	end
	
	drawMenu = function()
		drawMenu1()
		drawMenu2()
		drawMenu3()
		drawMenu4()
		drawMenu5()
		drawMenu6()
		drawMenu7()
		drawMenu8()
		drawMenu9()
		drawMenu10()
	end

	changeWallpaper = function()
		-- Инициализация экрана смены обоев
		otherScreen = true
		_rcm = false
		clear()
	
		-- Загрузка списка обоев
		local files = fs.list("/Home/Wallpapers/")
		local validWallpapers = {}
		for _, file in ipairs(files) do
			if file ~= ".dtpath" then
				table.insert(validWallpapers, file)
			end
		end
	
		local currentIndex = 1
	
		-- Функция для отрисовки меню
		local function drawWallpaperMenu()
			-- Очистка экрана и отображение предпросмотра обоев
			clear()
			local wallpaperPath = "/Home/Wallpapers/" .. validWallpapers[currentIndex]
			local previewImage = paintutils.loadImage(wallpaperPath)
			if previewImage then
				paintutils.drawImage(previewImage, 1, 2)
			else
				term.setCursorPos(1, 3)
				print("Failed to load image.")
			end
	
			-- Рисуем верхнюю панель
			local screenWidth, _ = term.getSize()
			term.setBackgroundColor(colors.blue)
			term.setTextColor(colors.white)
			term.setCursorPos(1, 1)
			term.clearLine()
	
			-- Добавляем крестик
			term.setCursorPos(1, 1)
			term.setBackgroundColor(colors.red)
			term.setTextColor(colors.white)
			term.write("X")
	
			-- Добавляем стрелки
			term.setBackgroundColor(colors.blue)
			term.setTextColor(colors.white)
			term.setCursorPos(3, 1)
			term.write("\27") -- Стрелка влево
			term.setCursorPos(5, 1)
			term.write("\26") -- Стрелка вправо
	
			-- Отображаем название текущего изображения
			local nameText = validWallpapers[currentIndex]
			local xPos = math.floor((screenWidth - #nameText) / 2)
			term.setCursorPos(xPos, 1)
			term.write(nameText)
	
			-- Рисуем кнопку "OK"
			term.setCursorPos(math.floor((screenWidth - 6) / 2), 2)
			term.setBackgroundColor(colors.green)
			term.setTextColor(colors.white)
			term.write("  OK  ")
		end
	
		-- Функция для сохранения выбранных обоев
		local function saveWallpaper()
			local wallpaperfile = fs.open("/Home/Wallpapers/.dtpath", "w")
			wallpaperfile.write(validWallpapers[currentIndex])
			wallpaperfile.close()
		end
	
		-- Основное управление меню
		drawWallpaperMenu()
		while true do
			local event, button, x, y = os.pullEvent("mouse_click")
			if y == 1 then
				if x == 1 then
					-- Закрытие меню (крестик)
					clear()
					init()
					break
				elseif x == 3 then
					-- Предыдущее изображение (стрелка влево)
					currentIndex = (currentIndex - 2) % #validWallpapers + 1
					drawWallpaperMenu()
				elseif x == 5 then
					-- Следующее изображение (стрелка вправо)
					currentIndex = currentIndex % #validWallpapers + 1
					drawWallpaperMenu()
				end
			elseif y == 2 then
				local screenWidth, _ = term.getSize()
				if x >= math.floor((screenWidth - 6) / 2) and x <= math.floor((screenWidth + 6) / 2) then
					-- Сохранить текущие обои (кнопка "OK")
					saveWallpaper()
					otherScreen = false
					reload()
					break
				end
			end
		end
	end	

    drawRCMenu = function(x, y)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		term.setCursorPos(x, y)
		term.write(" CHANGE WALLPAPER ")
		while true do
			local event, button, xPos, yPos = os.pullEvent("mouse_click")
			if yPos == y and xPos <= (x + 16) and xPos >= x and button == 1 then
				changeWallpaper()
			else
				init()
				break
			end
		end
	end

	drawProgramsMenu = function(x, y)
		_onMenu = false
		otherScreen = true
		local programs = fs.list("/programs/")
		local currentIndex = 1
		local itemsPerPage = 10
		local totalPages = math.ceil(#programs / itemsPerPage)
		local currentPage = 1
	
		-- Определяем максимальную длину программы
		local maxProgramLength = 8
		for _, program in ipairs(programs) do
			if #program > maxProgramLength then
				maxProgramLength = #program
			end
		end
		-- Добавляем по одному символу слева и справа
		local rectWidth = maxProgramLength + 2
	
		local function drawPage()
			-- Очистка области вокруг текста программ
			drawDesktop()
			drawMenu()
			drawTaskBar()
	
			for i = 1, itemsPerPage do
				local programIndex = (currentPage - 1) * itemsPerPage + i
				local yPos = y + i - 1
	
				-- Рисуем прямоугольник
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
				term.setCursorPos(x - 1, yPos)
				term.write(string.rep(" ", rectWidth))
	
				-- Отображение названия программы
				if programs[programIndex] then
					term.setCursorPos(x, yPos)
					term.write(programs[programIndex])
				end
			end
	
			-- Отображение стрелок навигации
			term.setCursorPos(x, y + itemsPerPage)
			term.setBackgroundColor(colors.lightGray)
			term.setTextColor(colors.black)
	
			if currentPage > 1 then
				term.write(" \24 ") -- Стрелка вверх
			else
				term.write("   ")
			end
	
			term.setCursorPos(x + 3, y + itemsPerPage)
			if currentPage < totalPages then
				term.write(" \25 ") -- Стрелка вниз
			else
				term.write("   ")
			end
		end
	
		-- Основной цикл обработки меню
		drawPage()
		while true do
			local event, button, xPos, yPos = os.pullEvent("mouse_click")
			if button == 1 then
				if yPos >= y and yPos < y + itemsPerPage and xPos >= x and xPos <= rectWidth then
					local programIndex = (currentPage - 1) * itemsPerPage + (yPos - y + 1)
					if programs[programIndex] then
						clear()
						shell.run("/programs/" .. programs[programIndex])
						init()
						break
					end
				elseif yPos == y + itemsPerPage then
					if xPos >= x and xPos < x + 3 and currentPage > 1 then
						-- Перемотка вверх
						currentPage = currentPage - 1
						drawPage()
					elseif xPos >= x + 3 and xPos < x + 6 and currentPage < totalPages then
						-- Перемотка вниз
						currentPage = currentPage + 1
						drawPage()
					end
				else
					-- Закрытие меню
					init()
					break
				end
			end
		end
	end
	
	-- Функция для сохранения состояния onMon
	local function saveOnMonState(state)
		local file = fs.open("/KiselOS/onMon", "w")
		if file then
			file.write(tostring(state))
			file.close()
		end
	end

	local function loadOnMonState()
		if fs.exists("/KiselOS/onMon") then
			local file = fs.open("/KiselOS/onMon", "r")
			local content = file.readAll()
			file.close()
			return content == "true"
		end
		return false
	end

	onMon = loadOnMonState()

    stop = function()
		running = false -- Завершение цикла
		term.setBackgroundColor(colors.black)
		term.clear()
		term.setCursorPos(1, 1)
		error("Terminated")
	end	
    
    drawTaskBar = function()
        term.setCursorPos(1, 1)
        term.setBackgroundColor(colors.blue)
        term.clearLine()
        term.setCursorPos(1, 1)
        term.setBackgroundColor(colors.lime)
        term.setTextColor(colors.white)
        term.write("[MENU]")
    end
	
	local function findMonitor(whatToFind)
		local PeriList = peripheral.getNames()
		for i=1,#PeriList do
			if peripheral.getType(PeriList[i]) == whatToFind then
				return PeriList[i]
			end
		end
	end
	
	cmd = function()
		otherScreen = true
		_onMenu = false
		clear()
		print('If you want return to KiselOS type "exit".')
		shell.run("shell")
		init()
	end
	
	reload = function()
		otherScreen = false
		_onMenu = false
		_rcm = false
		clear()
		running = false
		shell.run("/KiselOS/run.lua")
	end
	
    drawDesktop = function()
        term.setBackgroundColor(colors.lightGray)
        clear()
        paintutils.drawImage(_dt, 1, 1)
    end
	
    init = function()
		_onMenu = false
		_rcm = false
		otherScreen = false
		term.setCursorBlink(false)
		drawDesktop()
		drawTaskBar()
		runtime()
	end
    
    runtime = function()
        while running do		
            event, button, x, y = os.pullEvent("mouse_click")
            if _onMenu == false and button == 1 and x < 7 and y == 1 and otherScreen == false then
                drawMenu()
                _onMenu = true
			elseif _onMenu == true and button == 1 and x < 23 and y == 2 and onMon == true then
				saveOnMonState(false)
                stop()
            elseif _onMenu == true and button == 1 and x < 23 and y == 3 then
                os.shutdown()
			elseif _onMenu == true and button == 1 and x < 23 and y == 4 then
                os.reboot()
			elseif _onMenu == true and button == 1 and x < 23 and y == 5 then
				otherScreen = true
				_onMenu = false
				clear()
                term.setTextColor(colors.red)
                shell.run("lua")
				init()
			elseif _onMenu == true and button == 1 and x < 23 and y == 6 then
				clear()
				print("Open or create file...")
				term.write("Name of file > ")
				local fileName = io.read()
				shell.run("cd /")
				shell.run("paint ", fileName)
				shell.run("/KiselOS/run.lua")
			elseif _onMenu == true and button == 1 and x < 23 and y == 7 then
				shell.run("/Programs/SysInfo.lua")
				init()
			elseif _onMenu == true and button == 1 and x < 23 and y == 8 then
				shell.run("/Programs/minexp.lua")
				init()
			elseif _onMenu == true and button == 1 and x < 23 and y == 9 then
				cmd()
			elseif _onMenu == true and button == 1 and x < 23 and y == 10 and onMon == false then
				_onMenu = false
				clear()
				saveOnMonState(true)
				shell.run("monitor ", findMonitor("monitor"), "/KiselOS/run.lua")
				saveOnMonState(false)
				shell.run("monitor ", findMonitor("monitor"), "clear")
				init()
			elseif _onMenu == true and button == 1 and x < 23 and y == 11 then
				drawProgramsMenu(24, 3)
            elseif _onMenu == true and button == 1 and x < 7 and y == 1 then
                init()
            elseif _onMenu == false and _rcm == false and button == 2 then
				_rcm = true
                drawRCMenu(x, y)
            end
        end
		clear()
    end

-- Start
    init()
