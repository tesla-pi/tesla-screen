gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 128
local meny = resource.load_file("meny.txt")
local box_width = 64
local restaurant_color = (1, 1, 1, 1)
local dish_color = (1, 1, 1, 1)
local price_color = (1, 1, 1, 1)
local type_color = (1, 1, 1, 1)


node.event("content_update", function(filename, file)
	if filename == "meny.txt" then
		meny = resource.load_file(file)
	end
end)

function group_and_render(file)
	local count = 1

	while count < lines do
		
		count = count + 1
	end
	draw_set(set)
end

function draw_set(set)
	local xCount = 0
	local yCount = 0
	local maxBoxes = (box_width * txt_size) / WIDTH)
	maxBoxes = maxBoxes - maxBoxes % 1
	local temp = set[1]
	draw_restaurant(0, temp[1])

	for group in set do
		if xCount > maxBoxes or temp[1] ~= group[1] then
			yCount = yCount + 1
			draw_restaurant(yCount*txt_size, group[1])
			yCount = yCount + 1
			xCount = 0
		else
			draw_box(xCount*box_width*text_size, yCount*text_size*2, group[2], group[3], group[4])
		end
		--Draw according to specifications
		temp = group
	end
end

function draw_box(x, y, name, price, type_name)
	font:draw(x, y, name:sub(1, box_width), txt_size, dish_color)
	font:draw(x, y + txt_size, type_name:sub(1, (box_width/2)), txt_size, type_color)
	font:draw(x + (txt_size *(box_width / 2) ), y + txt_size, price, txt_size, price_color)
end

function draw_restaurant(y, name)
	font:draw(WIDTH - (txt_size*(name:len()/2)), y, name, txt_size*2, restaurant_color )
end


function node.render()
	gl.clear(0.1, 0.1, 0.6, 0.4)

end
