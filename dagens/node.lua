gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 40
local meny = resource.load_file("menu.txt")
local box_width = 30

node.event("content_update", function(filename, file)
	if filename == "menu.txt" then
		meny = resource.load_file("menu.txt")
	end
end)


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

function group_and_render(file)
	local lines = string.split(file, "\n")
	local count = 1
	local count4 = 1
	local set = {}
	while count < table.getn(lines) do
		set[count] = {}
		if count % 4 == 0 then
			count4 = count4 + 1
		end
		set[count4][count-((count4 - 1)*4)] = lines[count]
		count = count + 1
	end
	draw_set(set)
end

function draw_set(set)
	local xCount = 0
	local yCount = 1
	local maxBoxes = WIDTH/(box_width*txt_size)
	maxBoxes = maxBoxes - maxBoxes % 1
	local temp = set[1][1]
	draw_restaurant(0, temp)
	local x = 1
	
	while x <= (#set) do
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
		draw_box(xCount*box_width*txt_size, yCount*txt_size*2, set[x][2], set[x][3], set[x][0])
		xCount = xCount + 1
		x = x + 1
	end
end

function log(text)
	font:write(100,200,text,txt_size*8, 1,1,0,1)
end

function draw_box(x, y, name, price, type_name)
	if not name then
		name = "NO_NAME"
	end
	if not price then
		price = "NO_PRICE"
	end
	if not type_name then
		type_name = "UNKNOWN"
	end
	font:write(x, y, name:sub(1, box_width), txt_size, 1,1,1,1)
	if type_name == "Vegetariskt" or type_name == "vegetariskt" or type_name == "Veganskt" or type_name == "veganskt" then
		font:write(x, y + txt_size, type_name:sub(1, (box_width/2)), txt_size, 0,1,0,1)
	elseif type_name == "Kött" or type_name == "kött" then
		font:write(x, y + txt_size, type_name:sub(1, (box_width/2)), txt_size, 1,0.2,0.2,1)
	elseif type_name == "UNKNOWN" then
		font:write(x, y + txt_size, type_name:sub(1, (box_width/2)), txt_size, 1, 0, 0, 1)
	elseif type_name == "Fisk" or type_name == "fisk" then
		font:write(x, y + txt_size, type_name:sub(1, (box_width/2)), txt_size, 0.1,0.1,0.6,1)
	else
		font:write(x, y + txt_size, type_name:sub(1, (box_width/2)), txt_size, 1,1,0,1)
	end
	font:write(x + (txt_size *(box_width / 2)-128 ), y + txt_size, price, txt_size, 0,1,1,1)
end

function draw_restaurant(y, name)
	if not name then
		name = "NO_RESTAURANT"
	end
	font:write(WIDTH/2 - (txt_size*(name:len()*0.5)), y, name, txt_size*2, 1,1,1,1)
end


function node.render()
	gl.clear(0.2,0.2,0.2,1)
	group_and_render(meny)
	--font:write(100, 100, "No Break", txt_size*10, 1,1,1,1)
	--local temp = string.split(meny, "\n")
	--for i = 1, #temp do
	--	font:write(0, i*txt_size, temp[i], txt_size, 1,1,1,1)
	--end	
end
