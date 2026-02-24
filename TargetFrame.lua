local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;
local TargetName = TargetFrame.TargetFrameContent.TargetFrameContentMain.Name;
local ReputationColor = TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor;

local targetStatus = CreateFrame("Frame", nil, TargetFrame)
targetStatus:SetSize(22, 22)
targetStatus:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, "TOP", 0, -15)
targetStatus:SetFrameStrata("MEDIUM")
targetStatus.Tex = targetStatus:CreateTexture(nil, "OVERLAY", nil, 7)
targetStatus.Tex:SetAllPoints()
targetStatus:Hide()
trpTarget.status = targetStatus

function trpTarget.UpdateStatusIcon()
	TRP3_UnitFrames.UpdateStatusIcon("target", trpTarget.status, TRP3_UF_DB and TRP3_UF_DB.Target.showStatus);
end

function trpTarget.SetColor()
	if TRP3_UF_DB.Target.colorBackCustom then
		ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
	end
	if TRP3_UF_DB.Target.colorTextCustom and TargetName  then
		if TRP3_UF_DB.Setting.FullNameTarget and TRP3_UF_DB.Setting.UseTRPName then
			TargetName:SetText(TRP3_API.r.name("target"))
		elseif not TRP3_UF_DB.Setting.FullNameTarget and TRP3_UF_DB.Setting.UseTRPName then
			local firstName = AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName()
			if firstName then
				TargetName:SetText(firstName)
			else
				TargetName:SetText(UnitName("target"))
			end
		else
			TargetName:SetText(UnitName("target"))
		end
		TargetName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
	end
end

function trpTarget.UpdateInfo()
	if TargetName then
		TargetName:SetTextColor(1, 0.896, 0, 1)
		if TRP3_UF_DB.Target.nameWidth then
			TargetName:SetWidth(TRP3_UF_DB.Target.nameWidth)
		end

		if UnitIsPlayer("target") then
			ReputationColor:SetVertexColor(0, 0, 1, 1)

			if TRP3_UF_DB.Target.colorTextClass then
				local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("target")).r, C_ClassColor.GetClassColor(UnitClassBase("target")).g, C_ClassColor.GetClassColor(UnitClassBase("target")).b
				classR, classG, classB = classR or 1, classG or 1, classB or 1

				if TRP3_UF_DB.Setting.FullNameTarget and TRP3_UF_DB.Setting.UseTRPName then
					TargetName:SetText(TRP3_API.r.name("target"))
				elseif not TRP3_UF_DB.Setting.FullNameTarget and TRP3_UF_DB.Setting.UseTRPName then
					local firstName = AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName()
					TargetName:SetText(firstName or UnitName("target"))
				else
					TargetName:SetText(UnitName("target"))
				end
				TargetName:SetTextColor(classR, classG, classB)
			end

			local textColorQ = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
			if textColorQ then
				local rgb = textColorQ:GetRGBTable()
				TargetName:SetTextColor(rgb.r, rgb.g, rgb.b)
			end

			if TRP3_UF_DB.Target.colorTextCustom then
				TargetName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText))
			end

			if TRP3_UF_DB.Target.colorBackClass then
				local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("target")).r, C_ClassColor.GetClassColor(UnitClassBase("target")).g, C_ClassColor.GetClassColor(UnitClassBase("target")).b
				classR, classG, classB = classR or 0, classG or 0, classB or 0
				ReputationColor:SetVertexColor(classR, classG, classB, 1)
			end
			if TRP3_UF_DB.Target.colorBackCustom then
				ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack))
			end
			if not TRP3_UF_DB.Target.colorBackClass and not TRP3_UF_DB.Target.colorBackCustom then
				ReputationColor:SetVertexColor(0, 0, 1, 1)
			end
		end

		if not UnitIsPlayer("target") and TRP3_UF_DB.Setting.NPCs then
			TargetName:SetTextColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorText));
			ReputationColor:SetVertexColor(ColorMixin.GetRGBA(TRP3_UF_DB.Target.colorBack));
		end

		local frameTex = TargetFrame.TargetFrameContainer.FrameTexture
		if frameTex then
			if TRP3_UF_DB.Target.frameTextureEnabled then
				frameTex:SetDesaturated(true);
				local r, g, b, a = 1, 1, 1, 1;
				if TRP3_UF_DB.Target.frameTextureClass and UnitIsPlayer("target") then
					local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("target")).r, C_ClassColor.GetClassColor(UnitClassBase("target")).g, C_ClassColor.GetClassColor(UnitClassBase("target")).b;
					r, g, b = (classR or 1), (classG or 1), (classB or 1);
					a = 1;
				end
				if TRP3_UF_DB.Target.frameTextureTRP and UnitIsPlayer("target") then
					local customColor = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
					if customColor then
						r, g, b = customColor:GetRGB();
						a = 1;
					end
				end
				if TRP3_UF_DB.Target.frameTextureCustom then
					r = TRP3_UF_DB.Target.frameTextureColor.r;
					g = TRP3_UF_DB.Target.frameTextureColor.g;
					b = TRP3_UF_DB.Target.frameTextureColor.b;
					a = TRP3_UF_DB.Target.frameTextureColor.a or 1;
				end
				frameTex:SetVertexColor(r, g, b, a);
			else
				frameTex:SetDesaturated(false);
				frameTex:SetVertexColor(1, 1, 1, 1);
			end
		end
	end

	trpTarget.UpdateStatusIcon()
end

function trpTarget.nameChecker()
	trpTarget.UpdateInfo()
	trpPlayer.UpdateInfo()

	if UnitIsPlayer("target") and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() then
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
			if not InCombatLockdown() and TRP3_UF_DB.Target.show then
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