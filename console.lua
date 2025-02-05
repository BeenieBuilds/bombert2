require('consts')


Console = {}
Console.__index = Console


function Console.new(x, y, width, height)
    local instance = setmetatable({}, Console)

    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.lines = {}

    return instance
end

function Console:load()
    for i = 1, #self.lines do
        love.graphics.print(self.lines[i], self.x, self.y + (i*30), 0, self.width, self.height)
    end
end

function Console:log(text)
    print(text)
    self.lines[#self.lines+1] = tostring(text)
    if #self.lines > 10 then
        table.remove(self.lines, 1)
    end
end