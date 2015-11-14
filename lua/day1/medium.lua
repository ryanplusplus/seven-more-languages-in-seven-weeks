--[[
What if Lua didn't have a for loop? Using if and while, write a function
for_loop(a, b, f) that calls f() on each integer from a to b (inclusive).
]]

local function for_loop(a, b, f)
  local i = a
  while i <= b do
    f(i)
    i = i + 1
  end
end

for_loop(1, 10, function(i)
  print(i)
end)
