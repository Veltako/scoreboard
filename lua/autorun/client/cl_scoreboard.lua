include("autorun/sh_scoreboardscp.lua")

surface.CreateFont( "ROBOTO22", {
	font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 22,
	weight = 500,
} )

surface.CreateFont( "ROBOTO18", {
	font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 18,
	weight = 500,
} )

local function ToggleScoreboard(toggle)
    if toggle then -- si le joueur appuie sur sa touche "toggle dans ces parametre"
        local scrw,scrh = ScrW(), ScrH() -- la résolution de l'écran qui est undefinned pour le capter automatiquement
        MonAddonScoreboard = vgui.Create("DFrame")
        MonAddonScoreboard:SetTitle("") -- le nom du scoreboard
        MonAddonScoreboard:SetSize(scrw * .35, scrh * .8) -- la taille du scoreboard largeur * longueur
        MonAddonScoreboard:Center() -- centrer le scoreboard au milieu de l'écran
        MonAddonScoreboard:MakePopup() -- comment il va apparaitre
        MonAddonScoreboard:ShowCloseButton(false) -- pour enlever le btn en haut
        MonAddonScoreboard:SetDraggable(false) -- empeche de bouger la Dframe
        MonAddonScoreboard.Paint = function(self,w,h) -- permet de créer la box
            surface.SetDrawColor(0,0,0,150) -- met la couleur de la box
            surface.DrawRect(0,0,w,h) -- créer la taille de la box
            draw.SimpleText("Liste des joueurs", "ROBOTO22", w / 2, h * .015, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) -- permet d'avoir du text 
        end
        local scroll = vgui.Create("DScrollPanel", MonAddonScoreboard) -- création du scroll
        scroll:SetPos(0, MonAddonScoreboard:GetTall() * .03) -- règle la taille de l'espace pour le texte en haut du scoreboard
        scroll:SetSize(MonAddonScoreboard:GetWide(), MonAddonScoreboard:GetTall() * 0.95) -- la taille de la liste si il est = à 100 on peut pourra pas voir tout les joueurs
        local sbar = scroll:GetVBar()
        function sbar:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(55, 55, 55)) -- bg de la barre de scroll
        end
        function sbar.btnUp:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0)) -- btn up
        end
        function sbar.btnDown:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0)) -- btn down
        end
        function sbar.btnGrip:Paint(w, h)
            draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150)) -- barre
        end
        local ypos = 0 -- la position 
        for k, v in pairs(player.GetAll()) do -- permet de vérifier si le joueurs regarde toujours le garde à jours
            local playerPanel = vgui.Create("DPanel", scroll) -- permet de créer chaque case du scoreboard
            playerPanel:SetPos(0, ypos) -- met en place la position de la case
            playerPanel:SetSize(MonAddonScoreboard:GetWide(), MonAddonScoreboard:GetTall() * .05) -- permet de régler la taille de chaque case
            local name = v:Name() -- variable qui stock le nom du joueurs
            local ping = v:Ping() -- variable qui stock le ping du joueurs
            playerPanel.Paint = function(self,w,h) -- permet de créer la box
                if IsValid(v) then -- vérifie si il y a des choses à afficher en plus ou en moins
                    surface.SetDrawColor(0, 0, 0, 100) -- met la couleur de la box
                    surface.DrawRect(0,0,w,h) -- créer la taille de la box
                    draw.SimpleText(name, "ROBOTO18", w / 6, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) -- le texte pour le nom
                    draw.SimpleText("Ping : " .. ping, "ROBOTO18", w / 1.2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) -- le texte pour le ping
                end
            end
            ypos = ypos + playerPanel:GetTall() * 1.1 -- il écarte pour empiler et ne pas stacker sur place les joueurs
/*             local playerInfo = vgui.Create(D, parent=nil, name=nil) */
        end
    else
        if IsValid(MonAddonScoreboard) then -- si il arrete d'appuier sur son "toggle"
            MonAddonScoreboard:Remove() -- alors le scoreboard s'enlève
        end
    end
end

hook.Add("ScoreboardShow", "scoreboardopen", function() -- evenement
    ToggleScoreboard(true) -- définie l'ouverture du scoreboard 
    return false -- désactive l'ancien scoreboard
end)

hook.Add("ScoreboardHide", "scoreboardclose", function() -- evenement
    ToggleScoreboard(false) -- définie la fermeture du scoreboard
end)