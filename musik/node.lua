gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 64
local song_list = resource.load_file("playlist.txt")

node.event("content_update", function(filename, file)
	if filename == "playlist.txt" then
		song_list = resource.load_file(file)
	end
end)

function print_lines(list, x, y)
	local count = 0
	for line in list:lines() do
		font:write(x, y + (count*(txt_size+2)), line, txt_size, 1,1,0,1)
		count = count + 1
	end
end

function node.render()
	
	font:write(60,60,"Musik Node", 80, 1, 1, 0, 1)
	print_lines(song_list, 60, 100)
	--font:write(100, 100, song_list, 80, 1,1,1,1)
end
