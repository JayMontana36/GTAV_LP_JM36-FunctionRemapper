if not JM36_GTAV_LuaPlugin_Version or JM36_GTAV_LuaPlugin_Version < 5.3 then
	error("You are attempting to use an incompatible or an outdated version of Lua Plugin with Function (Re)Mapper; please update to the latest version of JM36 GTAV Lua Plugin first - https://github.com/JayMontana36/LuaPlugin-GTAV/releases")
	return
else
	local _G, _G2 = _G, _G2



	local lfs_dir, string_endsWith, pcall, require, string_gsub, type, print, pairs
		= lfs.dir, string.endsWith, pcall, require, string.gsub, type, print, pairs
	local Successful, FileName
	local FunctionsReplaced = {}
	for File in lfs_dir(Scripts_Path.."0_FunctionRemapper\\") do
		if string_endsWith(File, ".lua") then
			FileName = string_gsub(File, ".lua", "")
			Successful, File = pcall(require, "0_FunctionRemapper\\"..FileName)
			if Successful then
				if type(File)=="function" then
					FunctionsReplaced[FileName] = _G[FileName]
					_G2[FileName] = File
				end
			else
				print(File)
			end
		elseif string_endsWith(File, ".ini") then
			local FunctionsToRemap = configFileRead("0_FunctionRemapper\\"..File)
			for k,v in pairs(FunctionsToRemap) do
				_G2[k] = _G[v]
			end
			FunctionsToRemap = nil
		end
	end
	Successful, FileName = nil, nil



	_G2.JM36_GTAV_LuaPlugin_FunctionRemapper_Version = 20210909.001



	return {
		stop	=	function()
						if JM36_GTAV_LuaPlugin_FunctionRemapper_Version then
							local unrequire = unrequire
							for k,v in pairs(FunctionsReplaced) do
								_G2[k] = FunctionsReplaced[v]
								unrequire(k)
							end
							FunctionsReplaced = nil
							
							_G2.JM36_GTAV_LuaPlugin_FunctionRemapper_Version = nil
						end
					end
	}
end