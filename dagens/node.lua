gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 40
local meny = resource.load_file("menu.txt")
local box_width = 28
local offset_y = 200
local scroll_start = 200
local scroll_end = 0
node.event("content_update", function(filename, file)
	if filename == "menu.txt" then
		meny = resource.load_file("menu.txt")
	end
end)

--Splits a textfile by a specific pattern. E.g. x = string.split(file, "\n")
function string:split(pattern, file)
	if not file then
		file = {}
	end
	local start = 1
	local splitStart, splitEnd = string.find(self, pattern, start)
	while splitStart do
		table.insert(file, string.sub(self, start, splitStart-1))
		start = splitEnd + 1
		splitStart, splitEnd = string.find(self, pattern, start)
	end
	table.insert(file, string.sub(self, start))
	return file
end

--Groups the info of a file into a matrix and calls the function to draw the set.
function group_and_render(file)
	local lines = string.split(file, "\n")
	local count = 1
	local count4 = 1
	local set = {}
	while count < table.getn(lines) do
		set[count] = {}
		set[count4][count-((count4 -1)*4)] = lines[count]
		if count % 4 == 0 then
			count4 = count4 + 1
		end
		count = count + 1
	end
	draw_set(set)
end

--Takes a matrix as a parameter and calls the drawing functions of each grouping.
function draw_set(set)
	local xCount = 0
	local yCount = 1
	local maxBoxes = WIDTH/(box_width*txt_size)
	maxBoxes = maxBoxes - maxBoxes % 1
	local temp = set[1][1]
	draw_restaurant(0, temp)
	local x = 1
	
	while x <= (#set/4) do
		if x == 1 then
			temp = set[1][1]
		else
			temp = set[x-1][1]
		end
		if temp ~= set[x][1] then
			yCount = yCount + 1
			draw_restaurant((yCount*2)*txt_size, set[x][1])
			yCount = yCount + 1
			xCount = 0
		elseif xCount > maxBoxes then
			yCount = yCount + 1
			xCount = 0
		end
		draw_box(xCount*box_width*txt_size, yCount*txt_size*2, set[x][2], set[x][3], set[x][4])
		xCount = xCount + 1
		x = x + 1
	end
	set_end(x)
end

--Used for temporary writing of text
function log(text)
	font:write(100,200,text,txt_size*2, 1,1,0,1)
end

--Prints all the info of a meal in a set starting location
function draw_box(x, y, name, price, type_name)
	if x < WIDTH and y+offset_y < HEIGHT and x >= 0 and y >= 0 then
		if not name then
			name = "NO_NAME"
		end
		if not price then
			price = "NO_PRICE"
		end
		if not type_name then
			type_name = "UNKNOWN"
		end
		font:write(x, y + offset_y, name:sub(1, box_width*1.5), txt_size, 1,1,1,1)
	
		local r = 1
		local g = 1
		local b = 0
		local a = 1
		if type_name == "Vegetariskt" or type_name == "vegetariskt" or type_name == "Veganskt" or type_name == "veganskt" then
			r,g,b = 0, 1, 0
		elseif type_name == "Kött" or type_name == "kött" then
			r,g,b = 1, 0.2, 0.2
		elseif type_name == "UNKNOWN" then
			r,g,b = 1, 0, 0
		elseif type_name == "Fisk" or type_name == "fisk" then
			r,g,b = 0.2, 0.2, 0.6
		elseif type_name == "Pasta" or type_name == "pasta" then
			r,g,b = 1, 1, 0.2
		elseif type_name == "Kyckling" or type_name == "kyckling" then
			r,g,b = 1, 0.8, 0.6
		else
			r,g,b = 1, 1, 0
		end
		font:write(x, y + txt_size + offset_y, type_name:sub(1, (box_width/2)), txt_size, r, g, b, a)
		font:write(x + (txt_size *(box_width / 2)+124 ), y + txt_size + offset_y, price, txt_size, 0,1,1,1)
	end
end


--Writes the restaurant name centered at a set location
function draw_restaurant(y, name)
	if not name then
		name = "NO_RESTAURANT"
	end
	font:write(WIDTH/2 - (txt_size*(name:len()*0.5)), y + offset_y, name, txt_size*2, 1,1,1,1)
end

--Function to scroll the text over time
function scroll()
	
end

--Set the end-offset
function set_end(count)
	scroll_end = -(count * 55)
end

function node.render()
	gl.clear(0.2,0.2,0.2,0.4)
	group_and_render(meny)
end
