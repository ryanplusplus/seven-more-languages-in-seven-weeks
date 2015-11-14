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
Our strict table implementation in Reading and Writing, on page 19 doesn't
provide a way to delete items from the table. If we try the usual approach,
treasure.gold = nil, we get a duplicate key error. Modify strict_write() to allow
deleting keys (by setting their values to nil).
]]

local mt = {
  __index = function(t, k)
    if t._data[k] then return t._data[k]
    else error('Invalid key: ' .. k) end
  end,

  __newindex = function(t, k, v)
    if v ~= nil and t._data[k] then error('Duplicate key: ' .. k)
    else t._data[k] = v end
  end
}

local treasure = setmetatable({ _data = {} }, mt)

treasure.gold = 50
print(treasure.gold)

if pcall(function() print(treasure.silver) end) then
  print('uh oh, allows reading non-existent keys')
end

if pcall(function() treasure.gold = 100 end) then
  print('uh oh, allows re-writing keys')
end

if not pcall(function() treasure.gold = nil end) then
  print('uh oh, does not allow erasing keys')
end
