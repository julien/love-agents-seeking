require 'math'
require 'vec2'

Boid = {}

function Boid:new(v)
  v = v or {}
  
  o = {
    location = Vec2:new({x = v.x or 0, y = v.y or 0}),
    acceleration = Vec2:new(),
    velocity = Vec2:new(),
    maxforce = math.random(1, 3) * 0.1,
    maxspeed = math.random(4, 6),
    radius = math.random(3, 8),
    color =  {
      r = math.random(255),
      g = math.random(255),
      b = math.random(255)
    }
  }
  
  self.__index = self
  return setmetatable(o, self)
end

function Boid:update()
  self.velocity:add(self.acceleration)
  self.velocity:limit(self.maxspeed)
  self.location:add(self.velocity)
  self.acceleration:mult(0)
end

function Boid:applyForce(force)
  self.acceleration:add(force);
end

function Boid:seek(target)
  local x = 0
  local y = 0

  x = target.x - self.location.x
  y = target.y - self.location.y
 
  desired = Vec2:new({x = x, y = y})
  desired:normalize()
  desired:mult(self.maxspeed)
  
  x = desired.x - self.velocity.x
  y = desired.y - self.velocity.y
  
  steer = Vec2:new({x = x, y = y})
  steer:limit(self.maxforce)

  self:applyForce(steer)
  
end

