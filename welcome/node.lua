gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 80
local text = "Välkommen till Tesla!"
function node.render()
	--gl.clear(0.5,0,1,0.3)
	
	local year = os.date("%Y")
	local month = os.date("%m")
	local day = os.date("%d")
	local hour = os.date("%H")
	local minute = os.date("%M")
	local second = os.date("%S")
	local date = year .. "/" .. month .. "/" .. day .. " " .. hour .. ":" .. minute .. ":" .. second



	local x = ((string.len(text)*txt_size*2)/2)
	
	font:write(0, 0, date, txt_size, 1,1,0,1)
	--font:write(0, txt_size,"Welcome Node", 80, 1, 1, 0, 1)
	font:write((WIDTH/2)-x/2, HEIGHT/2, text, txt_size*2, 1,1,0,1)
end
