gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")

function node.render()
	local date = os.date("%Y") .. "/" .. os.date("%m") .. "/" .. os.date("%d") .. " " .. os.date("%H") .. "/" .. os.date("%M") .. ":" .. os.date("%S")
	gl.clear(0.5, 0, 1, 0.3)
	
	font:write(0,0, date, 80, 1,1,0,1)
	font:write(HEIGHT/2,300,"*ahem* Standup!", 80, 1, 1, 0, 1)
end
