net.Receive("es_distant", function()
	local pos = net.ReadVector()
	local sound = net.ReadString()
	ES.PlayDistantSound(pos,sound)
end)

net.Receive("es_distant_act3", function()
	local pos = net.ReadVector()
	ES.PlayDistantSoundACT3(pos)
end)

function ES.PlayDistantSound(pos,str)
	if str != "" then 
		local pitch = math.random(90,100) 
		local position = LocalPlayer():GetPos() - (LocalPlayer():GetPos() - pos) / 10

		sound.Play("#"..str, position, 160, pitch)
	return end 
end



function ES.PlayDistantSoundACT3(pos)

	local pitch = math.random(90,100) 
	local position = LocalPlayer():GetPos() - (LocalPlayer():GetPos() - pos) / 10

	sound.Play("#".."distant_generic.wav", position, 160, pitch)
end