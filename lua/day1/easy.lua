--[[
Write a function called ends_in_3(num) that returns true if the final digit of
num is 3, and false otherwise.
]]

local function ends_in_3(num)
  return tostring(num):sub(-1) == '3'
end

print('ends in 3?', 3, ends_in_3(3))
print('ends in 3?', 12, ends_in_3(12))
print('ends in 3?', 798453, ends_in_3(798453))

--[[
Now, write a similar function called is_prime(num) to test if a number is prime
(that is, it's divisible only by itself and 1).
]]

local function is_prime(num)
  for i = 2, num - 1 do
    if num % i == 0 then return false end
  end
  return true
end

print('is prime?', 3, is_prime(3))
print('is prime?', 9, is_prime(9))
print('is prime?', 13, is_prime(13))
print('is prime?', 1024, is_prime(1024))

--[[
Create a program to print the first n prime numbers that end in 3
]]

local function primes_ending_in_3(count)
  local result = {}
  for i = 2, math.huge do
    if ends_in_3(i) and is_prime(i) then
      table.insert(result, i)
      if #result == count then return result end
    end
  end
end

print('the first 10 primes ending in 3: ' .. table.concat(primes_ending_in_3(10), ', '))
