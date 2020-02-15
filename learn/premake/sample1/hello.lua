-- run with following command 
-- premake5 --file=hello.lua vs2019 
print("Hello Lua in Premake!")

local t1 = {"A", "B", "C"}

print(t1["A"])


-- premake5 can run any lua script

print {"A", "B", "C"}