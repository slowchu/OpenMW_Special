local core = require('openmw.core')
local self = require('openmw.self')
local NPC = require('openmw.types').NPC

local dispositionModifier = 0

local function modifyDisposition(data)
   assert(data and data.modifier and data.toward)
   if data.modifier == dispositionModifier then return end
   local diffModifier = data.modifier - dispositionModifier
   NPC.modifyBaseDisposition(self, data.toward, diffModifier)
   dispositionModifier = data.modifier
end

local function onSave()
   return { dispositionModifier = dispositionModifier }
end

local function onLoad(data, _)
   dispositionModifier = data and data.dispositionModifier or 0
end

return {
   engineHandlers = {
      onLoad = onLoad,
      onSave = onSave,
   },
   eventHandlers = {
      SpecialModifyDisposition = modifyDisposition,
   },
}
