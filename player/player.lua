player = {}
player.__index = player

local allPlayers = {}

function player.getPlayers()
    return allPlayers
end

function player.updateAll()
    for i, player in pairs(allPlayers) do
        player:onUpdate()
    end
end

function player.drawAll()
    for i, player in pairs(allPlayers) do
        player:drawShape()
    end
end

function player.new(xStart, controls, paddleColor, goal)
    local self = setmetatable({}, player)

    -- props
    self.x = xStart
    self.y = 80
    self.width = 5
    self.height = 60
    self.maxVelocity = 600
    self.upBind = controls.Up
    self.downBind = controls.Down
    self.paddleColor = paddleColor or {0,1,0.5}
    self.goal = goal

    -- collider
    self.collider = world:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setType("dynamic")
    self.collider:setFixedRotation(true)

    table.insert(allPlayers, self)
    return self
end

function player:onUpdate()
    self:updateProps()
    self:getMovement()
end

function player:updateProps()
   self.y = self.collider:getY()
end

function player:getMovement()
    -- Get movement
    self:freezeCollider(false)

    if love.keyboard.isDown(self.downBind) then
        self.collider:setLinearVelocity(0, self.maxVelocity)
    elseif love.keyboard.isDown(self.upBind) then
        self.collider:setLinearVelocity(0, -self.maxVelocity)
    else
        self:freezeCollider(true)
    end

    self.collider:setX(self.x)
end

function player:freezeCollider(freeze)
    if freeze then
        self.collider:setType("static")
        self.collider:setPosition(self.collider:getX(), self.collider:getY())
    else
        self.collider:setType("dynamic")
        self.collider:setPosition(self.x, self.y)
    end
end

function player:drawShape()
    love.graphics.setColor(self.paddleColor)
    self.shape = love.graphics.rectangle("fill", self.collider:getX() - (self.width/2), self.collider:getY() - (self.height/2), self.width, self.height)
end

return player