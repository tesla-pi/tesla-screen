gl.setup(1920, 1080)
local background = resource.load_image("tesla.png")
local font = resource.load_font("CaviarDreams_Bold.ttf")
local ip = resource.load_file("ip.txt")
local txt_size = 42
local nodes = {"welcome", "test"}
local node_count = 1
local timer = 0
local speed = 10

function next_node()
	if node_count > table.getn(nodes) then
		node_count = 1
	else
		node_count = node_count + 1
	end
end

function timer_start()
	
end

function timer_check()

end

function timer_diff()

end

function minutify(second)
	if second > 60 then
		second = second - 60
	elseif second < 0 then
		second = second + 60
	end
	return second
end

function node_choice()
	local standup_start_hour = 9
	local standup_start_min = 35
	local standup_end_hour = 9
	local standup_end_min = 50

	if os.date("%A") != "Monday" then
		if standup_start_hour == os.date("%H") and standup_start_min <= os.date("%M") and standup_end_min > os.date("%M") then
			return "standup"
		end
	else
		if standup_start_hour == os.date("%H") and (standup_start_min + 15) <= os.date("%M") then
			return "standup"
		elseif (standup_start_hour + 1) == os.date("%H") and minutify(standup_end_min + 15) > os.date("%M")
			return "standup"
		end
	end
	
	return nodes[node_count]
end

function node.render()
	gl.clear(0,0,0,0)
	draw_node = node_choice()
	background:draw(0,0,WIDTH, HEIGHT)	
	local year = os.date("%Y")
	local month = os.date("%m")
	local day = os.date("%d")
	local hour = os.date("%H")
	local minute = os.date("%M")
	local second = os.date("%S")
	local date = year .. "/" .. month .. "/" .. day .. "  " .. hour .. ":" .. minute .. ":" .. second
	
	font:write(0, HEIGHT - txt_size, ip , txt_size, 1,1,1,1)
	font:write(0,0,date, txt_size, 1,0,0,1)
	
	resource.render_child(draw_node):draw(0,0,WIDTH, HEIGHT)
end
