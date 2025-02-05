require('player')
require('console')
require('object')
require('consts')
require('map')


function love.load()

    love.graphics.setBackgroundColor(love.math.colorFromBytes(224,224,224))
    love.graphics.setLineStyle("rough")
    love.window.setMode(1000, 1000)
    
    console = Console.new(600, 100, 2, 2)

    map = Map.new(
        {
            {"e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e"},
            {"e", " ", " ", "i", " ", " ", " ", " ", " ", " ", " ", "e"},
            {"e", " ", " ", " ", " ", " ", "f", " ", "f", " ", " ", "e"},
            {"e", " ", " ", " ", " ", "f", " ", " ", " ", " ", "f", "e"},
            {"e", " ", " ", "r", " ", "f", "f", " ", " ", "f", " ", "e"},
            {"e", " ", "r", " ", "^", " ", " ", " ", " ", "f", " ", "e"},
            {"e", " ", " ", "r", " ", " ", " ", " ", " ", " ", " ", "e"},
            {"e", " ", " ", " ", " ", "f", " ", "f", " ", " ", " ", "e"},
            {"e", " ", " ", " ", "f", "f", " ", " ", "f", " ", " ", "e"},
            {"e", " ", " ", "f", "f", " ", " ", "f", " ", " ", " ", "e"},
            {"e", " ", " ", " ", " ", " ", " ", " ", " ", " ", "o", "e"},
            {"e", "e", "x", "x", "x", "x", "e", "e", "e", "e", "e", "e"},
        },
        0,
        0,
        77.5
    )
    map:createMap()

    player = Player.new(35, 1.4, 0.0002)
    player:setPosition(200,200)

    player.spawnCoords = map:getSpawnCoords()

    print(player.spawnCoords[1] .. " " .. player.spawnCoords[2])

end

function love.update(dt)

    timer = timer + dt

    player:move(dt)
    player:updateBody(dt)
    map:updateMap(dt)

    map:hitboxes(player, dt)
end

function love.draw()

    console:load()

    -- map needs to be parsed through because of the players mesh collisions
    player:drawPlayer(false, map)

    map:drawMap()

end

function love.keypressed(key, scancode)
    player:changeDirection(key)


end