

require('consts')

Visual = {}
Visual.__index = Visual


function Visual.new()
    local instance = setmetatable({}, Visual)

    return instance
end

function Visual:drawCircle(x, y, radius, amp, speed, verts, fill, lineWidth, hex1, hex2, hex3)
    local circle = {}
    local inc = 360/verts

    for i = 1, verts do
        local e = degToRad(inc*i)
        
        circle[#circle+1] = x +  (e[1] * radius) + amp * math.sin((math.pi/2)*(timer*speed) + i)
        circle[#circle+1] = y +  (e[2] * radius) + amp * math.sin((math.pi/2)*(timer*speed) + i)
    end

    love.graphics.setColor(love.math.colorFromBytes(hex1, hex2, hex3))
    love.graphics.setLineWidth(lineWidth)
    
    love.graphics.polygon(fill, circle)
end

function Visual:drawSpikes(x, y, width, height, amp, speed, verts, fill, lineWidth, hex1, hex2, hex3)
    local dirs = {
        {-1, -1, 1, 0, 0, -1}, --top left
        {1, -1, 0, 1, 1, 0}, --top right
        {1, 1, -1, 0, 0, 1}, --bottom right
        {-1, 1, 0, -1, -1, 0}, --bottom right
    }
    local poly = {}
    local drawX = 0
    local drawY = 0
    
    for i=1, 4 do
        poly[#poly+1] = x + dirs[i][1]*(width/2)
        poly[#poly+1] = y + dirs[i][2]*(height/2)
        for o=1, verts do

            if (o % 2 == 1) then
                poly[#poly+1] = x + dirs[i][1]*(width/2) + dirs[i][3]*(width/verts)*o + amp*dirs[i][5]*math.abs(math.sin(math.pi/2 * (speed*timer)))
                poly[#poly+1] = y + dirs[i][2]*(height/2) + dirs[i][4]*(height/verts)*o + amp*dirs[i][6]*math.abs(math.sin(math.pi/2 * (speed*timer)))
            else 
                poly[#poly+1] = x + dirs[i][1]*(width/2) + o*dirs[i][3]*(width/verts)
                poly[#poly+1] = y + dirs[i][2]*(height/2) + o*dirs[i][4]*(height/verts)
            end

        end

    end
    poly[#poly+1] = x + dirs[1][1]*(width/2) + dirs[1][3]*(width/verts)*1 + amp*dirs[1][5]*math.abs(math.sin(math.pi/2 * (speed*timer)))
    poly[#poly+1] = y + dirs[1][2]*(height/2) + dirs[1][4]*(height/verts)*1 + amp*dirs[1][6]*math.abs(math.sin(math.pi/2 * (speed*timer)))

    love.graphics.setColor(love.math.colorFromBytes(hex1, hex2, hex3))
    love.graphics.setLineWidth(lineWidth)

    love.graphics.polygon(fill, poly)
end

function Visual:drawSineBlock(x, y, width, height, amp, speed, verts, fill, lineWidth, hex1, hex2, hex3)
    local dirs = {
        {-1, -1, 1, 0}, --top left
        {1, -1, 0, 1}, --top right
        {1, 1, -1, 0}, --bottom right
        {-1, 1, 0, -1}, --bottom right
    }
    local poly = {}
    local drawX = 0
    local drawY = 0
    
    for i=1, 4 do

        drawX = x + dirs[i][1]*width/2
        drawY = y + dirs[i][2]*height/2
        for o=1, verts do

            drawX = drawX + (width/verts)*dirs[i][3] + amp*dirs[i][4]*math.sin(math.pi/2 * (speed*game.timer) + o)
            drawY = drawY + (height/verts)*dirs[i][4] + amp*dirs[i][3]*math.sin(math.pi/2 * (speed*game.timer) + o)

            poly[#poly+1] = drawX
            poly[#poly+1] = drawY

        end
    end

    love.graphics.setColor(love.math.colorFromBytes(hex1, hex2, hex3))
    love.graphics.setLineWidth(lineWidth)

    love.graphics.polygon(fill, poly)
end

function Visual:drawBlock(x, y, width, height, round, fill, lineWidth, hex1, hex2, hex3)

    love.graphics.setColor(love.math.colorFromBytes(hex1, hex2, hex3))
    love.graphics.setLineWidth(lineWidth)

    love.graphics.rectangle(fill, x - width/2, y - height/2, width, height, round)
end

function Visual:drawExpandingCircle(x, y, radius, amp, speed, verts, fill, lineWidth, hex1, hex2, hex3, map)
    local circle = {}
    local inc = 360/verts

    for i = 1, verts do

        local e = degToRad(inc*i)

        local out = 0
        local circleX
        local circleY


        for z = 1, 16 do 

            circleX = x +  (e[1] * out) + amp * math.sin((math.pi/2)*(timer*speed) + i)
            circleY = y +  (e[2] * out) + amp * math.sin((math.pi/2)*(timer*speed) + i)

            
            if not map:isTouchingObj(circleX, circleY, 2, 2) then
                out = (radius/16) * z
            end
        end

        circle[#circle+1] = circleX
        circle[#circle+1] = circleY
    end 

    love.graphics.setColor(love.math.colorFromBytes(hex1, hex2, hex3))
    love.graphics.setLineWidth(lineWidth)
    
    love.graphics.polygon(fill, circle)
end