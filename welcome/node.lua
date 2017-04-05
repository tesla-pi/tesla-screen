gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 80
local text = "This screen is under construction!"
function node.render()
	local x = ((string.len(text)*txt_size)/2)
	font:write(60,60,"Welcome Node", 80, 1, 0, 0, 1)
	font:write((WIDTH/2)-x/2, HEIGHT/2, text, txt_size, 0,0,1,1)
end
