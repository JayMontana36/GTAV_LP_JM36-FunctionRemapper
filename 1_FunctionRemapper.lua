return {
	init	=	function()
					if not JM36_GTAV_LuaPlugin_Version or JM36_GTAV_LuaPlugin_Version < 5.1 then error("You are attempting to use an incompatible or an outdated version of Lua Plugin with Function (Re)Mapper; please update to the latest version of JM36 GTAV Lua Plugin first - https://github.com/JayMontana36/LuaPlugin-GTAV/releases") return end
					local FunctionsToRemap, _G, _G2 = configFileRead("1_FunctionRemapper.ini"), _G, _G2
					_G2.JM36_GTAV_LuaPlugin_FunctionRemapper_Version = 20210518.001
					local pairs = pairs
					for k,v in pairs(FunctionsToRemap) do
						_G2[k] = _G[v]
					end
				end
}