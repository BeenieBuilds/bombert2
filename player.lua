-- player is a body that will contain visual in the future

require('consts')
require('visual')


Player = {}
Player.__index = Player


function Player.new(size, speed, accel)
    local instance = setmetatable({}, Player)

    instance.visual = Visual.new()

    instance.size = size

    instance.speed = speed
    instance.accel = accel

    instance.baseSpeed = speed

    instance.dirX = 0
    instance.dirY = 0

    instance.x = 0
    instance.y = 0

    instance.eyes = {
        {
            x = instance.x,
            y = instance.y,
            size = 9,
            goX = instance.x + (instance.dirX*(instance.size/2)) + (instance.size/2)*instance.dirY,
            goY = instance.y  + (instance.dirY*(instance.size/2)) + (instance.size/2)*instance.dirX,
            vel = 3,
        },   
        {
            x = instance.x,
            y = instance.y,
            size = 9,
            goX = instance.x + (instance.dirX*(instance.size/2)) - (instance.size/2)*instance.dirY,
            goY = instance.y  + (instance.dirY*(instance.size/2)) - (instance.size/2)*instance.dirX,
            vel = 3,
        }   
    }

    instance.spawnCoords = {}

    return instance
end

function Player:changeDirection(key)
    local d = Dirs
    for i = 1, #d do
        if key == d[i][1] or key == d[i][2] then
            self.dirX = d[i][3]
            self.dirY = d[i][4]
        end
    end
end

function Player:setPosition(x, y)
    self.x = x
    self.y = y
end

function Player:move(dt)
    self.x = self.x + (self.dirX*self.speed)
    self.y = self.y + (self.dirY*self.speed)

    self.speed = self.speed + self.accel
end

function Player:collision(face)
    self.speed = self.baseSpeed 
    if face == 1 then
        self.y = self.y - self.speed
    elseif face == 2 then
        self.x = self.x - self.speed
    elseif face == 3 then
        self.y = self.y + self.speed
    elseif face == 4 then
        self.x = self.x + self.speed
    end
end

function Player:kill()
    local s = self.spawnCoords
    self:setPosition(s[1], s[2])
end

function Player:onCollide(dt, obj, face)
    local d = Dirs
    if obj.type == "Foam" then
        self:collision(face)
    elseif obj.type == "Rock" then
        self:collision(face)
        self:kill()
    end
end

function Player:drawPlayer(hitbox)

    self.visual:drawCircle(self.x, self.y, 25.5, 1, 1, 16, "fill", 1, 6,14,81)

    self:drawEyes()

    if hitbox then
        love.graphics.rectangle("line", player.x-(player.size/2), player.y-(player.size/2), player.size, player.size)
    end
end

function Player:updateBody(dt)
    player:updateEyes(15, 17.5, dt)
    self.speed = self.speed + self.accel
end

function Player:updateEyes(away, spacing, dt)

    local s = self.eyes
    -- set the goX and goY to an appropriate position relative to where the player is facing

    s[1].goX = self.x + (self.dirX*(away)) + (spacing)*self.dirY
    s[1].goY = self.y  + (self.dirY*(away)) + (spacing)*self.dirX

    s[2].goX = self.x + (self.dirX*(away)) - (spacing)*self.dirY
    s[2].goY = self.y  + (self.dirY*(away)) - (spacing)*self.dirX

    -- create a vector to get the eye particle to goX and goY, apply jerk and acceleration to get a bounce effect


    local dist1 = distance(s[1].goX, s[1].goY, s[1].x, s[1].y)
    if (dist1 > s[1].vel + 0.5) then

        s[1].x = s[1].x + (s[1].vel + self.speed)*((s[1].goX-s[1].x) / dist1)
        s[1].y = s[1].y + (s[1].vel + self.speed)*((s[1].goY-s[1].y) / dist1)
    else
        s[1].x = s[1].goX
        s[1].y = s[1].goY
    end


    local dist2 = distance(s[2].goX, s[2].goY, s[2].x, s[2].y)
    if (dist2 > s[2].vel + 0.5) then
        s[2].x = s[2].x + (s[2].vel + self.speed)*((s[2].goX-s[2].x) / dist2)
        s[2].y = s[2].y + (s[2].vel + self.speed)*((s[2].goY-s[2].y) / dist2)
    else 
        s[2].x = s[2].goX
        s[2].y = s[2].goY
    end
end

function Player:drawEyes()
    
    local s = self.eyes

    self.visual:drawCircle(s[1].x, s[1].y, s[1].size, 0.5, 2, 16, "fill", 1, 230, 230, 230)
    self.visual:drawCircle(s[2].x, s[2].y, s[2].size, 0.5, 2, 16, "fill", 1,  230, 230, 230)

end