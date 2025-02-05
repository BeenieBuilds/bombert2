

Dirs = {
    {"w", "up", 0, -1},
    {"a", "left", -1, 0},
    {"s", "down", 0, 1},
    {"d", "right", 1, 0},
}

Objs = {
    -- character, name, collide, collisionType
    {" ", "None", false, "Always"},
    {"f", "Foam", true, "Always"},
    {"e", "Edge", true, "Always"},
    {"x", "EdgeRock", true, "Always"},
    {"r", "Rock", true, "Always"},
    {"i", "In", false, "Always"},
    {"o", "Out", false, "Always"},
    {"^", "Speed", false, "Battery"},
    {"v", "Slow", false, "Battery"},
}

timer = 0

function degToRad(degree)
    local convert = (degree)*(math.pi/180)
    return {math.cos(convert), math.sin(convert)}
end

function distance(x1, y1, x2, y2)
    return math.sqrt(math.pow((x2-x1), 2) + math.pow((y2-y1), 2))
end