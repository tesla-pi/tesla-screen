gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")

function node.render()
	font:write(HEIGHT/2,300,"STANDUP TIME", 80, 0, 1, 0, 1)
end
