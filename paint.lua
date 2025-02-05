require('consts')


Paint = {}
Paint.__index = Paint


function Paint.new(lineWidth, fill)
    local instance = setmetatable({}, Paint)

    instance.lineWidth = lineWidth
    instance.fill = fill

    return instance
end

local function degToRad(degree)
    local convert = (degree)*(math.pi/180)
    return {math.cos(convert), math.sin(convert)}
end

function Paint:sineCircle(hex1, hex2, hex3, x, y, size, verts, amp, speed)
    local circle = {}
    local inc = 360/verts

    for i = 1, verts do
        local e = degToRad(inc*i)
        
        circle[#circle+1] = x +  e[1] * ((size/2 + amp) * math.sin((math.pi/2)*(timer*speed) + i))
        circle[#circle+1] = y +  e[2] * ((size/2 + amp) * math.sin((math.pi/2)*(timer*speed) + i))
    end

    love.graphics.setColor(love.math.colorFromBytes(hex1, hex2, hex3))
    love.graphics.setLineWidth(self.lineWidth)
    love.graphics.polygon(self.fill, circle)
end
