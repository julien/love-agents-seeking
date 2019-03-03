require('boid')
local math_utils = require('math_utils')

function love.load(arg)
  --[[
  if arg[#arg] == "-debug" then
    require("mobdebug").start()
  end
  ]]--
  -- love.mouse.setVisible(false)

  screenW = love.graphics.getWidth()
  screenH = love.graphics.getHeight()
  mouseTarget = Vec2:new()

  --[[
  -- single boid
  boid = Boid:new({x = screenW / 2, y = screenH / 2})
  ]]--

  -- mulitple boids
  boids = {}
  for i = 1, 100 do
    local boid = Boid:new({x = math.random(screenW), y = math.random(screenH)})
    table.insert(boids, boid)
  end
end

function love.update(dt)
  mouseTarget:set(love.mouse.getX(), love.mouse.getY())

  --[[
  -- single boid
  mouseTarget:set(love.mouse.getX(), love.mouse.getY())
  boid:seek(mouseTarget)
  boid:update()
  ]]--

  --[[ multiple boids  ]]--
  for k,v in ipairs(boids) do
    v:seek(mouseTarget)
    v:update()
  end
end

function love.draw()
  --[[
  -- single boid
  love.graphics.setColor(boid.color['r'], boid.color['g'], boid.color['b'], 255)
  love.graphics.circle('fill', boid.location.x, boid.location.y, boid.radius, 8)
  ]]--

    --[[ multiple boids  ]]--
  for k,v in ipairs(boids) do
    love.graphics.setColor(v.color['r'], v.color['g'], v.color['b'], 255)
    love.graphics.circle('fill', v.location.x, v.location.y, v.radius, 8)
  end
end



