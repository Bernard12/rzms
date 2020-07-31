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

function SWEP:RenderBuffProgressBar()
    local startTime = self:GetPatientStatusStartTime()
    local duration = self:GetPatientStatusDuration()
    local isStatusNotExpired = CurTime() - startTime < duration

    if startTime and duration and isStatusNotExpired then
        local remainingTime = duration  - (CurTime() - startTime)
        local partition = math.Clamp(remainingTime / duration, 0, 1)
        local patientName = self:GetPatient():Name()
        local screenscale = BetterScreenScale()

        local indicatorWidth = 280 * screenscale
        local indicatorHeight = 10 * screenscale
		
		local matGlow = Material("particle/smokesprites_0001")
		local texDownEdge = surface.GetTextureID("gui/gradient_down")
		local color = GetCorrectColor(self:GetPatientStatusColorId())

		local x, y
		x = ScrW() / 2 - indicatorWidth / 2
		y = ScrH() * 55 / 100

		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(x, y, indicatorWidth, indicatorHeight)

		surface.SetDrawColor(color)
		surface.SetTexture(texDownEdge)
		surface.DrawTexturedRect(x + 1, y + 1, partition * (indicatorWidth - 2), indicatorHeight - 2)
		
		surface.SetMaterial(matGlow)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x + partition * (indicatorWidth-2), y - indicatorHeight / 2, 4, indicatorHeight * 2)
    end

    return true
end

function GetCorrectColor(colorId)
    if colorId == PATIENT_COLOR_GRAY then
        return COLOR_GRAY
    elseif colorId == PATIENT_COLOR_RED then
        -- Need separate constants for these
        return Color(200, 100, 90)
    elseif colorId == PATIENT_COLOR_BLUE then
        -- Need separate constants for these
        return Color(90, 120, 220)
    elseif colorId == PATIENT_COLOR_GREEN then
        return Color(130, 220, 110)
    end
    return COLOR_TAN
end