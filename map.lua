require('consts')
require('object')

Map = {}
Map.__index = Map

function Map.new(charMap, x, y, size)
    local instance = setmetatable({}, Map)

    instance.charMap = charMap
    instance.map = {}
    instance.x = x
    instance.y = y
    instance.size = size
    instance.spawnCoords = {}

    return instance
end

local function deleteMap(map)
    map.map = {}
end

local function getNameFromChar(char)
    local o = Objs
    for i = 1, #o do
        if char == o[i][1] then
            return {o[i][2], o[i][3], o[i][4]}
        end
    end
    return "None"
end

function Map:createMap()

    deleteMap(self)

    local height = #self.charMap
    local width = #self.charMap[1]

    for y = 1, height do
        self.map[y] = {}
        for x = 1, width do

            local e = getNameFromChar(self.charMap[y][x])

            self.map[y][x] = 
            Object.new(
                e[1], 
                self.x + self.size*x,
                self.y + self.size*y,
                self.size,
                e[2],
                e[3]
            )
            
            if self.map[y][x].type == "In" then
                self.spawnCoords = {self.map[y][x].x, self.map[y][x].y}
            end
        end
    end
end

function Map:getSpawnCoords()
    return self.spawnCoords
end

-- used for checking hitboxes between a living, breathing entity and the map
function Map:hitboxes(player, dt)
    local xPos = player.x / self.size
    local yPos = player.y / self.size

    if xPos % 1 < 0.5 then
        xPos = math.floor(xPos)
    else
        xPos = math.ceil(xPos)
    end

    if yPos % 1 < 0.5 then
        yPos = math.floor(yPos)
    else 
        yPos = math.ceil(yPos)
    end

    for y = -1, 1 do
        for x = -1, 1 do

            if not ((yPos + y <= 0) or (yPos + y > #self.map) or (xPos + x <= 0) or (xPos + x > #self.map[1])) then
                local e = self.map[yPos+y][xPos+x]:checkBoxColliders(player.x, player.y, player.size, player.size)
                if e[1] then

                    player:onCollide(dt, e[2], e[3])

                end
            end    
        end
    end
end

-- used for checking collisions between particles that dont inherently have an x, y or size and the map
function Map:isTouchingObj(ox, oy, width, height)
    local xPos = ox / self.size
    local yPos = oy / self.size

    if xPos % 1 < 0.5 then
        xPos = math.floor(xPos)
    else
        xPos = math.ceil(xPos)
    end

    if yPos % 1 < 0.5 then
        yPos = math.floor(yPos)
    else 
        yPos = math.ceil(yPos)
    end

    for y = -1, 1 do
        for x = -1, 1 do



            if not ((yPos + y <= 0) or (yPos + y > #self.map) or (xPos + x <= 0) or (xPos + x > #self.map[1])) then

                if self.map[yPos+y][xPos+x].collide then

                    local e = self.map[yPos+y][xPos+x]:checkBoxColliders(ox, oy, width, height)
                    if e[1] then
                        return true
                    end

                end
            end   
        end
    end

    return false
end

function Map:drawHitboxes(x1, y1)

    local xPos = x1 / self.size
    local yPos = y1 / self.size

    if xPos % 1 < 0.5 then
        xPos = math.floor(xPos)
    else
        xPos = math.ceil(xPos)
    end

    if yPos % 1 < 0.5 then
        yPos = math.floor(yPos)
    else 
        yPos = math.ceil(yPos)
    end

    for y = -1, 1 do
        for x = -1, 1 do
            local s = self.map[yPos+y][xPos+x]
            if not (s.type == "None") then
                s:drawBoxColliders()
            end
        end
    end
end

function Map:drawMap()
    for y = 1, #self.map do
        for x = 1, #self.map[1] do
            local s = self.map[y][x]
            if not (s.type == "None") then
                s:draw()
            end
        end
    end
end

function Map:updateMap(dt)
    for y = 1, #self.map do
        for x = 1, #self.map[1] do
            local s = self.map[y][x]
            if not (s.type == "None") then
                s:update()
            end
        end
    end
end