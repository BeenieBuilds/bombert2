-- object is the representation of an object stored in map, contains a visual object so it can draw itself


require('consts')
require('visual')

Object = {}
Object.__index = Object




function Object.new(type, x, y, size)
    local instance = setmetatable({}, Object)

    instance.type = type
    instance.x = x
    instance.y = y
    instance.size = size
    instance.visual = Visual.new()

    instance.colliders = {}


    local d = Dirs
    for i = 1, 4 do
        instance.colliders[#instance.colliders+1] = 
        {   
            face = i,
            x = instance.x + ((instance.size/2) - 20/2)*d[i][3],
            y = instance.y + ((instance.size/2) - 20/2)*d[i][4],
            -- to ensure that width is real we do abs
            -- we also do others
            width = (instance.size - 10) * math.abs(d[i][4]) + 20 * math.abs(d[i][3]),
            height = (instance.size - 10) * math.abs(d[i][3]) +  20 * math.abs(d[i][4])
        }
    end

    return instance
end


local function checkCollision(x, y, width, height, x2, y2, width2, height2)
    -- checking x cols
    return x+(width/2) > x2-(width2/2) and x-(width/2) < x2+(width2/2) 
    -- checking y cols
    and y+(height/2) > y2-(height2/2) and  y-(height/2) < y2+(height2/2)
end

function Object:checkBoxColliders(x, y, width, height)
    local s = self.colliders 
    for i = 1, #s do

        if checkCollision(x, y, width, height, s[i].x, s[i].y, s[i].width, s[i].height) then
            -- returns collision, object it collides into, and face
            return {true, self, s[i].face}
        end
    end
    -- returns collision only
    return {false}
end

function Object:drawBoxColliders()
    local o = self.colliders
    for i = 1, 4 do 
        love.graphics.rectangle("line", o[i].x - (o[i].width/2), o[i].y - (o[i].height/2), o[i].width, o[i].height)
    end 
end

function Object:draw()
    if self.type == "Foam" then
        self.visual:drawBlock(self.x, self.y, self.size, self.size, 7, "fill", 1, 70, 70, 70)
    end
    if self.type == "Rock" then
        self.visual:drawBlock(self.x, self.y, self.size, self.size, 7, "fill", 1, 50, 50, 50)
        self.visual:drawSpikes(self.x, self.y, self.size/1.08, self.size/1.08, 4, 4, 8, "line", 4, 50, 50, 50)
    end
    if self.type == "In" then
        self.visual:drawCircle(self.x, self.y, self.size/2.2, 1.5, 2, 32, "line", 4, 230, 0, 0)
    end
    if self.type == "Out" then
        self.visual:drawCircle(self.x, self.y, self.size/2.2, 1.5, 2, 32, "line", 4, 0, 0, 230)
    end
end