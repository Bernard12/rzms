local PANEL = {}

function PANEL:Init()
    local width = BetterScreenScale() * 300
    local height = BetterScreenScale() * 35
    self:SetWide(width)
    self:SetTall(height)
    
    self:SetPos(ScrW() / 2 - width / 2, ScrH() * 60 / 100)
end

function PANEL:Paint(w, h)
    local lp = MySelf
    if not lp:IsValid() and lp:Team() ~= TEAM_HUMAN then
        return
    end

    local startTime = lp:GetPatientStatusStartTime()
    local duration = lp:GetPatientStatusDuration()
    local isStatusNotExpired = CurTime() - startTime < duration

    if startTime and duration and isStatusNotExpired then
        local remainingTime = duration  - (CurTime() - startTime)
        local partition = math.Clamp(remainingTime / duration, 0, 1)
        local patientName = lp:GetPatient():Name()
        local screenscale = BetterScreenScale()

        local indicatorWidth = self:GetWide()
        local indicatorHeight = screenscale * 15
        local text = "Buff time for " .. patientName

        draw.SimpleTextBlurry(text, "ZSHUDFontTiny", screenscale * 75, 0, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        surface.SetDrawColor(0, 0, 0, 230)
        surface.DrawRect(0, self:GetTall() - indicatorHeight, indicatorWidth, indicatorHeight)

        local color = GetCorrectColor(lp:GetPatientStatusColorId())
        surface.SetDrawColor(color)
        surface.DrawRect(1, self:GetTall() - indicatorHeight + 1, partition * (indicatorWidth - 2), indicatorHeight - 2)
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
    end
    return COLOR_TAN
end

vgui.Register("ZSBuffPanel", PANEL, "Panel")