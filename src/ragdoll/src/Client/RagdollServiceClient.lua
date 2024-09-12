--[=[
	Initializes the RagdollService on the client.

	@client
	@class RagdollServiceClient
]=]

local require = require(script.Parent.loader).load(script)

local AttributeValue = require("AttributeValue")

local Players = game:GetService("Players")

local RagdollServiceClient = {}
RagdollServiceClient.ServiceName = "RagdollServiceClient"

--[=[
	Initializes the ragdoll service on the client. Should be done via [ServiceBag].
	@param serviceBag ServiceBag
]=]
function RagdollServiceClient:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")

	-- External
	self._serviceBag:GetService(require("Motor6DServiceClient"))
	self._serviceBag:GetService(require("CameraStackService"))

	-- Internal
	self._serviceBag:GetService(require("RagdollClient"))
	self._serviceBag:GetService(require("RagdollableClient"))
	self._serviceBag:GetService(require("RagdollHumanoidOnDeathClient"))
	self._serviceBag:GetService(require("RagdollHumanoidOnFallClient"))
	self._serviceBag:GetService(require("RagdollCameraShakeClient"))
	self._serviceBag:GetService(require("RagdollBindersClient"))

	self._screenShakeEnabled = AttributeValue.new(Players.LocalPlayer, "RagdollScreenShakeEnabled", true)
end

--[=[
	Sets screen shake enabled for the local player
	@param value boolelan
]=]
function RagdollServiceClient:SetScreenShakeEnabled(value)
	assert(type(value) == "boolean", "Bad value")

	self._screenShakeEnabled.Value = value
end

--[=[
	Returns wheher screenshake is enabled.
	@return boolean
]=]
function RagdollServiceClient:GetScreenShakeEnabled()
	assert(self._serviceBag, "Not initialized")

	return self._screenShakeEnabled.Value
end

return RagdollServiceClient