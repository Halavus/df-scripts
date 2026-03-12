-- stockpile-infos.lua
-- Fun fact: [stockpile].room.width & [stockpile].room.height will forever store the max number they ever had.

local gui = require('gui')

-- cursor check
--local c=df.global.cursor;
--local sp=dfhack.buildings.findAtTile{x=c.x,y=c.y,z=c.z};

local sp = dfhack.gui.getSelectedStockpile(true)

local function get_sp_id(opts)
    if opts.id then return opts.id end
    if not sp then
        qerror('Please select a stockpile or specify the stockpile ID')
    end
    return sp.id
end

if sp then
    local n=0
    
    for i=0,sp.room.width*sp.room.height-1 do
        if not sp.room.extents or sp.room.extents[i]~=0 then n=n+1 end 
    end
    
    print("SP ID:",get_sp_id(sp))
    print("width:",sp.room.width)
    print("height:",sp.room.height)
    print("tiles:",n,"rectangle:",(sp.room.width)*(sp.room.height)) 
    
    else print("no stockpile selected")
    
end