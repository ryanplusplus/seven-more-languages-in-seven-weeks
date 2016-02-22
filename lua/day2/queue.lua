--[[
Using Lua's built-in OO syntax, write a class called Queue that implements a
first-in, first-out (FIFO) queue as follows.
]]

local Queue = (function()
  local api = {}

  function api:add(item)
    table.insert(self._items, item)
  end

  function api:remove()
    return table.remove(self._items, 1)
  end

  return {
    new = function()
      return setmetatable({ _items = {} }, { __index = api })
    end
  }
end)()

local q = Queue.new()

q:add(1)
q:add(2)
q:add(3)
print(q:remove())
print(q:remove())
print(q:remove())
