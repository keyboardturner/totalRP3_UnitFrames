local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;

local allSettingsData = {};
local allFilterFuncs  = {};

local function BuildDummyFrames(panel, playerOffX, playerOffY, targetOffX, targetOffY, playerRepName, playerRepTextName, targetRepName, targetRepTextName)

	panel.dummyFramePlayer = CreateFrame("Frame", nil, panel)
	panel.dummyFramePlayer:SetPoint("TOPLEFT", panel, "TOPLEFT", playerOffX, playerOffY)
	panel.dummyFramePlayer:SetSize(198, 71)
	panel.dummyFramePlayer.tex = panel.dummyFramePlayer:CreateTexture(nil, "ARTWORK", nil, 1)
	panel.dummyFramePlayer.tex:SetAllPoints(panel.dummyFramePlayer)
	panel.dummyFramePlayer.tex:SetAtlas("UI-HUD-UnitFrame-Player-PortraitOn")
	panel.dummyFramePlayer.tex:SetTexCoord(0, 1, 0, 1)

	panel.dummyFrameTarget = CreateFrame("Frame", nil, panel)
	panel.dummyFrameTarget:SetPoint("TOPLEFT", panel, "TOPLEFT", targetOffX, targetOffY)
	panel.dummyFrameTarget:SetSize(198, 71)
	panel.dummyFrameTarget.tex = panel.dummyFrameTarget:CreateTexture(nil, "ARTWORK", nil, 1)
	panel.dummyFrameTarget.tex:SetAllPoints(panel.dummyFrameTarget)
	panel.dummyFrameTarget.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn")
	panel.dummyFrameTarget.tex:SetTexCoord(0, 1, 0, 1)

	panel.Pf = CreateFrame("Frame", nil, panel)
	panel.Pf:ClearAllPoints()
	panel.Pf:SetPoint("TOPLEFT", panel.dummyFramePlayer, "TOPLEFT", 5, -3)
	panel.Pf:SetSize(64, 64)

	panel.Pf.tex = panel.Pf:CreateTexture()
	panel.Pf.tex:SetAllPoints(panel.Pf)
	panel.Pf.mask = panel.Pf:CreateMaskTexture()
	panel.Pf.mask:SetAllPoints(panel.Pf.tex)
	panel.Pf.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	panel.Pf.tex:AddMaskTexture(panel.Pf.mask)
	SetPortraitTexture(panel.Pf.tex, "player")

	panel.Tf = CreateFrame("Frame", nil, panel)
	panel.Tf:ClearAllPoints()
	panel.Tf:SetPoint("TOPLEFT", panel.dummyFrameTarget, "TOPLEFT", 128, -2)
	panel.Tf:SetSize(64, 64)

	panel.Tf.tex = panel.Tf:CreateTexture()
	panel.Tf.tex:SetAllPoints(panel.Tf)
	panel.Tf.mask = panel.Tf:CreateMaskTexture()
	panel.Tf.mask:SetAllPoints(panel.Tf.tex)
	panel.Tf.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	panel.Tf.tex:AddMaskTexture(panel.Tf.mask)
	SetPortraitTexture(panel.Tf.tex, "player")

	function panel.OnShow()
		SetPortraitTexture(panel.Pf.tex, "player");
		SetPortraitTexture(panel.Tf.tex, "player");
	end
	panel.Tf:SetScript("OnShow", panel.OnShow)

	panel.Pf.TitleText = panel.Pf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	panel.Pf.TitleText:SetFont(panel.Pf.TitleText:GetFont(), 12)
	panel.Pf.TitleText:SetTextColor(1, 1, 1, 1)
	panel.Pf.TitleText:SetPoint("BOTTOM", panel.Pf, "BOTTOM", 0, -25)
	panel.Pf.TitleText:SetText(PLAYER)

	panel.Tf.TitleText = panel.Tf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	panel.Tf.TitleText:SetFont(panel.Tf.TitleText:GetFont(), 12)
	panel.Tf.TitleText:SetTextColor(1, 1, 1, 1)
	panel.Tf.TitleText:SetPoint("BOTTOM", panel.Tf, "BOTTOM", 0, -25)
	panel.Tf.TitleText:SetText(TARGET)

	panel.Pf.radioTopLeft = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioTop = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioTopRight = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioLeft = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioCenter = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioRight = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioBottomLeft = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioBottom = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioBottomRight = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")

	panel.Pf.radioTopLeft:SetChecked(false)
	panel.Pf.radioTop:SetChecked(false)
	panel.Pf.radioTopRight:SetChecked(false)
	panel.Pf.radioLeft:SetChecked(false)
	panel.Pf.radioCenter:SetChecked(false)
	panel.Pf.radioRight:SetChecked(false)
	panel.Pf.radioBottomLeft:SetChecked(false)
	panel.Pf.radioBottom:SetChecked(false)
	panel.Pf.radioBottomRight:SetChecked(true)

	panel.Pf.radioTopLeft:SetPoint("CENTER", panel.Pf, "TOPLEFT", 0, 0)
	panel.Pf.radioTop:SetPoint("CENTER", panel.Pf, "TOP", 0, 0)
	panel.Pf.radioTopRight:SetPoint("CENTER", panel.Pf, "TOPRIGHT", 0, 0)
	panel.Pf.radioLeft:SetPoint("CENTER", panel.Pf, "LEFT", 0, 0)
	panel.Pf.radioCenter:SetPoint("CENTER", panel.Pf, "CENTER", 0, 0)
	panel.Pf.radioRight:SetPoint("CENTER", panel.Pf, "RIGHT", 0, 0)
	panel.Pf.radioBottomLeft:SetPoint("CENTER", panel.Pf, "BOTTOMLEFT", 0, 0)
	panel.Pf.radioBottom:SetPoint("CENTER", panel.Pf, "BOTTOM", 0, 0)
	panel.Pf.radioBottomRight:SetPoint("CENTER", panel.Pf, "BOTTOMRIGHT", 0, 0)

	panel.Pf.allRadios = {
		panel.Pf.radioTopLeft,		panel.Pf.radioTop,		panel.Pf.radioTopRight,
		panel.Pf.radioLeft,			panel.Pf.radioCenter,	panel.Pf.radioRight,
		panel.Pf.radioBottomLeft,	panel.Pf.radioBottom,	panel.Pf.radioBottomRight,
	};

	function panel.Pf.createOnRadioClicked(location)
		return function(self)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
			TRP3_UF_DB.Player.relativePoint = location;
			for _, radio in ipairs(panel.Pf.allRadios) do
				radio:SetChecked(radio == self);
			end
			if trpPlayer.SetPos then
				trpPlayer.SetPos();
			end
		end
	end

	panel.Pf.radioTopLeft:SetScript("OnClick", panel.Pf.createOnRadioClicked("TOPLEFT"))
	panel.Pf.radioTop:SetScript("OnClick", panel.Pf.createOnRadioClicked("TOP"))
	panel.Pf.radioTopRight:SetScript("OnClick", panel.Pf.createOnRadioClicked("TOPRIGHT"))
	panel.Pf.radioLeft:SetScript("OnClick", panel.Pf.createOnRadioClicked("LEFT"))
	panel.Pf.radioCenter:SetScript("OnClick", panel.Pf.createOnRadioClicked("CENTER"))
	panel.Pf.radioRight:SetScript("OnClick", panel.Pf.createOnRadioClicked("RIGHT"))
	panel.Pf.radioBottomLeft:SetScript("OnClick", panel.Pf.createOnRadioClicked("BOTTOMLEFT"))
	panel.Pf.radioBottom:SetScript("OnClick", panel.Pf.createOnRadioClicked("BOTTOM"))
	panel.Pf.radioBottomRight:SetScript("OnClick", panel.Pf.createOnRadioClicked("BOTTOMRIGHT"))

	panel.Tf.radioTopLeft = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioTop = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioTopRight = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioLeft = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioCenter = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioRight = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioBottomLeft = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioBottom = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioBottomRight = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")

	panel.Tf.radioTopLeft:SetChecked(false)
	panel.Tf.radioTop:SetChecked(false)
	panel.Tf.radioTopRight:SetChecked(false)
	panel.Tf.radioLeft:SetChecked(false)
	panel.Tf.radioCenter:SetChecked(false)
	panel.Tf.radioRight:SetChecked(false)
	panel.Tf.radioBottomLeft:SetChecked(true)
	panel.Tf.radioBottom:SetChecked(false)
	panel.Tf.radioBottomRight:SetChecked(false)

	panel.Tf.radioTopLeft:SetPoint("CENTER", panel.Tf, "TOPLEFT", 0, 0)
	panel.Tf.radioTop:SetPoint("CENTER", panel.Tf, "TOP", 0, 0)
	panel.Tf.radioTopRight:SetPoint("CENTER", panel.Tf, "TOPRIGHT", 0, 0)
	panel.Tf.radioLeft:SetPoint("CENTER", panel.Tf, "LEFT", 0, 0)
	panel.Tf.radioCenter:SetPoint("CENTER", panel.Tf, "CENTER", 0, 0)
	panel.Tf.radioRight:SetPoint("CENTER", panel.Tf, "RIGHT", 0, 0)
	panel.Tf.radioBottomLeft:SetPoint("CENTER", panel.Tf, "BOTTOMLEFT", 0, 0)
	panel.Tf.radioBottom:SetPoint("CENTER", panel.Tf, "BOTTOM", 0, 0)
	panel.Tf.radioBottomRight:SetPoint("CENTER", panel.Tf, "BOTTOMRIGHT", 0, 0)

	panel.Tf.allRadios = {
		panel.Tf.radioTopLeft,		panel.Tf.radioTop,		panel.Tf.radioTopRight,
		panel.Tf.radioLeft,			panel.Tf.radioCenter,	panel.Tf.radioRight,
		panel.Tf.radioBottomLeft,	panel.Tf.radioBottom,	panel.Tf.radioBottomRight,
	};

	function panel.Tf.createOnRadioClicked(location)
		return function(self)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
			TRP3_UF_DB.Target.relativePoint = location;
			for _, radio in ipairs(panel.Tf.allRadios) do
				radio:SetChecked(radio == self);
			end
			if trpTarget.SetPos then
				trpTarget.SetPos();
			end
		end
	end

	panel.Tf.radioTopLeft:SetScript("OnClick", panel.Tf.createOnRadioClicked("TOPLEFT"))
	panel.Tf.radioTop:SetScript("OnClick", panel.Tf.createOnRadioClicked("TOP"))
	panel.Tf.radioTopRight:SetScript("OnClick", panel.Tf.createOnRadioClicked("TOPRIGHT"))
	panel.Tf.radioLeft:SetScript("OnClick", panel.Tf.createOnRadioClicked("LEFT"))
	panel.Tf.radioCenter:SetScript("OnClick", panel.Tf.createOnRadioClicked("CENTER"))
	panel.Tf.radioRight:SetScript("OnClick", panel.Tf.createOnRadioClicked("RIGHT"))
	panel.Tf.radioBottomLeft:SetScript("OnClick", panel.Tf.createOnRadioClicked("BOTTOMLEFT"))
	panel.Tf.radioBottom:SetScript("OnClick", panel.Tf.createOnRadioClicked("BOTTOM"))
	panel.Tf.radioBottomRight:SetScript("OnClick", panel.Tf.createOnRadioClicked("BOTTOMRIGHT"))

	panel.PColor = CreateFrame("Frame", nil, panel.dummyFramePlayer)
	panel.PColor:SetPoint("TOPLEFT", panel.dummyFramePlayer, "TOPLEFT", 58, -11)
	panel.PColor:SetSize(135, 18)
	panel.PColor.tex = panel.PColor:CreateTexture(playerRepName, "ARTWORK", nil, 1)
	panel.PColor.tex:SetAllPoints(panel.PColor)
	panel.PColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
	panel.PColor.tex:SetTexCoord(1, 0, 0, 1)
	panel.PColor.Name = panel.PColor:CreateFontString(playerRepTextName, "OVERLAY", "GameFontNormal")
	panel.PColor.Name:SetFont(panel.PColor.Name:GetFont(), 12)
	panel.PColor.Name:SetTextColor(1, 1, 1, 1)
	panel.PColor.Name:SetPoint("TOP", panel.PColor, "TOP", 0, 0)
	panel.PColor.Name:SetText(PLAYER)

	panel.TColor = CreateFrame("Frame", nil, panel.dummyFrameTarget)
	panel.TColor:SetPoint("TOPRIGHT", panel.dummyFrameTarget, "TOPRIGHT", -60, -10)
	panel.TColor:SetSize(135, 18)
	panel.TColor.tex = panel.TColor:CreateTexture(targetRepName, "ARTWORK", nil, 1)
	panel.TColor.tex:SetAllPoints(panel.TColor)
	panel.TColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
	panel.TColor.Name = panel.TColor:CreateFontString(targetRepTextName, "OVERLAY", "GameFontNormal")
	panel.TColor.Name:SetFont(panel.TColor.Name:GetFont(), 12)
	panel.TColor.Name:SetTextColor(1, 1, 1, 1)
	panel.TColor.Name:SetPoint("TOP", panel.TColor, "TOP", 0, 0)
	panel.TColor.Name:SetText(TARGET)
end

local function InitializeCheckbox(button, data)
	button:SetHeight(30)
	if not button.checkbox then
		button.checkbox = CreateFrame("CheckButton", nil, button, "ChatConfigCheckButtonTemplate");
		button.checkbox:SetPoint("LEFT", button, "LEFT", 10, 0);
		button.checkbox:SetSize(24, 24);
		button.cbLabel = button.checkbox.Text;
		button.cbLabel:ClearAllPoints();
		button.cbLabel:SetPoint("LEFT", button.checkbox, "RIGHT", 5, 0);
		button.cbLabel:SetPoint("RIGHT", button, "RIGHT", -5, 0);
		button.cbLabel:SetJustifyH("LEFT");
	end
	button.checkbox:Show()
	button.cbLabel:Show()
	button.cbLabel:SetText(data.label)

	local enabled = (data.isEnabled == nil) or data.isEnabled()
	button.checkbox:SetEnabled(enabled)
	button.checkbox:SetChecked(data.get())

	button.checkbox:SetScript("OnClick", function(self)
		local val = self:GetChecked();
		data.set(val);
		if data.callback then
			data.callback(val);
		end
	end)

	if data.tooltip then
		button.checkbox:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end)
		button.checkbox:SetScript("OnLeave", GameTooltip_Hide);
	else
		button.checkbox:SetScript("OnEnter", nil);
		button.checkbox:SetScript("OnLeave", nil);
	end
end

local function InitializeColorPicker(button, data)
	button:SetHeight(30)
	if not button.cpCheckbox then
		button.cpCheckbox = CreateFrame("CheckButton", nil, button, "ChatConfigCheckButtonTemplate");
		button.cpCheckbox:SetPoint("LEFT", button, "LEFT", 10, 0);
		button.cpCheckbox:SetSize(24, 24);
		button.cpLabel = button.cpCheckbox.Text;
		button.cpLabel:ClearAllPoints();
		button.cpLabel:SetPoint("LEFT", button.cpCheckbox, "RIGHT", 5, 0);
		button.cpLabel:SetPoint("RIGHT", button, "CENTER", -5, 0);
		button.cpLabel:SetJustifyH("LEFT");

		button.cpBtn = CreateFrame("Button", nil, button, "SharedGoldRedButtonSmallTemplate");
		button.cpBtn:SetPoint("RIGHT", button, "RIGHT", -10, 0);
		button.cpBtn:SetSize(120, 22);
		button.cpBtn:SetText(COLOR_PICKER);
	end
	button.cpCheckbox:Show()
	button.cpLabel:Show()
	button.cpBtn:Show()

	button.cpLabel:SetText(data.label)
	local checked = data.get()
	button.cpCheckbox:SetChecked(checked)
	button.cpBtn:SetEnabled(checked)

	button.cpCheckbox:SetScript("OnClick", function(self)
		local val = self:GetChecked();
		data.set(val);
		button.cpBtn:SetEnabled(val);
		if data.callback then
			data.callback(val);
		end
	end)
	button.cpBtn:SetScript("OnClick", function()
		TRP3_UnitFrames.ShowColorPicker(data.colorGetter());
	end)
end

local function InitializeSlider(button, data)
	button:SetHeight(30)
	
	local options = Settings.CreateSliderOptions(data.min, data.max, data.step)
	options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, data.formatter)

	if not button.minSlider then
		button.minSlider = CreateFrame("Frame", nil, button, "MinimalSliderWithSteppersTemplate");
		button.minSlider:SetPoint("RIGHT", button, "RIGHT", -10, 0);
		button.minSlider:SetWidth(150);

		-- haha lol i made the right text be left text and there's nothing you can do about it
		button.minSlider.RightText:ClearAllPoints();
		button.minSlider.RightText:SetPoint("RIGHT", button.minSlider, "LEFT", -5, 0);

		button.minSliderLabel = button:CreateFontString(nil, "OVERLAY", "GameTooltipText");
		button.minSliderLabel:SetPoint("LEFT", button, "LEFT", 10, 0);
		button.minSliderLabel:SetPoint("RIGHT", button.minSlider, "LEFT", -10, 0);
		button.minSliderLabel:SetJustifyH("LEFT");
		button.minSliderLabel:SetTextColor(1, 1, 1);
	end

	button.minSlider:Show()
	button.minSliderLabel:Show()
	button.minSliderLabel:SetText(data.label)

	if button.minSliderCallback then
		button.minSlider:UnregisterCallback("OnValueChanged", button.minSliderCallback);
		button.minSliderCallback = nil;
	end

	button.minSlider.isInitializing = true

	button.minSlider:Init(data.get(), options.minValue, options.maxValue, options.steps, options.formatters)

	local function OnValueChanged(_, value)
		if button.minSlider.isInitializing then return; end
		data.set(value);
		if data.callback then
			data.callback(value);
		end
	end
	
	button.minSliderCallback = OnValueChanged
	button.minSlider:RegisterCallback("OnValueChanged", OnValueChanged, button.minSlider)

	button.minSlider:SetValue(data.get())

	button.minSlider.isInitializing = false

	if data.tooltip then
		button.minSlider.Slider:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(button.minSliderLabel, "ANCHOR_TOPLEFT", -5, 5);
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end)
		button.minSlider.Slider:SetScript("OnLeave", GameTooltip_Hide);
	else
		button.minSlider.Slider:SetScript("OnEnter", nil);
		button.minSlider.Slider:SetScript("OnLeave", nil);
	end
end

local function InitializeDropdown(button, data)
	button:SetHeight(30)
	if not button.dd then
		button.dd = CreateFrame("DropdownButton", nil, button, "WowStyle1DropdownTemplate");
		button.dd:SetPoint("RIGHT", button, "RIGHT", -10, 0);
		button.dd:SetWidth(200);

		button.ddLabel = button:CreateFontString(nil, "OVERLAY", "GameTooltipText");
		button.ddLabel:SetPoint("LEFT", button, "LEFT", 10, 0);
		button.ddLabel:SetPoint("RIGHT", button.dd, "LEFT", -10, 0);
		button.ddLabel:SetJustifyH("LEFT");
	end
	button.dd:Show()
	button.ddLabel:Show()
	button.ddLabel:SetText(data.label)

	local enabled = (data.isEnabled == nil) or data.isEnabled()
	button.dd:SetEnabled(enabled)
	button.dd:SetDefaultText(data.defaultText or "")
	button.dd:SetupMenu(data.menuBuilder)

	if data.tooltip then
		button.dd:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(button.ddLabel, "ANCHOR_TOPLEFT", -5, 5);
			GameTooltip:SetText(data.label, 1, 1, 1);
			GameTooltip:AddLine(data.tooltip, nil, nil, nil, true);
			GameTooltip:Show();
		end)
		button.dd:SetScript("OnLeave", GameTooltip_Hide);
	end
end

local function InitializeHeader(button, data)
	button:SetHeight(30)
	if not button.hdrLabel then
		button.hdrLabel = button:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
		button.hdrLabel:SetPoint("LEFT", button, "LEFT", 10, -5);
		button.hdrLabel:SetPoint("RIGHT", button, "RIGHT", -10, -5);
		button.hdrLabel:SetJustifyH("LEFT");
		button.hdrLabel:SetTextColor(1, 0.82, 0);
	end
	button.hdrLabel:Show();
	button.hdrLabel:SetText(data.label);
end


local function SettingsRowInitializer(button, data)
	if button.checkbox then
		button.checkbox:Hide();
	end
	if button.cbLabel then
		button.cbLabel:Hide();
	end
	if button.cpCheckbox then
		button.cpCheckbox:Hide();
	end
	if button.cpLabel then
		button.cpLabel:Hide();
	end
	if button.cpBtn then
		button.cpBtn:Hide();
	end
	if button.minSlider then
		button.minSlider:Hide();
	end
	if button.minSliderLabel then
		button.minSliderLabel:Hide();
	end
	if button.dd then
		button.dd:Hide();
	end
	if button.ddLabel then
		button.ddLabel:Hide();
	end
	if button.hdrLabel then
		button.hdrLabel:Hide();
	end

	if data.type == "checkbox" then
		InitializeCheckbox(button, data);
	elseif data.type == "colorpicker" then
		InitializeColorPicker(button, data);
	elseif data.type == "slider" then
		InitializeSlider(button, data);
	elseif data.type == "dropdown" then
		InitializeDropdown(button, data);
	elseif data.type == "header" then
		InitializeHeader(button, data);
	end
end


local function BuildSettingsData(menuNew)
	allSettingsData = {};

	local function gs(lbl, tt)
		return (lbl .. " " .. (tt or "")):lower();
	end

	local function refreshFrames()
		if trpPlayer.UpdateInfo then
			trpPlayer.UpdateInfo();
		end
		if trpTarget.UpdateInfo then
			trpTarget.UpdateInfo();
		end
	end

	table.insert(allSettingsData, {
		type = "header",
		label = L["Visibility"]
	})

	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["ShowButtonPlayer"],
		searchText = gs(L["ShowButtonPlayer"]),
		get = function() return TRP3_UF_DB.Player.show end,
		set = function(v) TRP3_UF_DB.Player.show = v end,
		callback = function()
			if trpPlayer.SetVisible then
				trpPlayer.SetVisible();
			end
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["ShowButtonTarget"],
		searchText = gs(L["ShowButtonTarget"]),
		get = function() return TRP3_UF_DB.Target.show end,
		set = function(v) TRP3_UF_DB.Target.show = v end,
		callback = function()
			if trpTarget.SetVisible then
				trpTarget.SetVisible();
			end
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["ShowBorderFrame"],
		searchText = gs(L["ShowBorderFrame"]),
		get = function() return TRP3_UF_DB.Border.show end,
		set = function(v) TRP3_UF_DB.Border.show = v end,
		callback = function(v)
			local pdf = TRP3_UnitFrames.PlayerDragonFrame;
			if pdf then
				if v then
					pdf:Show();
				else
					pdf:Hide();
				end
			end
			if trpPlayer.SetAsPortrait then
				trpPlayer.SetAsPortrait();
			end
			TRP3_UnitFrames.CheckSettings();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["HideRestedGlow"],
		searchText = gs(L["HideRestedGlow"]),
		get = function() return TRP3_UF_DB.Border.status end,
		set = function(v) TRP3_UF_DB.Border.status = v end,
		callback = function(v)
			if v then
				PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide();
			else
				PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show();
			end
		end,
	})

	table.insert(allSettingsData, {
		type = "header",
		label = HUD_EDIT_MODE_TARGET_FRAME_LABEL
	})

	table.insert(allSettingsData, {
		type = "slider",
		label = L["ButtonSizeTarget"],
		searchText = gs(L["ButtonSizeTarget"]),
		min = 0.5, max = 15, step = 0.5,
		formatter = function(v) return string.format("%.1f", v) end,
		get = function() return TRP3_UF_DB.Target.scale end,
		set = function(v) TRP3_UF_DB.Target.scale = v end,
		callback = function(v)
			if trpTarget.button then
				trpTarget.button:SetScale(v);
			end
		end,
	})
	table.insert(allSettingsData, {
		type = "slider",
		label = L["ButtonPosTarget"],
		searchText = gs(L["ButtonPosTarget"]),
		min = -15, max = 15, step = 0.5,
		formatter = function(v) return string.format("%.1f", v) end,
		get = function() return TRP3_UF_DB.Target.position end,
		set = function(v) TRP3_UF_DB.Target.position = v end,
		callback = function()
			if trpTarget.SetPos then
				trpTarget.SetPos();
			end
		end,
	})

	table.insert(allSettingsData, {
		type = "header",
		label = HUD_EDIT_MODE_TARGET_FRAME_LABEL .. ": " .. COLORS,
	})

	table.insert(allSettingsData, {
		type = "colorpicker",
		label = L["OverwriteTextCol"],
		searchText = gs(L["OverwriteTextCol"]),
		get = function() return TRP3_UF_DB.Target.colorTextCustom end,
		set = function(v) TRP3_UF_DB.Target.colorTextCustom = v end,
		colorGetter = function() return TRP3_UF_DB.Target.colorText end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["BlizzTextCol"],
		searchText = gs(L["BlizzTextCol"]),
		get = function() return TRP3_UF_DB.Target.colorTextClass end,
		set = function(v) TRP3_UF_DB.Target.colorTextClass = v end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "colorpicker",
		label = L["OverwriteBackCol"],
		searchText = gs(L["OverwriteBackCol"]),
		get = function() return TRP3_UF_DB.Target.colorBackCustom end,
		set = function(v) TRP3_UF_DB.Target.colorBackCustom = v end,
		colorGetter = function() return TRP3_UF_DB.Target.colorBack end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["BlizzBackCol"],
		searchText = gs(L["BlizzBackCol"]),
		get = function() return TRP3_UF_DB.Target.colorBackClass end,
		set = function(v) TRP3_UF_DB.Target.colorBackClass = v end,
		callback = function()
			refreshFrames();
		end,
	})

	table.insert(allSettingsData, {
		type = "header",
		label = HUD_EDIT_MODE_PLAYER_FRAME_LABEL
	})

	table.insert(allSettingsData, {
		type = "slider",
		label = L["ButtonSizePlayer"],
		searchText = gs(L["ButtonSizePlayer"]),
		min = 0.5, max = 15, step = 0.5,
		formatter = function(v) return string.format("%.1f", v) end,
		get = function() return TRP3_UF_DB.Player.scale end,
		set = function(v) TRP3_UF_DB.Player.scale = v end,
		callback = function(v)
			if trpPlayer.button then
				trpPlayer.button:SetScale(v);
			end
		end,
	})
	table.insert(allSettingsData, {
		type = "slider",
		label = L["ButtonPosPlayer"],
		searchText = gs(L["ButtonPosPlayer"]),
		min = -15, max = 15, step = 0.5,
		formatter = function(v) return string.format("%.1f", v) end,
		get = function() return TRP3_UF_DB.Player.position end,
		set = function(v) TRP3_UF_DB.Player.position = v end,
		callback = function()
			if trpPlayer.SetPos then
				trpPlayer.SetPos();
			end
		end,
	})

	table.insert(allSettingsData, {
		type = "header",
		label = HUD_EDIT_MODE_PLAYER_FRAME_LABEL .. ": " .. COLORS,
	})

	table.insert(allSettingsData, {
		type = "colorpicker",
		label = L["OverwriteTextCol"],
		searchText = gs(L["OverwriteTextCol"]),
		get = function() return TRP3_UF_DB.Player.colorTextCustom end,
		set = function(v) TRP3_UF_DB.Player.colorTextCustom = v end,
		colorGetter = function() return TRP3_UF_DB.Player.colorText end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["BlizzTextCol"],
		searchText = gs(L["BlizzTextCol"]),
		get = function() return TRP3_UF_DB.Player.colorTextClass end,
		set = function(v) TRP3_UF_DB.Player.colorTextClass = v end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "colorpicker",
		label = L["OverwriteBackCol"],
		searchText = gs(L["OverwriteBackCol"]),
		get = function() return TRP3_UF_DB.Player.colorBackCustom end,
		set = function(v) TRP3_UF_DB.Player.colorBackCustom = v end,
		colorGetter = function() return TRP3_UF_DB.Player.colorBack end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["BlizzBackCol"],
		searchText = gs(L["BlizzBackCol"]),
		get = function() return TRP3_UF_DB.Player.colorBackClass end,
		set = function(v) TRP3_UF_DB.Player.colorBackClass = v end,
		callback = function()
			refreshFrames();
		end,
	})

	table.insert(allSettingsData, {
		type = "header",
		label = NAMES_LABEL
	})

	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["TRP3CustomName"],
		searchText = gs(L["TRP3CustomName"]),
		get = function() return TRP3_UF_DB.Setting.UseTRPName end,
		set = function(v) TRP3_UF_DB.Setting.UseTRPName = v end,
		callback = function()
			refreshFrames();
			TRP3_UnitFrames.CheckSettings();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["FullNamePlayer"],
		searchText = gs(L["FullNamePlayer"]),
		get = function() return TRP3_UF_DB.Setting.FullNamePlayer end,
		set = function(v) TRP3_UF_DB.Setting.FullNamePlayer = v end,
		isEnabled = function() return TRP3_UF_DB.Setting.UseTRPName end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["FullNameTarget"],
		searchText = gs(L["FullNameTarget"]),
		get = function() return TRP3_UF_DB.Setting.FullNameTarget end,
		set = function(v) TRP3_UF_DB.Setting.FullNameTarget = v end,
		isEnabled = function() return TRP3_UF_DB.Setting.UseTRPName end,
		callback = function()
			refreshFrames();
		end,
	})
	table.insert(allSettingsData, {
		type = "checkbox",
		label = L["ApplyToNPCs"],
		searchText = gs(L["ApplyToNPCs"]),
		get = function() return TRP3_UF_DB.Setting.NPCs end,
		set = function(v) TRP3_UF_DB.Setting.NPCs = v end,
		callback = function()
			if trpTarget.UpdateInfo then
				trpTarget.UpdateInfo();
			end
		end,
	})

	table.insert(allSettingsData, {
		type = "header",
		label = L["PlayerPortrait"]
	})

	table.insert(allSettingsData, {
		type = "dropdown",
		label = L["PlayerPortrait"],
		defaultText = L["PlayerPortrait"],
		searchText = gs(L["PlayerPortrait"]),
		isEnabled = function() return TRP3_UF_DB.Border.show end,
		menuBuilder = function(_, rootDescription)
			for _, menu in ipairs(menuNew) do
				local elementDescription = rootDescription:CreateButton(menu.ThemeName)
				if menu.Data then
					for _, v in ipairs(menu.Data) do
						elementDescription:CreateButton(v.styleName, function()
							TRP3_UF_DB.Border.style = v.fileName;
							if trpPlayer.SetAsPortrait then
								trpPlayer.SetAsPortrait();
							end
						end)
					end
				else
					elementDescription:SetEnabled(false)
					elementDescription:SetTooltip(function(tooltip, elementDesc)
						GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDesc));
						GameTooltip_AddErrorLine(tooltip, menu.ThemeDesc);
					end)
				end
			end
		end,
	})
end


local function BuildScrollArea(parentFrame, topOffset)
	local SearchBox = CreateFrame("EditBox", nil, parentFrame, "SearchBoxTemplate")
	SearchBox:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 8, topOffset)
	SearchBox:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -25, topOffset)
	SearchBox:SetHeight(20)
	SearchBox:SetAutoFocus(false)

	local ScrollBox = CreateFrame("Frame", nil, parentFrame, "WowScrollBoxList")
	ScrollBox:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 6, topOffset - 28)
	ScrollBox:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -25, 6)

	local ScrollBar = CreateFrame("EventFrame", nil, parentFrame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT", 5, 0)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT", 5, 0)

	local ScrollView = CreateScrollBoxListLinearView()
	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)
	ScrollView:SetElementInitializer("Button", SettingsRowInitializer)
	ScrollView:SetElementExtent(30)
	ScrollView:SetPadding(5, 5, 5, 5, 2)

	local function FilterSettings()
		local query = SearchBox:GetText():lower();
		local filtered = {};
		for _, data in ipairs(allSettingsData) do
			if query == "" then
				table.insert(filtered, data);
			elseif data.type ~= "header" and data.searchText and data.searchText:find(query, 1, true) then
				table.insert(filtered, data);
			end
		end
		ScrollView:SetDataProvider(CreateDataProvider(filtered));
	end

	SearchBox:HookScript("OnTextChanged", function(self)
		self.t = 0;
		self:SetScript("OnUpdate", function(s, elapsed)
			s.t = s.t + elapsed;
			if s.t >= 0.2 then
				s.t = 0;
				s:SetScript("OnUpdate", nil);
				FilterSettings();
			end
		end)
	end)

	return FilterSettings;
end


function TRP3_UnitFrames.InitializeSettingsUI()
	allFilterFuncs = {}

	local TRP3_UFPanel = CreateFrame("Frame")
	TRP3_UFPanel.name = C_AddOns.GetAddOnMetadata("totalRP3_UnitFrames", "Title")
	TRP3_UnitFrames.TRP3_UFPanel = TRP3_UFPanel

	local VERSION_TEXT = string.format(
		TRP3_API.loc.CREDITS_VERSION_TEXT,
		C_AddOns.GetAddOnMetadata("totalRP3_UnitFrames", "Version"))

	TRP3_UFPanel.Headline = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TRP3_UFPanel.Headline:SetFont(TRP3_UFPanel.Headline:GetFont(), 23)
	TRP3_UFPanel.Headline:SetTextColor(1, .73, 0, 1)
	TRP3_UFPanel.Headline:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 12, -12)
	TRP3_UFPanel.Headline:SetText(L["TitleColored"])

	TRP3_UFPanel.Version = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TRP3_UFPanel.Version:SetFont(TRP3_UFPanel.Version:GetFont(), 12)
	TRP3_UFPanel.Version:SetTextColor(1, 1, 1, 1)
	TRP3_UFPanel.Version:SetPoint("LEFT", TRP3_UFPanel.Headline, "RIGHT", 25, 0)
	TRP3_UFPanel.Version:SetText(VERSION_TEXT)

	local menuNew = {
		[1] = {
			ThemeName = L["Dragons"],
			Data = {
				[1] = { styleName = ITEM_QUALITY3_DESC,						fileName = "rare", },
				[2] = { styleName = ELITE,									fileName = "elite", },
				[3] = { styleName = ITEM_QUALITY3_DESC .. " " .. ELITE,		fileName = "rare-elite", },
				[4] = { styleName = BOSS,									fileName = "boss", },
			},
		},
		--[2] = { ThemeName = L["Hearthstone"], ThemeDesc = L["ComingSoon"], Data = nil, },
		[2] = C_AddOns.IsAddOnLoaded("Narcissus") and {
			ThemeName = L["Narcissus"],
			Data = {
				[1] = { styleName = "Default",				fileName = "NarciHexagonBorder", },
				[2] = { styleName = "Artifact",				fileName = "NarciHexagonBorder-Artifact", },
				[3] = { styleName = "Azerite",				fileName = "NarciHexagonBorder-Azerite", },
				[4] = { styleName = "Black",				fileName = "NarciHexagonBorder-Black", },
				[5] = { styleName = "Black Dragon",			fileName = "NarciHexagonBorder-BlackDragon", },
				[6] = { styleName = ITEM_QUALITY6_DESC,		fileName = "NarciHexagonBorder-Epic", },
				[7] = { styleName = "Heart",				fileName = "NarciHexagonBorder-Heart", },
				[8] = { styleName = "Heirloom",				fileName = "NarciHexagonBorder-Heirloom", },
				[9] = { styleName = ITEM_QUALITY5_DESC,		fileName = "NarciHexagonBorder-Legendary", },
				[10] = { styleName = "N'Zoth",				fileName = "NarciHexagonBorder-NZoth", },
				[11] = { styleName = ITEM_QUALITY3_DESC,	fileName = "NarciHexagonBorder-Rare", },
				[12] = { styleName = "Special",				fileName = "NarciHexagonBorder-Special", },
				[13] = { styleName = ITEM_QUALITY2_DESC, 	fileName = "NarciHexagonBorder-Uncommon", },
				[14] = { styleName = "Void",				fileName = "NarciHexagonBorder-Void", },
			},
		} or { ThemeName = L["Narcissus"], ThemeDesc = L["NotDetected"], Data = nil, },
		[3] = {
			ThemeName = L["LGBQT+"],
			Data = {
				[1] = { styleName = L["Agender"],				fileName = "agender", },
				[2] = { styleName = L["Asexual"],				fileName = "asexual", },
				[3] = { styleName = L["Aromantic Asexual"],		fileName = "aroace", },
				[4] = { styleName = L["Bisexual"],				fileName = "bisexual", },
				[5] = { styleName = L["Non-Binary"],			fileName = "enby", },
				[6] = { styleName = L["Gay Male"],				fileName = "gaym", },
				[7] = { styleName = L["Genderfluid"],			fileName = "genderfluid", },
				[8] = { styleName = L["Genderqueer"],			fileName = "genderqueer", },
				[9] = { styleName = L["Lesbian"],				fileName = "lesbian", },
				[10] = { styleName = L["Transgender"],			fileName = "transgender", },
				[11] = { styleName = L["Pansexual"],			fileName = "pansexual", },
				[12] = { styleName = L["Rainbow"],				fileName = "rainbow", },
				[13] = { styleName = L["RainbowPhilly"],		fileName = "rainbowphilly", },
				[14] = { styleName = L["RainbowGilBaker"],		fileName = "rainbowgilbaker", },
				[15] = { styleName = L["RainbowProgress"],		fileName = "rainbowprogress", },
			},
		},
	};
	TRP3_UFPanel.menuNew = menuNew

	BuildDummyFrames(TRP3_UFPanel, 5, -50, 350, -50,
		"TRP3_UFRepDummyPlayer",	"TRP3_UFRepTextDummyPlayer",
		"TRP3_UFRepDummyTarget",	"TRP3_UFRepTextDummyTarget")

	BuildSettingsData(menuNew)

	local filter1 = BuildScrollArea(TRP3_UFPanel, -155)
	table.insert(allFilterFuncs, filter1)
	filter1()

	local TRP3_UFSettingsFrame = CreateFrame("Frame", "TRP3_UFSettingsFrame", UIParent, "InsetFrameTemplate")
	TRP3_UFSettingsFrame:ClearAllPoints()
	TRP3_UFSettingsFrame:Hide()

	TRP3_UFSettingsFrame.TopTitle = TRP3_UFSettingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TRP3_UFSettingsFrame.TopTitle:SetFont(TRP3_UFSettingsFrame.TopTitle:GetFont(), 20)
	TRP3_UFSettingsFrame.TopTitle:SetPoint("TOPLEFT", TRP3_UFSettingsFrame, "TOPLEFT", 50, -25)
	TRP3_UFSettingsFrame.TopTitle:SetText(TRP3_API.utils.Oldgodify(L["Title"]))

	BuildDummyFrames(TRP3_UFSettingsFrame, 15, -55, 325, -55,
		"TRP3_UFSettingsRepDummyPlayer",  "TRP3_UFSettingsRepTextDummyPlayer",
		"TRP3_UFSettingsRepDummyTarget",  "TRP3_UFSettingsRepTextDummyTarget")

	local filter2 = BuildScrollArea(TRP3_UFSettingsFrame, -160)
	table.insert(allFilterFuncs, filter2)
	filter2()

	function TRP3_UnitFrames.CheckSettings()
		for _, fn in ipairs(allFilterFuncs) do fn(); end
	end

	local category = Settings.RegisterCanvasLayoutCategory(TRP3_UFPanel, TRP3_UFPanel.name, TRP3_UFPanel.name)
	category.ID = TRP3_UFPanel.name
	Settings.RegisterAddOnCategory(category)
end