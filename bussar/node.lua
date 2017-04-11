gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 32
local L1 = resource.load_image("lindholmen.png")
local L2 = resource.load_image("lindholmspiren.png")

node.event("content_update", function(filename, file)
	if filename == "lindholmen.png" then
		L1 = resource.load_image(file)
	elseif filename == "lindholmspiren.png" then
		L2 = resource.load_image(file)
	end
end)

function node.render()
	
	font:write(60,60,"Väder Node", 80, 1, 0, 0, 1)

	L1:draw((WIDTH*0.025), HEIGHT*0.02, (WIDTH*0.51), HEIGHT*0.98)
	L2:draw((WIDTH*0.49), HEIGHT*0.02, (WIDTH*0.975), HEIGHT*0.98)
end
