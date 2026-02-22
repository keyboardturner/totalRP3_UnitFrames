local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;

function trpTarget.SetColor()
	if TRP3_UF_DB.Target.colorBackCustom == true then
		TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
	end
	if TRP3_UF_DB.Target.colorTextCustom == true then
		if TRP3_UF_DB.Setting.FullNameTarget == true and TRP3_UF_DB.Setting.UseTRPName == true then
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(TRP3_API.r.name("target"))
		elseif TRP3_UF_DB.Setting.FullNameTarget == false and TRP3_UF_DB.Setting.UseTRPName == true then
			local firstName = AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName()
			if firstName == nil then
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(UnitName("target"))
			else
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(firstName)
			end
		else
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(UnitName("target"))
		end
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
	end
end

function trpTarget.UpdateInfo()
	TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(1, 0.896, 0, 1)

	if UnitIsPlayer("target") then
		TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(0, 0, 1, 1)

		if TRP3_UF_DB.Target.colorTextClass == true then
			local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("target")).r, C_ClassColor.GetClassColor(UnitClassBase("target")).g, C_ClassColor.GetClassColor(UnitClassBase("target")).b
			classR, classG, classB = classR or 1, classG or 1, classB or 1

			if TRP3_UF_DB.Setting.FullNameTarget == true and TRP3_UF_DB.Setting.UseTRPName == true then
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(TRP3_API.r.name("target"))
			elseif TRP3_UF_DB.Setting.FullNameTarget == false and TRP3_UF_DB.Setting.UseTRPName == true then
				local firstName = AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName()
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(firstName or UnitName("target"))
			else
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(UnitName("target"))
			end
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(classR, classG, classB)
		end

		local textColorQ = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
		if textColorQ then
			local rgb = textColorQ:GetRGBTable()
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(rgb.r, rgb.g, rgb.b)
		end

		if TRP3_UF_DB.Target.colorTextCustom == true then
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		end

		if TRP3_UF_DB.Target.colorBackClass == true then
			local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("target")).r, C_ClassColor.GetClassColor(UnitClassBase("target")).g, C_ClassColor.GetClassColor(UnitClassBase("target")).b
			classR, classG, classB = classR or 0, classG or 0, classB or 0
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(classR, classG, classB, 1)
		end
		if TRP3_UF_DB.Target.colorBackCustom == true then
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
		end
		if TRP3_UF_DB.Target.colorBackClass == false and TRP3_UF_DB.Target.colorBackCustom == false then
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(0, 0, 1, 1)
		end
	end

	if UnitIsPlayer("target") == false and TRP3_UF_DB.Setting.NPCs == true then
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
		TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
	end
end

function trpTarget.nameChecker()
	trpTarget.UpdateInfo()
	trpPlayer.UpdateInfo()

	if UnitIsPlayer("target") and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		trpTarget.SetColor()

		local player = AddOn_TotalRP3.Player.CreateFromUnit("target")
		local icon = player:GetCustomIcon() or "inv_inscription_scroll"

		if trpTarget.button and trpTarget.button.tex then
			trpTarget.button.tex:SetTexture("Interface/icons/" .. icon)
			trpTarget.button.tex:SetTexCoord(0, 1, 0, 1)
			if not trpTarget.button.tex.TrpMask then
				trpTarget.button.tex.TrpMask = trpTarget.button:CreateMaskTexture()
				trpTarget.button.tex.TrpMask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
				trpTarget.button.tex.TrpMask:SetAllPoints(trpTarget.button.tex)
				trpTarget.button.tex:AddMaskTexture(trpTarget.button.tex.TrpMask)
			end
		end

		if TRP3_UF_DB.Target.relativePoint == "CENTER" then
			if trpTarget.button then
				trpTarget.button:Hide()
			end
			if trpTarget.portraitClick then
				trpTarget.portraitClick:Show()
			end
			TargetFrame.TargetFrameContainer.Portrait:SetTexture("Interface/icons/" .. icon)
			TargetFrame.TargetFrameContainer.Portrait:SetTexCoord(0, 1, 0, 1)
		else
			if not InCombatLockdown() then
				if trpTarget.button then
					trpTarget.button:Show()
				end
			end
			if trpTarget.portraitClick then
				trpTarget.portraitClick:Hide()
			end
			SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
		end

		if trpPlayer.SetAsPortrait then
			trpPlayer.SetAsPortrait()
		end
	else
		if trpTarget.button then
			trpTarget.button:Hide()
		end
		if trpTarget.portraitClick then
			trpTarget.portraitClick:Hide()
		end
		SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
	end
end