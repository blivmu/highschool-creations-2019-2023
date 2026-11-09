local Tool = script.Parent
local ClickEvent = Tool.ClickEvent
local ClickConnect
local Barrel = Tool.Barrel
local ShotSFX = Barrel.FiringNoise
local Handle = Tool.Handle

local Allowed = true

local YOURDEADSFX

local function FireGun(Player, Location, Firing)
	if Allowed and Tool.Parent == Player.Character and Player.Character.Humanoid.Health > 0 then
		Allowed = false
		if Firing == 1 then
			
			YOURDEADSFX = Instance.new("Sound", Barrel)
			YOURDEADSFX.Volume = 1
			YOURDEADSFX.SoundId = "rbxassetid://8125594257"

			YOURDEADSFX:Play()
			
		elseif Firing == 3 then
			
			YOURDEADSFX:Destroy()
			
		end
		
		for i = 1, 5 do
			
			local Human = Player.Character.Humanoid
			local ShootAnim = Instance.new("Animation")
			ShootAnim.AnimationId = "rbxassetid://657402291"
			local ShootTrack = Human:LoadAnimation(ShootAnim)
			
			ShootTrack:Play()
			
			local Found = Human.Torso.CFrame:toWorldSpace(CFrame.new(0, 1, -7))
			
			local Bullet = Instance.new("Part", workspace)
			game:GetService("Debris"):AddItem(Bullet, 8)
			Bullet.Material = "Neon"
			Bullet.BrickColor = BrickColor.Random()
			Bullet.Size = Vector3.new(.14, .2, .86)
			Bullet.CanCollide = false
			Bullet.CFrame = Found
			
			local M = Instance.new("SpecialMesh", Bullet)
			M.MeshType = "Sphere"
			M.Scale = Vector3.new(50, 50, 50)
			
			local TargetPosition = Location.p
			local LookDirection = (TargetPosition - Bullet.Position).unit
			
			local CarryForce = Instance.new("BodyForce", Bullet)
			CarryForce.Force = Vector3.new(0, Bullet:GetMass() * 196.1, 0)
			
			Bullet.Velocity = LookDirection * 100
			
			local function BulletHit(Part)
				local Character = Part.Parent
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					if Humanoid.Health > 0 and Part.Parent ~= Player.Character then
	
						Humanoid:TakeDamage(1000)
						Humanoid.PlatformStand = true
						
						local HitCF = Bullet.CFrame
						local ExplosionPart = Bullet
						local Explosion = Instance.new("Explosion",game.Workspace)
						Explosion.ExplosionType = Enum.ExplosionType.NoCraters
						Explosion.DestroyJointRadiusPercent = 0
						Explosion.BlastPressure = 0
					
						Explosion.Position = ExplosionPart.Position
						Bullet:Destroy()
						
						local SearchSFX = Character.Torso:FindFirstChild("Flying")
						
						if not SearchSFX then
							
							local HitNoise = Instance.new("Sound", Character.Torso)
							HitNoise.Name = "Flying"
							game:GetService("Debris"):AddItem(HitNoise, 10)
							HitNoise.SoundId = "rbxassetid://8125594257"
							HitNoise.MaxDistance = 3000
							HitNoise.Volume = 1
							HitNoise.TimePosition = 23
							
							
							HitNoise:Play()
						
						end
						
						local Spaz = Instance.new("BodyAngularVelocity", Character.Torso)
						game:GetService("Debris"):AddItem(Spaz, 1)
						Spaz.AngularVelocity = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
						Spaz.MaxTorque = Vector3.new(200, 200, 200)
						
						Humanoid.Torso.CFrame = Humanoid.Torso.CFrame:toWorldSpace(CFrame.Angles(math.rad(90), 0, 0))		
						Humanoid.Torso.Velocity = Vector3.new(math.random(-10, 10), math.random(0, 20), math.random(-10, 10))			
						
						wait(5)		
						
						Humanoid.PlatformStand = false			
						
					end
					
					
				else
					if not Humanoid and Character ~= Tool and Part.CanCollide == true then
						
						local HitCF = Bullet.CFrame
						Bullet:Destroy()
						
					end
				end
			end
			
			Bullet.Touched:connect(BulletHit)
			
		end
		wait(4)
		Allowed = true
	end
end

local function Equip()
	
	ClickConnect = ClickEvent.OnServerEvent:connect(FireGun)
	
end

local function Unequip()
	
	ClickConnect:disconnect()	
	
end

Tool.Equipped:connect(Equip)
Tool.Unequipped:connect(Unequip)
