local ball = {}
ball.__index = ball

function ball.new(players)
    local self = setmetatable({}, ball)

    self.xSpeed = 1000
    self.minYspeed = 30
    self.collider = world:newCircleCollider(200,50,10) 
    self.collider:setRestitution(.7)
    self.collider:setBullet(true)
    self.players = players

    return self
end

function ball:restart()
    self.collider:setPosition(200, 150)
    self:start()
end

function ball:start()
    local startImpulse = 10000
-- on start
    if love.math.random(0,1) == 1 then -- player side
        self.collider:applyLinearImpulse(startImpulse, 0)
    else
        self.collider:applyLinearImpulse(-startImpulse, 0)
    end
end

function ball:onUpdate()
    self:physicsChecks()
    self:checkCollide()
end

function ball:checkCollide()

    for i, player in pairs(self.players) do
        if self.collider then 
            if self.collider:getBody():isTouching(player.goal:getBody()) then
                self:restart()
            end
        end
    end
end

function ball:physicsChecks()
    if not self.collider then return end
   
    local xSpeed, ySpeed = self.collider:getLinearVelocity()
    print(xSpeed, self.collider:getX())

    if xSpeed < 0 then
        self.collider:setLinearVelocity(-self.xSpeed, ySpeed)
    else
        self.collider:setLinearVelocity(self.xSpeed, ySpeed)
    end

    if math.abs(ySpeed) < self.minYspeed then
        if ySpeed > 0 then
            self.collider:applyLinearImpulse(0, self.minYspeed)
        else
            self.collider:applyLinearImpulse(0, -self.minYspeed)
        end
    end
end


return ball