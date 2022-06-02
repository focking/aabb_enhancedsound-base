ES = {}

ES.List = {}

ES.BlackList = {
	["common/wpn_moveselect.wav"] = true,
	["common/wpn_select.wav"] = true,
	["common/wpn_hudoff.wav"] = true,
}

function ES.GetSurround(ent)
	
	local poss = ent:GetPos()  + Vector(0,0,64)
	
	local len = 512

	local hits = 0 
	local hitceilling = false 

	local tr = util.TraceLine({
		start = poss,
		endpos = poss + Vector(0,0,len),
		filter = ent,
	})

	if tr.HitWorld then hits = hits + 1 end 


	local tr = util.TraceLine({
		start = poss,
		endpos = poss + Vector(len,len,len),
		filter = ent,
	})

	if tr.HitWorld then hits = hits + 1 end 


	local tr = util.TraceLine({
		start = poss,
		endpos = poss + Vector(len,-len,len),
		filter = ent,
	})

	if tr.HitWorld then hits = hits + 1 end 


	local tr = util.TraceLine({
		start = poss,
		endpos = poss + Vector(-len,-len,len),
		filter = ent,
	})

	if tr.HitWorld then hits = hits + 1 end 


	local tr = util.TraceLine({
		start = poss,
		endpos = poss + Vector(-len,len,len),
		filter = ent,
	})			

	if tr.HitWorld then hits = hits + 1 end 

	return hits
end 

function ES.RemoveAll()
	table.remove(ES)
end 

function ES.AddSounds(name,folder)  -- Transformes folder with sounds into table 
	name = tostring(name)	

	if ES[name] then 
		print("ES: This folder is already in ES Table!")
	return end 

	ES.List[#ES.List+1] = name

	ES[name] = {}
	ES[name].dir = folder 
	ES[name].output = {}

	local files, directories = file.Find( folder.."*", "THIRDPARTY" )
	local fix_dir = string.Replace(folder, "sound/", "") -- Removing sound/ from path 

	for k,v in pairs(files) do 
		local fin = fix_dir..v
		ES[name].output[k] = fin 	
	end 

end

function ES.GetRandomSound(name) -- Return random sound form ES[name]
	name = tostring(name)

	if not ES[name] then 
	return end

	local output = table.Random(ES[name].output)
	return output
end

function ES.ReturnSurface(sound)
	if string.find(sound,"grass") then return "grass" end
	if string.find(sound,"concrete") then return "concrete" end
	if string.find(sound,"sand") then return "sand" end
	if string.find(sound,"dirt") then return "dirt" end
	if string.find(sound,"gravel") then return "gravel" end
	if string.find(sound,"mud") then return "mud" end
	if string.find(sound,"wood") then return "wood" end
	if string.find(sound,"metal") then return "metal" end
	if string.find(sound,"duct") then return "duct" end
	if string.find(sound,"tile") then return "tile" end
	if string.find(sound,"chain") then return "chain" end
	if string.find(sound,"slosh") then return "slosh" end
	if string.find(sound,"snow") then return "snow" end
	if string.find(sound,"plaster") then return "tile" end
end

if SERVER then 
	
	util.AddNetworkString("es_distant")

	function ES.DoDistantSound(position,str)
		net.Start("es_distant")
		net.WriteVector(position)
		net.WriteString(str)
		net.Send(player.GetAll())
	end

end