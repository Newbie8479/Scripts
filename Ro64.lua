-- 라이브러리
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RunDTM/venyx-ui-lib-modified/main/librarymain.lua"))()

-- 기본
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer

-- 스크린
local Version = "1.1"

local venyx = library.new("Ro64", 6031302916)
local page = venyx:addPage("메인 스크립트", 6031082525)

local them = venyx:addPage("기타", 6031082525)

local setting = them:addSection("설정")
local editer = them:addSection("정보")
local updata = them:addSection("업데이트")

setting:addKeybind("창 토글", Enum.KeyCode.F1, function()
	venyx:toggle()
end)

editer:addButton("스크립트 제작자:Newbie0823")
editer:addButton("버전:"..Version)
editer:addButton("UI라이브러리:venyx-ui-lib-modified")

function AntiFling()
	local Services = setmetatable({}, {__index = function(Self, Index)
		local NewService = game.GetService(game, Index)
		if NewService then
			Self[Index] = NewService
		end
		return NewService
	end})

	local LocalPlayer = Services.Players.LocalPlayer

	local function PlayerAdded(Player)
		local Detected = false
		local Character;
		local PrimaryPart;

		local function CharacterAdded(NewCharacter)
			Character = NewCharacter
			repeat
				wait()
				PrimaryPart = NewCharacter:FindFirstChild("HumanoidRootPart")
			until PrimaryPart
			Detected = false
		end

		CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
		Player.CharacterAdded:Connect(CharacterAdded)
		local Pos = nil
		Services.RunService.Heartbeat:Connect(function()
			pcall(function ()
				if (Character and Character:IsDescendantOf(workspace)) and (PrimaryPart and PrimaryPart:IsDescendantOf(Character)) then
					if Character:FindFirstChild("HumanoidRootPart") then
						if Pos == nil then
							Pos = Character.HumanoidRootPart.Position
						end
						if not Character.HumanoidRootPart:FindFirstChildOfClass("Motor6D") then
							for i,v in ipairs(Character:GetChildren()) do
								if v:IsA("BasePart") then
									v.CanCollide = false
									v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
									v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
									v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
								end
							end
						end
						if (Character.HumanoidRootPart.Position - Pos).Magnitude > 15 then
							for i,v in ipairs(Character:GetChildren()) do
								if v:IsA("BasePart") then
									v.CanCollide = false
									v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
									v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
									v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
								end
							end
						end
					end
					--[[
					if Character:FindFirstChild("Humanoid") then
						if Character.Humanoid.SeatPart then
							local SeatPart = Character.Humanoid.SeatPart
							if SeatPart:FindFirstAncestorOfClass("Model") then
								for _, v in pairs(SeatPart:FindFirstAncestorOfClass("Model"):GetDescendants()) do
									if v:IsA("BasePart") then
										v.CanCollide = false
										v.Transparency = 0.5
									end
								end
							end
						end
					else
						return
					end
					]]
					for i,v in ipairs(Character:GetChildren()) do
						if v:IsA("BasePart") then
							if v.AssemblyAngularVelocity.Magnitude > 50 or v.AssemblyLinearVelocity.Magnitude > 100 then
								v.CanCollide = false
								v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
							end
						end
						if v:IsA("Accessory") then
							if v:FindFirstChildOfClass("BasePart") then
								local vh = v:FindFirstChildOfClass("BasePart")
								if (vh.Position - vh.Parent.AttachmentPoint.Position).Magnitude > 0 then
									v:Destroy()
								end
							end
						end
						if Character.Humanoid.Health == 0 then
							if v:IsA("BasePart") then
								v.CanCollide = false
								v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
							end
							if v:IsA("Accessory") then
								if v:FindFirstChildOfClass("BasePart") then
									local vh = v:FindFirstChildOfClass("BasePart")
									if (vh.Position - vh.Parent.AttachmentPoint.Position).Magnitude ~= 0 then
										v:Destroy()
									end
								end
							end
							if v:IsA("Weld") then
								v:Destroy()
							end
						end
					end
					if Character:FindFirstChild("HumanoidRootPart") then
						Pos = Character.HumanoidRootPart.Position
					end
				end
			end)
		end)
	end

	for i,v in ipairs(Services.Players:GetPlayers()) do
		if v ~= LocalPlayer then
			PlayerAdded(v)
		end
	end
	Services.Players.PlayerAdded:Connect(PlayerAdded)

	local LastPosition = nil
	Services.RunService.Heartbeat:Connect(function()
		pcall(function()
			local PrimaryPart = LocalPlayer.Character.PrimaryPart
			if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
				PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
				PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				PrimaryPart.CFrame = LastPosition

				game.StarterGui:SetCore("ChatMakeSystemMessage", {
					Text = "당신은 날라가고 있습니다, 캐릭터 속도를 재설정 합니다.";
					Color = Color3.fromRGB(255, 0, 0);
				})
			elseif PrimaryPart.AssemblyLinearVelocity.Magnitude < 50 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 then
				LastPosition = PrimaryPart.CFrame
			end
		end)
	end)
end

updata:addButton("스핀핵 방지 재실행", function()
	spawn(AntiFling)
end)

local loadscript = {
	[5720801512] = {
		Name = "한국 머더",
		LOADSCRIPT = function()
			local section1 = page:addSection("게임")
			local section2 = page:addSection("플레이어")
			local section3 = page:addSection("구매")

			local esp = false
			local TargetPlayer = nil
			local TargetBox = nil

			local PlayerList = {}
			local PlayerListId = {}

			local BoxList = {}

			for i,name in pairs(game:GetService("ReplicatedStorage").ShopEntries.KnifeSkins.Boxes:GetChildren()) do
				BoxList[name.Name] = name.Name
			end

			spawn(function()
				while RunService.RenderStepped:Wait() do
					for i,player in pairs(game.Players:GetPlayers()) do
						if not PlayerList[player.Name] then
							if player.DisplayName == player.Name then
								PlayerList[player.Name] = player.Name
								if not PlayerListId[player.Name] then
									PlayerListId[player.Name] = player.UserId
								end
							else
								PlayerList[player.DisplayName .. "(@" .. player.Name .. ")"] = player.DisplayName .. "(@" .. player.Name .. ")"
								if not PlayerListId[player.DisplayName .. "(@" .. player.Name .. ")"] then
									PlayerListId[player.DisplayName .. "(@" .. player.Name .. ")"] = player.UserId
								end
							end
						end
					end
					for i,name in pairs(PlayerList) do
						if PlayerListId[name] then
							local Id = game.Players:GetPlayerByUserId(PlayerListId[name])
							if Id == nil then
								PlayerList[name] = nil
								PlayerListId[name] = nil
							end
						end
					end
				end
			end)

			local function Kill(tp)
				if tp == nil then return end
				if tp.Character == nil then return end
				if Player.Character == nil then return end
				if Player.Character:FindFirstChild("Knife") then
					local args = {
						[1] = tp.Character.HumanoidRootPart
					}

					Player.Character.Knife.KnifeScript.HitPlayer:FireServer(unpack(args))
				end
				if Player.Character:FindFirstChild("Revolver") then
					-- Script generated by SimpleSpy - credits to exx#9394

					local args = {
						[1] = Player.Character.Revolver:FindFirstChildOfClass("Part").Position --[[Vector3]],
						[2] = tp.Character.HumanoidRootPart,
						[3] = tp.Character.HumanoidRootPart.Position --[[Vector3]]
					}

					Player.Character.Revolver.RevolverScript.ClientLeftDown:FireServer(unpack(args))
				end
			end

			section1:addToggle("투시", nil, function(bool)
				esp = bool
				if esp then
					spawn(function()
						while esp do
							pcall(function()
								for _, v in pairs(game.Players:GetPlayers()) do
									if v.Character == nil then return end
									v.Character.HumanoidRootPart.Transparency = 0
									if v.Character:FindFirstChildOfClass("Highlight") then else
										local Highlight = Instance.new("Highlight")
										Highlight.Parent = v.Character
										Highlight.OutlineTransparency = 1
										Highlight.FillColor = Color3.fromRGB(0,255,0)
									end
									local Highlight = v.Character:FindFirstChildOfClass("Highlight")
									if v:FindFirstChildWhichIsA("Backpack"):FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
										Highlight.FillColor = Color3.fromRGB(255,0,0)
									elseif v:FindFirstChildWhichIsA("Backpack"):FindFirstChild("Revolver") or v.Character:FindFirstChild("Revolver") then
										Highlight.FillColor = Color3.fromRGB(0,0,255)
									else
										Highlight.FillColor = Color3.fromRGB(0,255,0)
									end
								end
							end)
							RunService.RenderStepped:Wait()
						end
					end)
				else
					for _, v in pairs(game.Players:GetPlayers()) do
						if v.Character:FindFirstChildOfClass("Highlight") then
							v.Character.HumanoidRootPart.Transparency = 1
							v.Character:FindFirstChildOfClass("Highlight"):Destroy()
						end
					end
				end
			end)
			section1:addButton("떨어진 총 줍기", function()
				if game.Workspace:FindFirstChild("RevolverPickUp") then
					if Player.Character == nil then return end
					local Orb = game.Workspace:FindFirstChild("RevolverPickUp").Orb.CFrame
					local SaveCF = Player.Character.HumanoidRootPart.CFrame
					Player.Character.HumanoidRootPart.CFrame = Orb
					wait(0.05)
					Player.Character.HumanoidRootPart.CFrame = SaveCF
				end
			end)

			section1:addButton("모두 죽이기", function()
				for _, v in pairs(game.Players:GetPlayers()) do
					Kill(v)
				end 
			end)

			section2:addDropdown("플레이어 선택", PlayerList, function(isstring)
				local Id = PlayerListId[isstring]
				TargetPlayer = game.Players:GetPlayerByUserId(Id)
			end)

			section2:addButton("목표:머더", function()
				pcall(function()
					for _, v in pairs(game.Players:GetPlayers()) do
						if v.Character == nil then return end
						if v:FindFirstChildWhichIsA("Backpack"):FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
							TargetPlayer = v
						end
					end
				end)
			end)

			section2:addButton("목표:경찰", function()
				pcall(function()
					for _, v in pairs(game.Players:GetPlayers()) do
						if v.Character == nil then return end
						if v:FindFirstChildWhichIsA("Backpack"):FindFirstChild("Revolver") or v.Character:FindFirstChild("Revolver") then
							TargetPlayer = v
						end
					end
				end)
			end)

			section2:addButton("목표 죽이기", function()
				Kill(TargetPlayer)
			end)

			section2:addKeybind("키 입력시/목표 죽이기", Enum.KeyCode.E, function() -- 키 입력 인식
				Kill(TargetPlayer)
			end)

			section3:addDropdown("박스 선택", BoxList, function(box)
				TargetBox = box
			end)

			local function BuyBox(name)
				local args = {
					[1] = game:GetService("ReplicatedStorage").ShopEntries.KnifeSkins.Boxes[name]
				}

				game:GetService("ReplicatedStorage").Interactions.Server.BuyShopItem:InvokeServer(unpack(args))
			end

			section3:addButton("선택한 박스 구매", function()
				BuyBox(TargetBox)
			end)
		end,
	},
	[3952704772] = {
		Name = "운테르 게임",
		LOADSCRIPT = function()
			spawn(AntiFling)
			_G.StopRadios = false
			_G.AutoGetP1 = false
			spawn(function()
				while wait() do
					if _G.StopRadios == true then
						for i,v in pairs(game.Players:GetPlayers()) do
							if v.Character then
								if v.Character:FindFirstChild("radio") then 
									if v.Character:FindFirstChild("radio"):FindFirstChild("Handle") then
										v.Character:FindFirstChild("radio").Handle.Sound.Volume = 0 
									end
								end
								if v.Character:FindFirstChild("radio") then 
									if v.Character:FindFirstChild("radio"):FindFirstChild("Handle") then
										v.Character:FindFirstChild("radio").Handle.Sound.Volume = 0 
									end
								end
							end
						end
					end
					wait(0.1)
				end
			end)
			local function Boombox()
				if _G.StopRadios == false then
					for i,v in pairs(game.Players:GetPlayers()) do
						if v.Character then
							if v.Character:FindFirstChild("radio") then 
								if v.Character:FindFirstChild("radio"):FindFirstChild("Handle") then
									v.Character:FindFirstChild("radio").Handle.Sound.Volume = 0.5
								end
							end
							if v.Character:FindFirstChild("radio") then 
								if v.Character:FindFirstChild("radio"):FindFirstChild("Handle") then
									v.Character:FindFirstChild("radio").Handle.Sound.Volume = 0.5
								end
							end
						end
					end
				end
			end
			local GetBasePart = nil
			local SaveBasePartCF = Vector3.new(0, 0, 0)
			local SaveBasePartSize = Vector3.new(0, 0, 0)
			local function AutoGet()
				if _G.AutoGetP1 == true then
					if GetBasePart == nil then
						for _, v in pairs(game.Workspace:GetChildren()) do
							if v:IsA("Part") and v:FindFirstChildOfClass("Sound") and v:FindFirstChildOfClass("Script") and v:FindFirstChildOfClass("MeshPart") then
								GetBasePart = v
								SaveBasePartCF = v.CFrame
								SaveBasePartSize = v.Size
							end
						end
					end
					if GetBasePart then
						while _G.AutoGetP1 do
							if GetBasePart:FindFirstChild("TouchInterest") then
								if Player.Character ~= nil then
									if Player.Character:FindFirstChild("HumanoidRootPart") then
										GetBasePart.Size = Vector3.new(7, 7, 7)
										GetBasePart.CFrame = Player.Character.HumanoidRootPart.CFrame
										wait(0.1)
										GetBasePart.Size = SaveBasePartSize
										GetBasePart.CFrame = SaveBasePartCF
									end
								end
							end
							wait()
						end
					else
						_G.AutoGetP1 = false
					end
				else
					GetBasePart.Size = SaveBasePartSize
					GetBasePart.CFrame = SaveBasePartCF
				end
			end
			local section1 = page:addSection("게임")
			local section2 = page:addSection("플레이어")

			local PlayerList = {}
			local PlayerListId = {}

			local TargetPlayer = nil

			spawn(function()
				while RunService.RenderStepped:Wait() do
					for i,player in pairs(game.Players:GetPlayers()) do
						if not PlayerList[player.Name] then
							if player.DisplayName == player.Name then
								PlayerList[player.Name] = player.Name
								if not PlayerListId[player.Name] then
									PlayerListId[player.Name] = player.UserId
								end
							else
								PlayerList[player.DisplayName .. "(@" .. player.Name .. ")"] = player.DisplayName .. "(@" .. player.Name .. ")"
								if not PlayerListId[player.DisplayName .. "(@" .. player.Name .. ")"] then
									PlayerListId[player.DisplayName .. "(@" .. player.Name .. ")"] = player.UserId
								end
							end
						end
					end
					for i,name in pairs(PlayerList) do
						if PlayerListId[name] then
							local Id = game.Players:GetPlayerByUserId(PlayerListId[name])
							if Id == nil then
								PlayerList[name] = nil
								PlayerListId[name] = nil
							end
						end
					end
				end
			end)

			section1:addToggle("붐박스", nil, function(bool)
				_G.StopRadios = bool
				Boombox()
			end)

			section1:addToggle("총 자동 획득", nil, function(bool)
				_G.AutoGetP1 = bool
				AutoGet()
			end)

			local function Kill(tp)
				if tp == nil then return end
				if tp.Character == nil then return end
				if Player.Character == nil then return end
				local Get = {}
				local OkII = 1
				for i, v in pairs(game.Players:GetPlayers()) do
					for _, v2 in pairs(v.Backpack:GetChildren()) do
						if v2.Name==("P1") or v2.Name==("pistol") or v2.Name==("Pistol") or v2.Name==("P") then
							local Find = v2
							Get[OkII] = {Parent=Find.Parent,Obj=Find}
							OkII += 1
						end
					end
					if v.Character ~= nil then
						for _, v2 in pairs(v.Character:GetChildren()) do
							if v2.Name==("P1") or v2.Name==("pistol") or v2.Name==("Pistol") or v2.Name==("P") then
								local Find = v2
								Get[OkII] = {Parent=Find.Parent,Obj=Find}
								OkII += 1
							end
						end
					end
				end
				if #Get >= 1 then
					for _, v in pairs(Get) do
						v.Obj.Parent = Player.Backpack
						v.Obj.RemoteEvent:FireServer(tp.Character.Humanoid)
						wait(0.1)
						v.Obj.Parent = Get.Parent
						break
					end
				end
			end

			section2:addDropdown("플레이어 선택", PlayerList, function(isstring)
				local Id = PlayerListId[isstring]
				TargetPlayer = game.Players:GetPlayerByUserId(Id)
			end)

			section2:addButton("목표 죽이기", function()
				Kill(TargetPlayer)
			end)

			section2:addKeybind("키 입력시/목표 죽이기", Enum.KeyCode.F, function() -- 키 입력 인식
				Kill(TargetPlayer)
			end)
		end,
	}
}

if loadscript[game.PlaceId] then
	loadscript[game.PlaceId].LOADSCRIPT()
	venyx:SelectPage(venyx.pages[1], true)
else
	venyx:Notify(Version,"Ro64가 게임을 찾지 못했습니다..")
end
