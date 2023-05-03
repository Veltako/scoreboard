include("autorun/sh_scoreboardscp.lua")


local function ToggleScoreboard(toggle)
    if toggle then -- si le joueur appuie sur sa touche "toggle dans ces parametre"
        local scrw,scrh = ScrW(), ScrH() -- la résolution de l'écran qui est undefinned pour le capter automatiquement
        MonAddonScoreboard = vgui.Create("DFrame")
        MonAddonScoreboard:SetTitle("Nom du serveur") -- le nom du scoreboard
        MonAddonScoreboard:SetSize(scrw * .35, scrh * .8) -- la taille du scoreboard largeur * longueur
        MonAddonScoreboard:Center() -- centrer le scoreboard au milieu de l'écran
        MonAddonScoreboard:MakePopup() -- comment il va apparaitre
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