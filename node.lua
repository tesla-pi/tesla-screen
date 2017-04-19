gl.setup(1920, 1080)
local background = resource.load_image("background.png")
local font = resource.load_font("CaviarDreams_Bold.ttf")
local ip = resource.load_file("ip.txt")
local txt_size = 42
local nodes = {"welcome", "vader", "bussar"}
local node_count = 1
local timerc = -1
local timer_init = -1
local speed = 15
local sfx_played = 0

node.event("content_update", function(filename, file)
	if filename == "ip.txt" then
		ip = resource.load_file("ip.txt")
	end
end)

function next_node()
	if node_count >= table.getn(nodes) then
		node_count = 1
	else
		node_count = node_count + 1
	end
end

function timer_start()
	timer_init = tonumber(os.time())
end

function timer_check()
	if timer_init < 0 then
		timer_start()
	end
	timer_diff()
	if timerc > speed then
		next_node()
		timer_start()
	end
end

function timer_diff()
	timerc = tonumber(os.time()) - timer_init
end

function play_sound()
	sfx_played = 1
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
	
	local hour = tonumber(os.date("%H"))
	local minute = tonumber(os.date("%M"))
	
	--if true then return "dagens" end

	if os.date("%A") ~= "Monday" then
		if standup_start_hour == hour and 
			standup_start_min <= minute and 
			standup_end_min > minute
		then
			play_sound()
			return "standup"
		end
	else
		if standup_start_hour == hour and 
			(standup_start_min + 15) <= minute 
		then
			play_sound()
			return "standup"
		elseif (standup_start_hour + 1) == hour and 
			minutify(standup_end_min + 15) > minute 
		then
			play_sound()
			return "standup"
		end
	end

	sfx_played = 0
	return nodes[node_count]
end

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
	--font:write(0,0,date, txt_size, 1,0,0,1)
	
	resource.render_child(draw_node):draw(0,0,WIDTH, HEIGHT)
end
