-- Helper physics script for the bhop movement after a Roblox Studio update broke the first one
-- Made to replicate CS:GO's movement physics

-- Written by Blivmu May 2021

local player = game.Players.LocalPlayer
local character = player.Character

local humanoid = character:WaitForChild("Humanoid")::Humanoid
local rootpart = character:WaitForChild("HumanoidRootPart")::Part

local cam = workspace.CurrentCamera

local maxSpeed = 12
local runSpeed =35

local groundAccel = 16
local groundDecel = 12
local airAccel = 10000000

local playerVelocity = Vector3.zero

local runService = game:GetService("RunService")
local contextAction = game:GetService("ContextActionService")

local linearVelocity = Instance.new("LinearVelocity",rootpart)
linearVelocity.Attachment0 = rootpart:WaitForChild("RootAttachment")
linearVelocity.MaxForce = 25500
linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
linearVelocity.PrimaryTangentAxis = Vector3.new(1,0,0)
linearVelocity.SecondaryTangentAxis = Vector3.new(0,0,1)

function Move(dir,speed,rate1,rate2)
	
	local currentVel = playerVelocity
	local targetSpeed = dir*speed
	local add = (targetSpeed-currentVel)
	local rate = if currentVel.Magnitude < speed or dir.Magnitude > 0 then rate1 else rate2
	
	playerVelocity+= add*rate*runService.Heartbeat:Wait()
	
end

function AirMove(wishDir,wishSpeed,accel)
	local currentVel = playerVelocity:Dot(wishDir)
	local add = wishSpeed-currentVel
	if add <= 0 then
		return
	end
	local rate = add*runService.Heartbeat:Wait()*wishSpeed
	rate = math.clamp(rate,-.001,add)
	
	playerVelocity+=rate*wishDir
end

connection = runService.RenderStepped:Connect(function(dt)
	
	for _,v in pairs(character:GetChildren()) do
		if v:IsA("BasePart") then
			v.CustomPhysicalProperties = PhysicalProperties.new(.7,0,0,100,100)
		end
	end
	
	humanoid.WalkSpeed = runSpeed
	humanoid.UseJumpPower = true
	
	local grounded = humanoid:GetState() ~= Enum.HumanoidStateType.Freefall
	
	if grounded and not humanoid.Jump then

		Move(humanoid.MoveDirection,runSpeed,groundAccel,groundDecel)

	else
		
		AirMove(humanoid.MoveDirection,maxSpeed,airAccel)
		
	end

	if not (humanoid:GetState() == Enum.HumanoidStateType.Climbing) then
		linearVelocity.PlaneVelocity = Vector2.new(playerVelocity.X,playerVelocity.Z)
	else
		linearVelocity.PlaneVelocity = Vector2.zero
	end
end)

while true do wait()
	local grounded = humanoid:GetState() ~= Enum.HumanoidStateType.Freefall
	
	if grounded and downShifted then
		wait(.75)
		downShifted = false
	end
	
end

diedCon = humanoid.Died:Connect(function()
	connection:Disconnect()
	diedCon:Disconnect()
end)
