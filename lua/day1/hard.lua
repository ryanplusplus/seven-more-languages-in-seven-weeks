--[[
Write a function reduce(max, init, f) that calls a function f() over the integers
from 1 to max like so:

  function add(previous, next)
    return previous + next
  end

  reduce(5, 0, add) -- add the numbers from 1 to 5

  -- We want reduce() to call add() 5 times with each intermediate
  -- result, and return the final value of 15:
  --
  add( 0, 1) --> returns 1; feed this into the next call
  add( 1, 2) --> returns 3
  add( 3, 3) --> returns 6
  add( 6, 2) --> returns 10
  add(10, 2) --> returns 15
]]

local function reduce(max, value, f)
  for i = 1, max do
    value = f(value, i)
  end
  return value
end

local function add(previous, next)
  return previous + next
end

print(reduce(5, 0, add))

--[[
Implement factorial() in terms of reduce().
]]

local function factorial(n)
  return reduce(n, 1, function(acc, i)
    return acc * i
  end)
end

print(factorial(5))
