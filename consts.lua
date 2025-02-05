

Dirs = {
    {"w", "up", 0, -1},
    {"a", "left", -1, 0},
    {"s", "down", 0, 1},
    {"d", "right", 1, 0},
}

Objs = {
    {" ", "None", false},
    {"f", "Foam", true},
    {"e", "Edge", true},
    {"x", "EdgeRock", true},
    {"r", "Rock", true},
    {"i", "In", false},
    {"o", "Out", false}
}

timer = 0

function degToRad(degree)
    local convert = (degree)*(math.pi/180)
    return {math.cos(convert), math.sin(convert)}
end

function distance(x1, y1, x2, y2)
    return math.sqrt(math.pow((x2-x1), 2) + math.pow((y2-y1), 2))
end