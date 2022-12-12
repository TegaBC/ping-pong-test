windfield = require "windfield"

function love.load()
    x, y, w, h = 20, 20, 60, 20
    world = windfield.newWorld(0,500,false)

    -- Points for a square using line colliders
    points = {
        [1] = {x = 30, y = 30}, -- top left
        [2] = {x = 500, y = 30}, -- top right
        [3] = {x = 30, y = 300}, -- bottom left
        [4] = {x = 500, y = 300}, -- bottom right
    }

    lines = {
        line1 = world:newLineCollider(points[1].x, points[1].y, points[2].x, points[2].y),
        line2 = world:newLineCollider(points[3].x, points[3].y, points[4].x, points[4].y),
        line3 = world:newLineCollider(points[1].x, points[1].y, points[3].x, points[3].y),
        line4 = world:newLineCollider(points[2].x, points[2].y, points[4].x, points[4].y),
    }
    
    for i, line in pairs(lines) do
        line:setType("static")
    end

    playerModule = require "player.player"
    ballModule = require "game-objects.ball"
    
   -- cpu = require "game-objects.cpu"
    player1 = playerModule.new(points[1].x + 50, {Up = "up", Down = "down"}, {1, 0.5, 0.25}, lines.line3)
    player2 = playerModule.new(points[2].x - 50, {Up = "w", Down = "s"}, nil, lines.line4)

    ball = ballModule.new(player.getPlayers())
end

function love.update(dt)
    world:update(dt)
    playerModule.updateAll()
    
    ball:onUpdate()
end

function love.draw()
    world:draw()
    player.drawAll()
end

