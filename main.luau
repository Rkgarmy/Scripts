local Settings = {
    JoinTeam = "Pirates"; -- Pirates / Marines
    Translator = true;    -- true / false
}

if Settings.JoinTeam == "Pirates" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
elseif Settings.JoinTeam == "Marines" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end

-- Simple AutoClick (for testing purpose)
while true do
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(0.5)
end
