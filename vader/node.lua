gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 32
local img = resource.load_image("vader.png")

node.event("content_update", function(filename, file)
	if filename == "vader.png" then
		img = resource.load_image(file)
	end
end)

function node.render()
	font:write(60,60,"Väder Node", 80, 1, 0, 0, 1)

	img:draw((WIDTH*0.15), 0, (WIDTH*0.85), HEIGHT*1.8)
end
