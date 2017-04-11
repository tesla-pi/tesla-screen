gl.setup(1920, 1080)
local font = resource.load_font("CaviarDreams_Bold.ttf")
local txt_size = 128
local meny = resource.load_file("meny.txt")

node.event("content_update", function(filename, file)
	if filename == "meny." then
		meny = resource.load_file(file)
	end
end)

function node.render()
	gl.clear(0.1, 0.1, 0.6, 0.4)
end
