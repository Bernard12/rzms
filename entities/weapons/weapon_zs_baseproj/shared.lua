SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "crossbow"

SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.UseHands = true

SWEP.ConeMax = 2
SWEP.ConeMin = 1

SWEP.Primary.ProjVelocity = 1400

function SWEP:SetPatient(ent, duration, color)
	self:SetDTEntity(DT_BUFF_ENT_PATIENT, ent)
	self:SetDTFloat(DT_BUFF_FLOAT_PATIENT_START_TIME, CurTime())
	self:SetDTFloat(DT_BUFF_FLOAT_PATIENT_DURATION, duration)
	self:SetDTInt(DT_BUFF_INT_PATIENT_COLOR_ID, color)
end

function SWEP:GetPatient()
	return self:GetDTEntity(DT_BUFF_ENT_PATIENT)
end

function SWEP:GetPatientStatusStartTime()
	return self:GetDTFloat(DT_BUFF_FLOAT_PATIENT_START_TIME)
end

function SWEP:GetPatientStatusDuration()
	return self:GetDTFloat(DT_BUFF_FLOAT_PATIENT_DURATION)
end

function SWEP:GetPatientStatusColorId()
	return self:GetDTInt(DT_BUFF_INT_PATIENT_COLOR_ID)
end