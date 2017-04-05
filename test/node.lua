gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 32

function node.render()
	gl.clear(0,0,0,0)
	font:write(60,60,"Test Node", 80, 1, 0, 0, 1)
end
