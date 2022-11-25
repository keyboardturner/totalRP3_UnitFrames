local totalRP3_UnitFrames, L = ...; -- Let's use the private table passed to every .lua 

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()

if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.
	L["Title"] = "Total RP 3: Unit Frames"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Unit Frames|r"
	L["Visibility"] = "Visibility"
	L["ShowButtonPlayer"] = "Show Player Button"
	L["ShowButtonTarget"] = "Show Target Button"
	L["ShowBorderFrame"] = "Show Border Frame"
	L["HideRestedGlow"] = "Hide Rested Glow"
	L["ButtonSizeTarget"] = 'Target Button Size'
	L["ButtonPosTarget"] = 'Target Button Position'
	L["ButtonSizePlayer"] = 'Player Button Size'
	L["ButtonPosPlayer"] = 'Player Button Position'
	L["OverwriteTextCol"] = "Overwrite Text Color"
	L["OverwriteBackCol"] = "Overwrite Backdrop Color"
	L["BlizzTextCol"] = "Use Blizzard Class Color - Text"
	L["BlizzBackCol"] = "Use Blizzard Class Color - Backdrop"
	L["ApplyToNPCs"] = "Apply to NPCs"
	L["PlayerPortrait"] = "Player Portrait"
return end

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["Title"] = "Total RP 3: Marcos de unidad"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Marcos de unidad|r"
	L["Visibility"] = "Visibilidad"
	L["ShowButtonPlayer"] = "Mostrar botón de jugador"
	L["ShowButtonTarget"] = "Mostrar botón de destino"
	L["ShowBorderFrame"] = "Mostrar marco de borde"
	L["HideRestedGlow"] = "Ocultar resplandor descansado"
	L["ButtonSizeTarget"] = 'Tamaño del botón de destino'
	L["ButtonPosTarget"] = 'Posición del botón de destino'
	L["ButtonSizePlayer"] = 'Tamaño del botón del reproductor'
	L["ButtonPosPlayer"] = 'Posición del botón del jugador'
	L["OverwriteTextCol"] = "Sobrescribir color de texto"
	L["OverwriteBackCol"] = "Sobrescribir color de fondo"
	L["BlizzTextCol"] = "Usar color de clase de Blizzard - Texto"
	L["BlizzBackCol"] = "Usar color de clase de Blizzard - Telón de fondo"
	L["ApplyToNPCs"] = "Aplicar a los NPC"
	L["PlayerPortrait"] = "Retrato del jugador"
return end

if LOCALE == "deDE" then
	-- German translations go here
	L["Title"] = "Total RP 3: Einheitsrahmen"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Einheitsrahmen|r"
	L["Visibility"] = "Sichtweite"
	L["ShowButtonPlayer"] = "Player-Button anzeigen"
	L["ShowButtonTarget"] = "Zielschaltfläche anzeigen"
	L["ShowBorderFrame"] = "Rahmen anzeigen"
	L["HideRestedGlow"] = "Ausgeruhtes Leuchten ausblenden"
	L["ButtonSizeTarget"] = 'Größe der Zielschaltfläche'
	L["ButtonPosTarget"] = 'Position der Zielschaltfläche'
	L["ButtonSizePlayer"] = 'Player-Tastengröße'
	L["ButtonPosPlayer"] = 'Position der Player-Schaltfläche'
	L["OverwriteTextCol"] = "Textfarbe überschreiben"
	L["OverwriteBackCol"] = "Hintergrundfarbe überschreiben"
	L["BlizzTextCol"] = "Verwenden Sie die Blizzard-Klassenfarbe - Text"
	L["BlizzBackCol"] = "Verwenden Sie die Blizzard-Klassenfarbe - Hintergrund"
	L["ApplyToNPCs"] = "Bewerben Sie sich bei NPCs"
	L["PlayerPortrait"] = "Spielerportrait"
return end

if LOCALE == "frFR" then
	-- French translations go here
	L["Title"] = "Total RP 3: Cadres unitaires"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Cadres unitaires|r"
	L["Visibility"] = "Visibilité"
	L["ShowButtonPlayer"] = "Afficher le bouton du lecteur"
	L["ShowButtonTarget"] = "Afficher le bouton cible"
	L["ShowBorderFrame"] = "Afficher le cadre de bordure"
	L["HideRestedGlow"] = "Masquer l'éclat reposé"
	L["ButtonSizeTarget"] = 'Taille cible du bouton'
	L["ButtonPosTarget"] = 'Position du bouton cible'
	L["ButtonSizePlayer"] = 'Taille du bouton du lecteur'
	L["ButtonPosPlayer"] = 'Position du bouton du joueur'
	L["OverwriteTextCol"] = "Remplacer la couleur du texte"
	L["OverwriteBackCol"] = "Remplacer la couleur de fond"
	L["BlizzTextCol"] = "Utiliser la couleur de la classe Blizzard - Texte"
	L["BlizzBackCol"] = "Utiliser la couleur de la classe Blizzard - Toile de fond"
	L["ApplyToNPCs"] = "Appliquer aux PNJ"
	L["PlayerPortrait"] = "Portrait du joueur"
return end

if LOCALE == "itIT" then
	-- Italian translations go here
	L["Title"] = "Total RP 3: Cornici unità"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Cornici unità|r"
	L["Visibility"] = "Visibilità"
	L["ShowButtonPlayer"] = "Mostra pulsante giocatore"
	L["ShowButtonTarget"] = "Mostra pulsante di destinazione"
	L["ShowBorderFrame"] = "Mostra cornice bordo"
	L["HideRestedGlow"] = "Nascondi bagliore riposato"
	L["ButtonSizeTarget"] = 'Dimensioni del pulsante di destinazione'
	L["ButtonPosTarget"] = 'Posizione del pulsante di destinazione'
	L["ButtonSizePlayer"] = 'Dimensione del pulsante del giocatore'
	L["ButtonPosPlayer"] = 'Posizione del pulsante del giocatore'
	L["OverwriteTextCol"] = "Sovrascrivi il colore del testo"
	L["OverwriteBackCol"] = "Sovrascrivi colore di sfondo"
	L["BlizzTextCol"] = "Usa il colore della classe Blizzard - Testo"
	L["BlizzBackCol"] = "Usa il colore della classe Blizzard - Sfondo"
	L["ApplyToNPCs"] = "Applica agli NPC"
	L["PlayerPortrait"] = "Ritratto del giocatore"
return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["Title"] = "Total RP 3: Molduras da unidade"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Molduras da unidade|r"
	L["Visibility"] = "Visibilidade"
	L["ShowButtonPlayer"] = "Mostrar Botão do Jogador"
	L["ShowButtonTarget"] = "Mostrar Botão Alvo"
	L["ShowBorderFrame"] = "Mostrar Moldura da Borda"
	L["HideRestedGlow"] = "Ocultar brilho descansado"
	L["ButtonSizeTarget"] = 'Tamanho do botão de destino'
	L["ButtonPosTarget"] = 'Posição do Botão Alvo'
	L["ButtonSizePlayer"] = 'Tamanho do botão do jogador'
	L["ButtonPosPlayer"] = 'Posição do botão do jogador'
	L["OverwriteTextCol"] = "Sobrescrever a Cor do Texto"
	L["OverwriteBackCol"] = "Sobrescrever a cor do pano de fundo"
	L["BlizzTextCol"] = "Use a cor da classe Blizzard - texto"
	L["BlizzBackCol"] = "Use a cor da classe Blizzard - Pano de fundo"
	L["ApplyToNPCs"] = "Aplicar para NPCs"
	L["PlayerPortrait"] = "Retrato do jogador"
	-- Note that the EU Portuguese WoW client also
	-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["Title"] = "Total RP 3: Рамки блока"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Рамки блока|r"
	L["Visibility"] = "Видимость"
	L["ShowButtonPlayer"] = "Показать кнопку проигрывателя"
	L["ShowButtonTarget"] = "Показать целевую кнопку"
	L["ShowBorderFrame"] = "Показать рамку границы"
	L["HideRestedGlow"] = "Скрыть отдохнувшее сияние"
	L["ButtonSizeTarget"] = 'Целевой размер кнопки'
	L["ButtonPosTarget"] = 'Положение целевой кнопки'
	L["ButtonSizePlayer"] = 'Размер кнопки игрока'
	L["ButtonPosPlayer"] = 'Положение кнопки игрока'
	L["OverwriteTextCol"] = "Перезаписать цвет текста"
	L["OverwriteBackCol"] = "Перезаписать цвет фона"
	L["BlizzTextCol"] = "Использовать цвет класса Blizzard — текст"
	L["BlizzBackCol"] = "Использовать цвет класса Blizzard — фон"
	L["ApplyToNPCs"] = "Применить к NPC"
	L["PlayerPortrait"] = "Портрет игрока"
return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["Title"] = "Total RP 3: 단위 프레임"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: 단위 프레임|r"
	L["Visibility"] = "시계"
	L["ShowButtonPlayer"] = "플레이어 버튼 표시"
	L["ShowButtonTarget"] = "대상 버튼 표시"
	L["ShowBorderFrame"] = "테두리 프레임 표시"
	L["HideRestedGlow"] = "휴식된 빛 숨기기"
	L["ButtonSizeTarget"] = '대상 버튼 크기'
	L["ButtonPosTarget"] = '대상 버튼 위치'
	L["ButtonSizePlayer"] = '플레이어 버튼 크기'
	L["ButtonPosPlayer"] = '플레이어 버튼 위치'
	L["OverwriteTextCol"] = "텍스트 색상 덮어쓰기"
	L["OverwriteBackCol"] = "배경색 덮어쓰기"
	L["BlizzTextCol"] = "블리자드 클래스 색상 사용 - 텍스트"
	L["BlizzBackCol"] = "블리자드 클래스 색상 사용 - 배경"
	L["ApplyToNPCs"] = "NPC에 적용"
	L["PlayerPortrait"] = "플레이어 초상화"
return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here
	L["Title"] = "Total RP 3: 单位框架"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: 单位框架|r"
	L["Visibility"] = "能见度"
	L["ShowButtonPlayer"] = "显示播放器按钮"
	L["ShowButtonTarget"] = "显示目标按钮"
	L["ShowBorderFrame"] = "显示边框"
	L["HideRestedGlow"] = "隐藏休息的光芒"
	L["ButtonSizeTarget"] = '目标按钮尺寸'
	L["ButtonPosTarget"] = '目标按钮位置'
	L["ButtonSizePlayer"] = '播放器按钮大小'
	L["ButtonPosPlayer"] = '播放器按钮位置'
	L["OverwriteTextCol"] = "覆盖文字颜色"
	L["OverwriteBackCol"] = "覆盖背景颜色"
	L["BlizzTextCol"] = "使用暴雪类颜色 - 文本"
	L["BlizzBackCol"] = "使用暴雪类颜色 - 背景"
	L["ApplyToNPCs"] = "适用于 NPC"
	L["PlayerPortrait"] = "玩家头像"
return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here
	L["Title"] = "Total RP 3: 單位框架"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: 單位框架|r"
	L["Visibility"] = "能見度"
	L["ShowButtonPlayer"] = "顯示播放器按鈕"
	L["ShowButtonTarget"] = "顯示目標按鈕"
	L["ShowBorderFrame"] = "顯示邊框"
	L["HideRestedGlow"] = "隱藏休息的光芒"
	L["ButtonSizeTarget"] = '目標按鈕尺寸'
	L["ButtonPosTarget"] = '目標按鈕位置'
	L["ButtonSizePlayer"] = '播放器按鈕大小'
	L["ButtonPosPlayer"] = '播放器按鈕位置'
	L["OverwriteTextCol"] = "覆蓋文字顏色"
	L["OverwriteBackCol"] = "覆蓋背景顏色"
	L["BlizzTextCol"] = "覆蓋背景顏色"
	L["BlizzBackCol"] = "使用暴雪類顏色 - 背景"
	L["ApplyToNPCs"] = "適用於 NPC"
	L["PlayerPortrait"] = "玩家頭像"
return end
