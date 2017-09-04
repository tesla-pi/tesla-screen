gl.setup(1920, 1080)
local background = resource.load_image("background.png")
local font = resource.load_font("CaviarDreams_Bold.ttf")
local ip = resource.load_file("ip.txt")
local txt_size = 42
local nodes = {"welcome", "vader", "bussar", "dagens"}
local node_count = 1
local timerc = -1
local timer_init = -1
local speed = 15

--Content update, add cases if more files need to be watched
node.event("content_update", function(filename, file)
	if filename == "ip.txt" then
		ip = resource.load_file("ip.txt")
	end
end)

--Switches node to the next one, wrapping around if necessary
function next_node()
	if node_count >= table.getn(nodes) then
		node_count = 1
	else
		node_count = node_count + 1
	end
end

--Sets timer_init to current time
function timer_start()
	timer_init = tonumber(os.time())
end

--Checks timer, if unstarted starts. If timer surpasses speed, restart and switch node
function timer_check()
	if timer_init < 0 then
		timer_start()
	end
	timer_diff()
	if node_choice() == "dagens" then
		if timerc > speed*4 then
			next_node()
			timer_start()
		end
	elseif timerc > speed then
		next_node()
		timer_start()
	end
end

--Returns the time difference between timer_init and current time
function timer_diff()
	timerc = tonumber(os.time()) - timer_init
end

--Takes a number and ensures it's within the limits of 60
function minutify(second)
	if second > 60 then
		second = second - 60
	elseif second < 0 then
		second = second + 60
	end
	return second
end

--Return the node which should be displayed
function node_choice()
	local standup_start_hour = 9
	local standup_start_min = 35
	local standup_end_hour = 9
	local standup_end_min = 50
	
	local hour = tonumber(os.date("%H"))
	local minute = tonumber(os.date("%M"))
	
	--if true then return "dagens" end
	
	if os.date("%A") ~= "Monday" then
		if standup_start_hour == hour and 
			standup_start_min <= minute and 
			standup_end_min > minute
		then
			return "standup"
		end
	else
		if standup_start_hour == hour and 
			(standup_start_min + 15) <= minute 
		then
			return "standup"
		elseif (standup_start_hour + 1) == hour and 
			minutify(standup_end_min + 15) > minute 
		then
			return "standup"
		end
	end
	if hour >= 13 and nodes[node_count] == "dagens" then
		next_node()
	end
	if os.date("%A") == "Friday" and hour == 14 then
		return "cozy"
	end

	return nodes[node_count]
end

--Renders the main node, uses node_choice to get which child-node should be played.
function node.render()
	gl.clear(0,0,0,0)
	timer_check()
	draw_node = node_choice()
	background:draw(0,0,WIDTH, HEIGHT)	
	local year = os.date("%Y")
	local month = os.date("%m")
	local day = os.date("%d")
	local hour = os.date("%H")
	local minute = os.date("%M")
	local second = os.date("%S")
	local date = year .. "/" .. month .. "/" .. day .. " " .. hour .. ":" .. minute .. ":" .. second
	
	font:write(0, HEIGHT - txt_size, ip , txt_size, 1,1,1,1)
	
	resource.render_child(draw_node):draw(0,0,WIDTH, HEIGHT)
end
