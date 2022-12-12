cpu = {}

cpu.x = points[2].x - 50
cpu.y = 80
cpu.width = 15
cpu.height = 60
cpu.maxVelocity = 700

cpu.collider = world:newRectangleCollider(cpu.x, cpu.y, cpu.width, cpu.height)
cpu.collider:setFixedRotation(true)
--cpu.collider:setBullet(true)
cpu.collider:setMass(0)


function cpu.onUpdate()
    cpu.processMovement()
    cpu.limitMovement()
end

function cpu.limitMovement()
    local xSpeed, ySpeed = cpu.collider:getLinearVelocity() 
   
    if math.abs(ySpeed) > cpu.maxVelocity then
        if ySpeed < 0 then
            cpu.collider:applyLinearImpulse(0, cpu.maxVelocity*.25) 
        else
            cpu.collider:applyLinearImpulse(0, -cpu.maxVelocity*.25) 
        end
    end
end

function cpu.processMovement()
    cpu.collider:setX(cpu.x)
    cpu.collider:setY(ball.collider:getY())

   --[[ cpu.collider:setX(cpu.x)

    if cpu.x - ball.collider:getX() < 150 then
        local target = cpu.collider:getY() - ball.collider:getY()   
        cpu.collider:applyLinearImpulse(0, -target*1.1)
        cpu.collider:setType("dynamic")

    else
        cpu.collider:setType("static")
        cpu.collider:setX(cpu.x)
    end]]
end

function cpu.drawShape()
    love.graphics.setColor(1,0,0)
    cpu.shape = love.graphics.rectangle("fill", cpu.collider:getX() - (cpu.width/2), cpu.collider:getY() - (cpu.height/2), cpu.width, cpu.height)
end

return cpu