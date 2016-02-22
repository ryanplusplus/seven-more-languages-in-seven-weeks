--[[
Write a function called concatenate(a1, a2) that takes two arrays and returns a
new array with all the elements of a1 followed by all the elements of a2.
]]

local function concatenate(a1, a2)
  local concatenation = {}
  for _, v in ipairs(a1) do table.insert(concatenation, v) end
  for _, v in ipairs(a2) do table.insert(concatenation, v) end
  return concatenation
end

print(table.concat(concatenate({ 'a', 'b', 'c' }, { 1, 2, 3 }), ', '))

--[[
Change the global metatable you discovered in the Find section earlier so that
any time you try to add two arrays using the plus sign (e.g., a1 + a2), Lua
concatenates them together using your concatenate() function.

Kinda wonky, but apparently you're supposed to use __newindex on _G to
modify new _global_ tables as they're created:
https://forums.pragprog.com/forums/351/topics/13237
]]

setmetatable(_G, {
  __newindex = function(t, k, v)
    if type(v) == 'table' then
      setmetatable(v, { __add = concatenate })
    end
    rawset(t, k, v)
  end
})

-- These must be global so that __newindex on _G can catch them
a = { 'a', 'b', 'c' }
b = { 1, 2, 3 }
print(table.concat(a + b, ', '))
