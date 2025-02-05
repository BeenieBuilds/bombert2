require('player')
require('console')
require('object')
require('consts')
require('map')


function love.load()

    love.graphics.setBackgroundColor(love.math.colorFromBytes(210, 210, 220))
    love.graphics.setLineStyle("rough")
    love.window.setMode(800, 800)
    
    console = Console.new(600, 100, 2, 2)

    map = Map.new(
        {
            {"f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f"},
            {"f", " ", " ", "i", " ", " ", " ", " ", " ", " ", " ", "f"},
            {"f", " ", " ", " ", " ", " ", "f", " ", "f", " ", " ", "f"},
            {"f", " ", " ", " ", " ", "f", " ", " ", " ", " ", "f", "f"},
            {"f", " ", " ", "r", " ", "f", "f", " ", " ", "f", " ", "f"},
            {"f", " ", "r", " ", " ", " ", " ", " ", " ", "f", " ", "f"},
            {"f", " ", " ", "r", " ", " ", " ", " ", " ", " ", " ", "f"},
            {"f", " ", " ", " ", " ", "f", " ", "f", " ", " ", " ", "f"},
            {"f", " ", " ", " ", "f", "f", " ", " ", "f", " ", " ", "f"},
            {"f", " ", " ", "f", "f", " ", " ", "f", " ", " ", " ", "f"},
            {"f", " ", " ", " ", " ", " ", " ", " ", " ", " ", "o", "f"},
            {"f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f"},
        },
        0,
        0,
        60
    )
    map:createMap()

    player = Player.new(20, 2, 0.0001)
    player:setPosition(200,200)
    player.spawnCoords = map:getSpawnCoords()

    print(player.spawnCoords[1] .. " " .. player.spawnCoords[2])

end

function love.update(dt)

    timer = timer + dt

    player:move(dt)
    player:updateBody(dt)

    map:hitboxes(player, dt)
end

function love.draw()

    console:load()
    player:drawPlayer(map, false)

    map:drawMap()

end

function love.keypressed(key, scancode)
    player:changeDirection(key)
end