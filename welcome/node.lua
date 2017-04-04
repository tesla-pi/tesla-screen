gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")

function node.render()
	font:write(60,60,"Welcome Node", 80, 1, 0, 0, 1)
end
