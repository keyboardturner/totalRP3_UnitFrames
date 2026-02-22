local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpPlayer = TRP3_UnitFrames.trpPlayer;

local PlayerRepFrame = CreateFrame("Frame", nil, PlayerFrame)
PlayerRepFrame:SetPoint("TOPRIGHT", PlayerFrame, "TOPRIGHT", -22, -26)
PlayerRepFrame:SetWidth(135)
PlayerRepFrame:SetHeight(18)
PlayerRepFrame.tex = PlayerRepFrame:CreateTexture("PlayerFrameReputationColor", "BACKGROUND", nil, 0)
PlayerRepFrame.tex:SetAllPoints(PlayerRepFrame)
PlayerRepFrame.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
PlayerRepFrame.tex:SetTexCoord(1, 0, 0, 1)
PlayerRepFrame.tex:SetVertexColor(0,0,0,1)

--set info on frames

function trpPlayer.UpdateInfo()
	local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("player")).r, C_ClassColor.GetClassColor(UnitClassBase("player")).g, C_ClassColor.GetClassColor(UnitClassBase("player")).b
	
	if TRP3_UF_DB.Setting.FullNamePlayer == true and TRP3_UF_DB.Setting.UseTRPName == true then
		PlayerName:SetText(TRP3_API.r.name("player"))
	elseif TRP3_UF_DB.Setting.FullNamePlayer == false and TRP3_UF_DB.Setting.UseTRPName == true then
		PlayerName:SetText(AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("player")):GetFirstName())
	else
		PlayerName:SetText(UnitName("player"))
	end
	
	PlayerName:SetTextColor(1, 0.896, 0, 1)
	PlayerFrameReputationColor:SetVertexColor(0, 0, 0, 0)
	
	if TRP3_UF_DB.Player.colorTextClass == true then
		PlayerName:SetTextColor(classR, classG, classB)
	end
	
	local customColor = AddOn_TotalRP3.Player.CreateFromUnit("player"):GetCustomColorForDisplay()
	if customColor ~= nil then
		PlayerName:SetTextColor(customColor:GetRGB())
	end

	if TRP3_UF_DB.Player.colorTextCustom == true then
		PlayerName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorText))
	end

	if TRP3_UF_DB.Player.colorBackClass == true then
		PlayerFrameReputationColor:SetVertexColor(classR, classG, classB, 1)
	end
	if TRP3_UF_DB.Player.colorBackCustom == true then
		PlayerFrameReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Player.colorBack))
	end
	if TRP3_UF_DB.Player.colorBackClass == false and TRP3_UF_DB.Player.colorBackCustom == false then
		PlayerFrameReputationColor:SetVertexColor(0, 0, 0, 0)
	end

	if AddOn_TotalRP3.Player.CreateFromUnit("player"):GetProfileID() ~= nil then
		local player1 = AddOn_TotalRP3.Player.CreateFromUnit("player")
		local icon = player1:GetCustomIcon() or "inv_inscription_scroll"
		
		if trpPlayer.button and trpPlayer.button.tex then
			trpPlayer.button.tex:SetTexture("Interface/icons/" .. icon)
			trpPlayer.button.tex:SetTexCoord(0, 1, 0, 1)
			if not trpPlayer.button.tex.TrpMask then
				trpPlayer.button.tex.TrpMask = trpPlayer.button:CreateMaskTexture()
				trpPlayer.button.tex.TrpMask:SetAtlas("UI-HUD-UnitFrame-Player-Portrait-Mask")
				trpPlayer.button.tex.TrpMask:SetAllPoints(trpPlayer.button.tex)
				trpPlayer.button.tex:AddMaskTexture(trpPlayer.button.tex.TrpMask)
			end
		end

		if TRP3_UF_DB.Player.relativePoint == "CENTER" then
			if trpPlayer.button then
				trpPlayer.button:Hide()
			end
			if trpPlayer.portraitClick then
				trpPlayer.portraitClick:Show()
			end
			PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexture("Interface/icons/" .. icon)
			PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexCoord(0, 1, 0, 1)
		else
			if not InCombatLockdown() then
				if trpPlayer.button then
					trpPlayer.button:Show()
				end
			end
			if trpPlayer.portraitClick then
				trpPlayer.portraitClick:Hide()
			end
			SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player")
		end

		if trpPlayer.SetAsPortrait then
			trpPlayer.SetAsPortrait()
		end
	else
		if trpPlayer.button then
			trpPlayer.button:Hide()
		end
		if trpPlayer.portraitClick then
			trpPlayer.portraitClick:Hide()
		end
		SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player")
	end
end