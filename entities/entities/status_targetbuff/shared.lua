ENT.Type = "anim"
ENT.Base = "status__base"

AccessorFuncDT(ENT, "Duration",  "Float", 0)
AccessorFuncDT(ENT, "StartTime", "Float", 4)
AccessorFuncDT(ENT, "EndTime",   "Float", 8)

function ENT:PlayerSet()
	local currentTime = CurTime()
	self:SetStartTime(currentTime)
	self:SetEndTime(currentTime + self:GetDuration())
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		hook.Add("EntityTakeDamage", self, self.EntityTakeDamage)
	end
end
