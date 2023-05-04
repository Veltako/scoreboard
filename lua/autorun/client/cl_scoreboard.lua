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
        MonAddonScoreboard.Paint = function(self,w,h)
            surface.SetDrawColor(0,0,0,230)
            surface.DrawRect(0,0,w,h)
            draw.SimpleText("Scoreboard", "ROBOTO22", w / 2, h * .015, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        local scroll = vgui.Create("DScrollPanel", MonAddonScoreboard)
        scroll:SetPos(0, MonAddonScoreboard:GetTall() * .03)
        scroll:SetSize(MonAddonScoreboard:GetWide(), MonAddonScoreboard:GetTall() * .5)
        local ypos = 0
        for k, v in pairs(player.GetAll()) do
            local playerPanel = vgui.Create("DPanel", scroll)
            playerPanel:SetPos(0, ypos)
            playerPanel:SetSize(MonAddonScoreboard:GetWide(), MonAddonScoreboard:GetTall() * .05)
            local name = v:Name()
            local ping = v:Ping()
            playerPanel.Paint = function(self,w,h)
                if IsValid(v) then
                    surface.SetDrawColor(0, 0, 0, 200)
                    surface.DrawRect(0,0,w,h)
                    draw.SimpleText(name .. " Ping : " .. ping, "ROBOTO18", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
            ypos = ypos + playerPanel:GetTall() * 1.1
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