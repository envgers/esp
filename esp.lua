local utility =  {}
local objects = {}
local esp = {}
--//
local ws = game:GetService("Workspace")
local players = ws:FindFirstChild("Players")
local userinput = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local team = ""
--//
function utility:new(type,properties)
    local object = Instance.new(type)
    for _,v in pairs(properties) do
        object[_] = v
    end
    table.insert(objects,object)
    return object
end
--//
function esp:createchams(character)
    if game:FindFirstChild(character) then
        for _,v in pairs(character:GetChildren()) do
            if settings.Visible == true then
                if v.Name == "Head" then
                    local external = utility:new("CylinderHandleAdornment",
                        {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.ExternalColor,ZIndex = 10,CFrame = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0),SizeRelativeOffset = Vector3.new(0, 0.20000000298023, 0),Height = 1.3,Radius = 0.8,Adornee = v,Parent =  v,AlwaysOnTop = false}
                    )
                    --//
                    local internal  = utility:new("CylinderHandleAdornment", 
                        {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.InternalColor,ZIndex = 9,CFrame = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0),AlwaysOnTop = true,SizeRelativeOffset = Vector3.new(0, 0.10000000149012, 0),Height = 1.1,Radius = 0.67,Adornee = v,Parent = v}
                    )
                elseif v.Name:match("Leg") or v.Name:match("Arm") then
                    local external2 = utility:new("BoxHandleAdornment",
                        {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.ExternalColor,ZIndex = 10,Size = Vector3.new(1.01,2.01,1.01),Adornee = v,Parent = v,AlwaysOnTop = false}
                    )
                    --//
                    local internal2 = utility:new("BoxHandleAdornment",
                        {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.InternalColor,ZIndex = 9,AlwaysOnTop = true,Size = Vector3.new(0.8,1.81,0.8),Adornee = v,Parent = v}
                    )
                elseif v.Name == "Torso" then
                    local external2 = utility:new("BoxHandleAdornment",
                        {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.ExternalColor,ZIndex = 10,Size = Vector3.new(2.01,2.01,1.01),Adornee = v,Parent = v,AlwaysOnTop = false}
                    )
                    --//
                    local internal2 = utility:new("BoxHandleAdornment",
                        {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.InternalColor,ZIndex = 9,AlwaysOnTop = true,Size = Vector3.new(1.8,1.8,0.8),Adornee = v,Parent = v}
                    )
                end
            else
                if v.Name == "Head" then
                    local external = utility:new("CylinderHandleAdornment",
                        {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.ExternalColor,ZIndex = 10,CFrame = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0),SizeRelativeOffset = Vector3.new(0, 0.20000000298023, 0),Height = 1.3,Radius = 0.8,Adornee = v,Parent =  v,AlwaysOnTop = true}
                    )
                    --//
                    local internal  = utility:new("CylinderHandleAdornment", 
                        {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.InternalColor,ZIndex = 9,CFrame = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0),AlwaysOnTop = false,SizeRelativeOffset = Vector3.new(0, 0.10000000149012, 0),Height = 1.1,Radius = 0.67,Adornee = v,Parent = v}
                    )
                elseif v.Name:match("Leg") or v.Name:match("Arm") then
                    local external2 = utility:new("BoxHandleAdornment",
                        {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.ExternalColor,ZIndex = 10,Size = Vector3.new(1.01,2.01,1.01),Adornee = v,Parent = v,AlwaysOnTop = true}
                    )
                    --//
                    local internal2 = utility:new("BoxHandleAdornment",
                        {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.InternalColor,ZIndex = 9,AlwaysOnTop = false,Size = Vector3.new(0.8,2.01,0.8),Adornee = v,Parent = v}
                    )
                elseif v.Name == "Torso" then
                    local external2 = utility:new("BoxHandleAdornment",
                        {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.ExternalColor,ZIndex = 10,Size = Vector3.new(2.01,2.01,1.01),Adornee = v,Parent = v,AlwaysOnTop = true}
                    )
                    --//
                    local internal2 = utility:new("BoxHandleAdornment",
                        {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.InternalColor,ZIndex = 9,AlwaysOnTop = false,Size = Vector3.new(1.8,1.8,0.8),Adornee = v,Parent = v}
                    )
                end
            end
        end
    end
end
--//
team = tostring(game.Players.LocalPlayer.TeamColor)
game.Players.LocalPlayer.Changed:connect(function()
   team = tostring(game.Players.LocalPlayer.TeamColor)
end)

for _,v in next, players:GetChildren() do
    if v.Name ~= team then
        for i,x in next, v:GetDescendants() do
            if x:IsA("Model") and x.Name == "Player" then
                esp:createchams(x)
            end
        end
    end
    v.ChildAdded:connect(function(plr)
        if v.Name ~= team then
            wait(1)
            esp:createchams(plr)
        end
    end)
end
--//
game:GetService("UserInputService").InputBegan:connect(function(key)
    if key.KeyCode == Enum.KeyCode.End then
        if enabled == true then
            enabled = false
        else
            enabled = true
        end
    end
    for _,v in next, objects do
        if game:FindFirstChild(v) and enabled == false then
            v.Visible = false
        elseif game:FindFirstChild(v) and enabled == true then
            v.Visible = true
        end
    end
end)
