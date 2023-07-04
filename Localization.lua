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
	L["PluginColored"] = "Unit Frames"
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
	L["TRP3CustomName"] = "Use TRP3 RP Name"
	L["FullNamePlayer"] = "Player Full Name"
	L["FullNameTarget"] = "Target Full Name"
	L["PlayerPortrait"] = "Player Portrait"
	L["Dragons"] = "Dragons"
	L["Hearthstone"] = "Hearthstone"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "Coming Soon!"
	L["SelectOption"] = "Select an Option"
	L["NotDetected"] = "Not detected"

	L["Agender"] = "Agender"
	L["Aromantic Asexual"] = "Aromantic Asexual"
	L["Bisexual"] = "Bisexual"
	L["Non-Binary"] = "Non-Binary"
	L["Gay Male"] = "Gay Male"
	L["Genderfluid"] = "Genderfluid"
	L["Genderqueer"] = "Genderqueer"
	L["Lesbian"] = "Lesbian"
	L["Transgender"] = "Transgender"
	L["Pansexual"] = "Pansexual"
	L["Rainbow"] = "Rainbow"
	L["RainbowPhilly"] = "Rainbow (Philadelphia)"
	L["RainbowGilBaker"] = "Rainbow (Gilbert Baker)"
	L["RainbowProgress"] = "Rainbow (Progress)"
return end

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["Title"] = "Total RP 3: Marcos de unidad"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Marcos de unidad|r"
	L["PluginColored"] = "Marcos de unidad"
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
	L["TRP3CustomName"] = "Usar nombre de RP TRP3"
	L["FullNamePlayer"] = "Nombre completo del jugador"
	L["FullNameTarget"] = "Nombre completo del objetivo"
	L["PlayerPortrait"] = "Retrato del jugador"
	L["Dragons"] = "Dragones"
	L["Hearthstone"] = "Hearthstone"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "¡Muy pronto!"
	L["SelectOption"] = "Seleccione una opción"
	L["NotDetected"] = "No detectado"

	L["Agender"] = "Agénero"
	L["Aromantic Asexual"] = "Aromantic Asexual"
	L["Bisexual"] = "Bisexualidad"
	L["Non-Binary"] = "Nichtbinäre Geschlechtsidentität"
	L["Gay Male"] = "Hombre Homosexual"
	L["Genderfluid"] = "Género Fluido"
	L["Genderqueer"] = "Genderqueer"
	L["Lesbian"] = "Lesbiana"
	L["Transgender"] = "Transgénero"
	L["Pansexual"] = "Pansexual"
	L["Rainbow"] = "Arcoíris"
	L["RainbowPhilly"] = "Arcoíris (Filadelfia)"
	L["RainbowGilBaker"] = "Arcoíris (Gilbert Baker)"
	L["RainbowProgress"] = "Arcoíris (Progreso)"
return end

if LOCALE == "deDE" then
	-- German translations go here
	L["Title"] = "Total RP 3: Einheitsrahmen"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Einheitsrahmen|r"
	L["PluginColored"] = "Einheitsrahmen"
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
	L["TRP3CustomName"] = "Verwenden Sie den TRP3-RP-Namen"
	L["FullNamePlayer"] = "Vollständiger Name des Spielers"
	L["FullNameTarget"] = "Vollständiger Name des Ziels"
	L["PlayerPortrait"] = "Spielerportrait"
	L["Dragons"] = "Drachen"
	L["Hearthstone"] = "Hearthstone"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "Demnächst!"
	L["SelectOption"] = "Wähle eine Option"
	L["NotDetected"] = "Nicht erkannt"

	L["Agender"] = "Agender"
	L["Aromantic Asexual"] = "Aromantic Asexual"
	L["Bisexual"] = "Bisexualität"
	L["Non-Binary"] = "Nichtbinäre Geschlechtsidentität"
	L["Gay Male"] = "Schwuler Mann"
	L["Genderfluid"] = "Genderfluid"
	L["Genderqueer"] = "Genderqueer"
	L["Lesbian"] = "Lesbisch"
	L["Transgender"] = "Transgender"
	L["Pansexual"] = "Pansexuell"
	L["Rainbow"] = "Regenbogen"
	L["RainbowPhilly"] = "Regenbogen (Philadelphia)"
	L["RainbowGilBaker"] = "Regenbogen (Gilbert Baker)"
	L["RainbowProgress"] = "Regenbogen (Fortschritt)"
return end

if LOCALE == "frFR" then
	-- French translations go here
	L["Title"] = "Total RP 3: Cadres unitaires"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Cadres unitaires|r"
	L["PluginColored"] = "Cadres unitaires"
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
	L["TRP3CustomName"] = "Utiliser le nom du RP TRP3"
	L["FullNamePlayer"] = "Nom complet du joueur"
	L["FullNameTarget"] = "Nom complet de la cible"
	L["PlayerPortrait"] = "Portrait du joueur"
	L["Dragons"] = "Dragons"
	L["Hearthstone"] = "Hearthstone"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "À venir!"
	L["SelectOption"] = "Choisir une option"
	L["NotDetected"] = "Non-détecté"

	L["Agender"] = "Agenre"
	L["Aromantic Asexual"] = "Asexué Aromantique"
	L["Bisexual"] = "Bisexualité"
	L["Non-Binary"] = "Non-Binarité"
	L["Gay Male"] = "Gay Homme"
	L["Genderfluid"] = "Genre Fluide"
	L["Genderqueer"] = "Genre Queer"
	L["Lesbian"] = "Lesbienne"
	L["Transgender"] = "Transgenres"
	L["Pansexual"] = "Pansexuel"
	L["Rainbow"] = "Arc-en-ciel"
	L["RainbowPhilly"] = "Arc-en-ciel (Philadelphia)"
	L["RainbowGilBaker"] = "Arc-en-ciel (Gilbert Baker)"
	L["RainbowProgress"] = "Arc-en-ciel (Progrès)"
return end

if LOCALE == "itIT" then
	-- Italian translations go here
	L["Title"] = "Total RP 3: Cornici unità"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Cornici unità|r"
	L["PluginColored"] = "Cornici unità"
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
	L["TRP3CustomName"] = "Usa il nome RP TRP3"
	L["FullNamePlayer"] = "Nome completo del giocatore"
	L["FullNameTarget"] = "Destinazione Nome completo"
	L["PlayerPortrait"] = "Ritratto del giocatore"
	L["Dragons"] = "Draghi"
	L["Hearthstone"] = "Hearthstone"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "Prossimamente!"
	L["SelectOption"] = "Seleziona un'opzione"
	L["NotDetected"] = "Non rilevata"

	L["Agender"] = "Agenda"
	L["Aromantic Asexual"] = "Asessuale Aromatico"
	L["Bisexual"] = "Bisessualità"
	L["Non-Binary"] = "Non Binario"
	L["Gay Male"] = "Maschio Gay"
	L["Genderfluid"] = "Fluido di genere"
	L["Genderqueer"] = "Genderqueer"
	L["Lesbian"] = "Lesbica"
	L["Transgender"] = "Transgender"
	L["Pansexual"] = "Pansessuale"
	L["Rainbow"] = "Arcobaleno"
	L["RainbowPhilly"] = "Arcobaleno (Filadelfia)"
	L["RainbowGilBaker"] = "Arcobaleno (Gilbert Baker)"
	L["RainbowProgress"] = "Arcobaleno (Progresso)"
return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["Title"] = "Total RP 3: Molduras da unidade"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Molduras da unidade|r"
	L["PluginColored"] = "Molduras da unidade"
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
	L["TRP3CustomName"] = "Usar nome TRP3 RP"
	L["FullNamePlayer"] = "Nome Completo do Jogador"
	L["FullNameTarget"] = "Nome Completo do Alvo"
	L["PlayerPortrait"] = "Retrato do jogador"
	L["Dragons"] = "Dragões"
	L["Hearthstone"] = "Hearthstone"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "Em breve!"
	L["SelectOption"] = "Selecione uma opção"
	L["NotDetected"] = "Não detectado"

	L["Agender"] = "Ageneridade"
	L["Aromantic Asexual"] = "Assexual Aromântico"
	L["Bisexual"] = "Bissexualidade"
	L["Non-Binary"] = "Não-binário"
	L["Gay Male"] = "Homem Gay"
	L["Genderfluid"] = "Gênero Fluido"
	L["Genderqueer"] = "Genderqueer"
	L["Lesbian"] = "Lésbica"
	L["Transgender"] = "Transgénero"
	L["Pansexual"] = "Pansexual"
	L["Rainbow"] = "Arco-íris"
	L["RainbowPhilly"] = "Arco-íris (Filadélfia)"
	L["RainbowGilBaker"] = "Arco-íris (Gilbert Baker)"
	L["RainbowProgress"] = "Arco-íris (Progresso)"
	-- Note that the EU Portuguese WoW client also
	-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["Title"] = "Total RP 3: Рамки блока"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: Рамки блока|r"
	L["PluginColored"] = "Рамки блока"
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
	L["TRP3CustomName"] = "Использовать имя RP TRP3"
	L["FullNamePlayer"] = "Полное имя игрока"
	L["FullNameTarget"] = "Целевое полное имя"
	L["PlayerPortrait"] = "Портрет игрока"
	L["Dragons"] = "Драконы"
	L["Hearthstone"] = "Hearthstone"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "ЛГБТК+"
	L["ComingSoon"] = "Вскоре!"
	L["SelectOption"] = "Выберите вариант"
	L["NotDetected"] = "Не обнаружен"

	L["Agender"] = "Агендер"
	L["Aromantic Asexual"] = "аромантичный асексуал"
	L["Bisexual"] = "Бисексуальность"
	L["Non-Binary"] = "Небинарный"
	L["Gay Male"] = "Гей Мужчина"
	L["Genderfluid"] = "Гендерфлюид"
	L["Genderqueer"] = "Гендерквир"
	L["Lesbian"] = "Лесби"
	L["Transgender"] = "Трансгендерность"
	L["Pansexual"] = "Пансексуал"
	L["Rainbow"] = "Радуга"
	L["RainbowPhilly"] = "Радуга (Филадельфия)"
	L["RainbowGilBaker"] = "Радуга (Гилберт Бейкер)"
	L["RainbowProgress"] = "Радуга (Прогресс)"
return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["Title"] = "Total RP 3: 단위 프레임"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: 단위 프레임|r"
	L["PluginColored"] = "단위 프레임"
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
	L["TRP3CustomName"] = "TRP3 RP 이름 사용"
	L["FullNamePlayer"] = "선수 성명"
	L["FullNameTarget"] = "대상 전체 이름"
	L["PlayerPortrait"] = "플레이어 초상화"
	L["Dragons"] = "용"
	L["Hearthstone"] = "하스스톤"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "곧 출시됩니다!"
	L["SelectOption"] = "옵션을 선택하세요"
	L["NotDetected"] = "감지되지 않음"

	L["Agender"] = "에이젠더"
	L["Aromantic Asexual"] = "무로맨틱 무성애자"
	L["Bisexual"] = "양성애"
	L["Non-Binary"] = "논바이너리"
	L["Gay Male"] = "게이 남성"
	L["Genderfluid"] = "젠더플루이드"
	L["Genderqueer"] = "젠더퀴어"
	L["Lesbian"] = "레즈비언"
	L["Transgender"] = "트랜스젠더"
	L["Pansexual"] = "범성애자"
	L["Rainbow"] = "무지개"
	L["RainbowPhilly"] = "무지개 (필라델피아)"
	L["RainbowGilBaker"] = "무지개 (길버트 베이커)"
	L["RainbowProgress"] = "무지개 (진전)"
return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here
	L["Title"] = "Total RP 3: 单位框架"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: 单位框架|r"
	L["PluginColored"] = "单位框架"
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
	L["TRP3CustomName"] = "使用 TRP3 RP 名称"
	L["FullNamePlayer"] = "玩家全名"
	L["FullNameTarget"] = "目标全名"
	L["PlayerPortrait"] = "玩家头像"
	L["Dragons"] = "龙"
	L["Hearthstone"] = "炉石传说"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "即将推出！"
	L["SelectOption"] = "选择一个选项"
	L["NotDetected"] = "没有检测到"

	L["Agender"] = "无性别"
	L["Aromantic Asexual"] = "芳香无性"
	L["Bisexual"] = "双性恋"
	L["Non-Binary"] = "非二进制"
	L["Gay Male"] = "男同性恋"
	L["Genderfluid"] = "性别流动"
	L["Genderqueer"] = "性别酷儿"
	L["Lesbian"] = "女同性恋"
	L["Transgender"] = "跨性别"
	L["Pansexual"] = "泛性恋"
	L["Rainbow"] = "彩虹"
	L["RainbowPhilly"] = "彩虹 (费城)"
	L["RainbowGilBaker"] = "彩虹 (吉尔伯特·贝克)"
	L["RainbowProgress"] = "彩虹 (进步)"
return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here
	L["Title"] = "Total RP 3: 單位框架"
	L["TitleColored"] = "|cffF5038BTotal RP 3|r|cffffffff: 單位框架|r"
	L["PluginColored"] = "單位框架"
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
	L["TRP3CustomName"] = "使用 TRP3 RP 名稱"
	L["FullNamePlayer"] = "玩家全名"
	L["FullNameTarget"] = "目標全名"
	L["PlayerPortrait"] = "玩家頭像"
	L["Dragons"] = "龍"
	L["Hearthstone"] = "炉石传说"
	L["Narcissus"] = "Narcissus"
	L["LGBQT+"] = "LGBQT+"
	L["ComingSoon"] = "即將推出！"
	L["SelectOption"] = "選擇一個選項"
	L["NotDetected"] = "沒有檢測到"

	L["Agender"] = "无性别"
	L["Aromantic Asexual"] = "芳香无性"
	L["Bisexual"] = "双性恋"
	L["Non-Binary"] = "非二进制"
	L["Gay Male"] = "男同性恋"
	L["Genderfluid"] = "性别流动"
	L["Genderqueer"] = "性别酷儿"
	L["Lesbian"] = "女同性恋"
	L["Transgender"] = "跨性别"
	L["Pansexual"] = "泛性戀"
	L["Rainbow"] = "彩虹"
	L["RainbowPhilly"] = "彩虹 (費城)"
	L["RainbowGilBaker"] = "彩虹 (吉爾伯特·貝克)"
	L["RainbowProgress"] = "彩虹 (進步)"
return end
