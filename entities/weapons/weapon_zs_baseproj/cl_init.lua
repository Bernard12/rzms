INC_CLIENT()

SWEP.ViewModelFlip = false

function SWEP:ShootBullets(damage, numshots, cone)
	local owner = self:GetOwner()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	if self.Recoil > 0 then
		local r = math.Rand(0.8, 1)
		owner:ViewPunch(Angle(r * -self.Recoil, 0, (1 - r) * (math.random(2) == 1 and -1 or 1) * self.Recoil))
	end
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
		y = ScrH() * 59 / 100

		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(x, y, indicatorWidth, indicatorHeight)

		surface.SetDrawColor(color)
		surface.SetTexture(texDownEdge)
		surface.DrawTexturedRect(x + 1, y + 1, partition * (indicatorWidth - 2), indicatorHeight - 2)
		
		surface.SetMaterial(matGlow)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x + partition * (indicatorWidth-2), y - indicatorHeight / 2, 4, indicatorHeight * 2)
    end

	self:RenderStamina()
    return true
end

function SWEP:RenderStamina()
	if MySelf:Team() == TEAM_HUMAN then
        
		local screenscale = BetterScreenScale()
		basewid, hei = 280 * screenscale, 12 * screenscale

		wid = 280 * screenscale

		x = ScrW() / 2 - ( wid /2 )
		y = ScrH() * 0.60

		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(x, y, wid, hei)
	end

    if GetConVar("crosshair"):GetInt() ~= 1 then return end
    self:DrawCrosshairDot()
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