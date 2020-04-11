a = input('Write your name: ')
mprintf('Hello, %s', a)

n = 10
s = 0

for i = 1 : n do
    s = s + i
end

s1 = 0

while n > 0 do
    s1 = s1 + n
    n = n - 1
end

if s1 > s then
    mprintf('Error')
end

