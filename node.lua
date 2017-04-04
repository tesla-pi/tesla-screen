gl.setup(1920, 1080)
local background = resource.load_image("tesla.png")
local font = resource.load_font("CaviarDreams_Bold.ttf")

function timer_start()

end

function timer_check()

end

function timer_diff()

end

function node_choice()

end

function node.render()
	font:write(0,0,"Sorry for breaking our TV, won't happen again! -Newcomer of the week(still?!?)", 100, 1,0,0,1)
	background:draw(0,0,WIDTH,HEIGHT)
end
