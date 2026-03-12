local unit = dfhack.gui.getSelectedUnit(true)
for _, invItem in ipairs(unit.inventory) do
    local item = invItem.item
    if dfhack.items.getOwner(item) ~= unit then
        dfhack.items.setOwner(item, unit)
    end
end