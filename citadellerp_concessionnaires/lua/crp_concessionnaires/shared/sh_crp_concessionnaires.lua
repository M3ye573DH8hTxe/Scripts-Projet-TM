CitadelleRP = CitadelleRP or {}
CitadelleRP.Concessionnaires = CitadelleRP.Concessionnaires or {}
CitadelleRP.Concessionnaires.Config = CitadelleRP.Concessionnaires.Config or {}

CitadelleRP.Concessionnaires.Config.List = {
    [1] = {
        Name = "Concessionnaire - Police",
		Model = "models/smalls_civilians/pack1/hoodie_male_02_pm.mdl",
		spawnPnj = {
			
			position = Vector( 702.610168, -292.247009, -139.777206 ),
			angles = Angle( 0.000, 66.375, 0.000 ),
			
		},
		spawnVehicle = {

			position = Vector( 451.682526, -183.285400, -143.431091 ),
			angles = Angle( 0.141, 66.454, 0.155 ),
			
		},
        check = function(ply) return CLIENT or ply:isCP() end,
        Vehicles = {

	        [1]	= {

				Name = "Renault Megane RS",
		        Model = "models/lonewolfie/ren_meganers.mdl",
		        Class = "ren_meganers_lw",
		        ClassName = "Renault Megane RS Police Nationale",
		        Skin = 11,
		        job = {
		        	["Agent de Police"] = true,

		        }
			},

			[2]	= {

				Name = "Mercedes Sprinter",
		        Model = "models/lonewolfie/merc_sprinter_swb.mdl",
		        Class = "merc_sprinter_swb_lw",
		        ClassName = "Mercedes Sprinter Police Nationale",
		        Skin = nil,
		        job = {
		        	["Agent de Police"] = true,
		        }

			},

			[3]	= {

				Name = "Renault Master III",
		       	Model = "models/tdmcars/ford_transit.mdl",
		        Class = "renaultmaster_rytrak",
		        ClassName = "renault master police nationale",
		        Skin = 2,
		        job = {
		        	["Agent de Police"] = true,
		        }

			},

			[4]	= {

				Name = "Megane Sedan",
				Model = "models/azok30/renault_megane_4_sedan.mdl",
				Class = "azok30_renault_megane_4_sedan",
				ClassName = "Renault Megane Police Nationale",
				Skin = 9,
				job = {
					["Agent de Police"] = true,
				}

			},

			[5]	= {

				Name = "CC Uniquement - RS4",
				Model = "models/tdmcars/aud_rs4avant.mdl",
				Class = "rs4avanttdm",
				ClassName = "BAC Audi RS4",
				Skin = 0,
				job = {
					["Agent de la BAC"] = true,
				}

			},
        },
    },
}