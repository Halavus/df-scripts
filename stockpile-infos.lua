-- stockpile-infos.lua
-- Fun fact: [stockpile].room.width & [stockpile].room.height 
-- will forever store the max number they ever had.

local gui = require('gui')

-- cursor check
--local c=df.global.cursor;
--local sp=dfhack.buildings.findAtTile{x=c.x,y=c.y,z=c.z};

local sp = dfhack.gui.getSelectedStockpile(true)

if not sp then
    qerror("No stockpile selected")
end

local n=0

for i=0,sp.room.width*sp.room.height-1 do
    if not sp.room.extents or sp.room.extents[i]~=0 then n=n+1 end 
end

print("Building ID:",sp.id)
print(("SP Number: #%d"):format(sp.stockpile_number))
print("Tiles:",n)
print()
print("Original Width:",sp.room.width)
print("Original Height:",sp.room.height)
print("Original Rectangle:",(sp.room.width)*(sp.room.height))