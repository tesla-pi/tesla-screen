text = "Hello\n Darkness\n My Old\n Friend\n I've\n Come\n To\n Talk\n To\n"

local file = io.open("menu.txt", 'r')

local lines= {}
for i in file:lines() do
	table.insert(lines, i)
end

local count = 1
local count4 = 1
local set = {}
while count < table.getn(lines) do
	set[count] = {}
	if count % 4 == 0 then
		count4 = count4 + 1
	end
	set[count4][count-((count4 - 1)*4)] = lines[count]
	count = count + 1
end
x = 1
y  = 1
while x < #set do
	if x % 4 == 0 then
		y = y + 1
	end
	print(set[y][x-((y - 1)*4)])
	x = x + 1
end

file:close()

print(set[1][1])
print(set[1][2])
