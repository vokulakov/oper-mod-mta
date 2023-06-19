local Vehicles = {}

Vehicles.Names = {

	[421] = 'Audi A7',
	[529] = 'Audi A8 D2',
	[550] = 'Audi RS6',
	[603] = 'Audi RS5',

	[401] = 'Toyota Camry V70',
	[438] = 'Toyota Land Cruiser 200',
	[507] = 'Toyota Camry V40',
	[540] = 'Toyota Camry V55',

	[470] = 'BMW X5M E70',
	[494] = 'BMW M4 Coupe',
	[503] = 'BMW M8 Competition',
	[560] = 'BMW M5 F90',
	[561] = 'BMW 740LE',
	[458] = 'BMW 5 E34',
	[404] = 'BMW 730i E38',
	[527] = 'BMW 3 G20',

	[516] = 'Lexus LX570',
	[405] = 'Hyundai Sonata Turbo',
	[429] = 'Škoda Octavia A7',
	[554] = 'Cadillac Escalade',
	[543] = 'Bentley Bantyaga',
	[422] = 'Lamborghini Urus',
	[505] = 'Chevrolet Tahoe',
	[566] = 'Porsche Panamera Turbo',
	[599] = 'Range Rover SV Autobiography',
	[400] = 'Volkswagen Touareg',
	[604] = 'Volkswagen Passat B8',
	[587] = 'Rolls Royce Cullinan',
	[427] = 'Land Rover Range Rover',
	[602] = 'Honda Accord',
	[562] = 'Mitsubishi Lancer Evolution X',

	[456] = 'UAZ Patriot',
	[412] = 'ЗАЗ-968м',
	[576] = 'ГАЗ-3102 "Волга"',
	[585] = 'Lada Vesta Sport',
	[559] = 'Lada Vesta SW Cross',
	[492] = 'Lada Priora (ВАЗ-2170)',
	[605] = 'Lada Kalina 2',
	[466] = 'ВАЗ 2109',
	[436] = 'Lada Granta седан',
	[526] = 'Lada Priora (ВАЗ-2172)',
	[518] = 'ВАЗ 2101',
	[546] = 'ВАЗ 2110',
	[491] = 'ВАЗ 21099',
	[467] = 'ВАЗ 2107',
	[547] = 'ВАЗ 2114',
	[542] = 'ВАЗ 2106',
	[567] = 'ВАЗ 2105',

	[409] = 'Mercedes-Benz Maybach s600',
	[490] = 'Mercedes-Benz G55 AMG',
	[579] = 'Mercedes-Benz G63 AMG',
	[420] = 'Mercedes-Benz GT63s',
	[489] = 'Mercedes-Benz GL63 AMG',
	[474] = 'Mercedes-Benz GLS Coupe 2019',
	[445] = 'Mercedes-Benz s500 W222',
	[442] = 'Mercedes-Benz S65 W221 AMG',
	[479] = 'Mercedes-Benz CLS63 AMG',
	[580] = 'Mercedes-Benz E55 AMG',
	[551] = 'Mercedes-Benz E500 W124',
	[426] = 'Mercedes-Benz 500 SE W140',
	[418] = 'Mercedes-Benz E63s W213 AMG',
	[598] = 'Mercedes-Benz C63S AMG W205',
	[535] = 'Mercedes-Benz E200 W212',

}

Vehicles.List = {

	['Отечественные'] = {
		['Российский автопром'] = {
			['УАЗ'] = {
				{id = 456, name = Vehicles.Names[456]}
			},

			['Lada (ВАЗ)'] = {
				{id = 518, name = Vehicles.Names[518]},
				{id = 567, name = Vehicles.Names[567]},
				{id = 542, name = Vehicles.Names[542]},
				{id = 467, name = Vehicles.Names[467]},
				{id = 466, name = Vehicles.Names[466]},
				{id = 546, name = Vehicles.Names[546]},
				{id = 491, name = Vehicles.Names[491]},
				{id = 547, name = Vehicles.Names[547]},
				{id = 492, name = Vehicles.Names[492]},
				{id = 526, name = Vehicles.Names[526]},
				{id = 436, name = Vehicles.Names[436]},
				{id = 605, name = Vehicles.Names[605]},
				{id = 585, name = Vehicles.Names[585]},
				{id = 559, name = Vehicles.Names[559]}
			},

			['ГАЗ'] = {
				{id = 576, name = Vehicles.Names[576]}
			}
		},

		['Советский автопром'] = {
			['ЗАЗ'] = {
				{id = 412, name = Vehicles.Names[412]}
			}
		}
	},

	['Иномарки'] = {
		['Немецкий автопром'] = {

			['Mercedes-Benz'] = {
				{id = 598, name = Vehicles.Names[598]},
				{id = 479, name = Vehicles.Names[479]},
				{id = 535, name = Vehicles.Names[535]},
				{id = 580, name = Vehicles.Names[580]},
				{id = 551, name = Vehicles.Names[551]},
				{id = 418, name = Vehicles.Names[418]},
				{id = 426, name = Vehicles.Names[426]},
				{id = 445, name = Vehicles.Names[445]},
				{id = 442, name = Vehicles.Names[442]},
				{id = 420, name = Vehicles.Names[420]},
				{id = 489, name = Vehicles.Names[489]},
				{id = 474, name = Vehicles.Names[474]},
				{id = 490, name = Vehicles.Names[490]},
				{id = 579, name = Vehicles.Names[579]},
				{id = 409, name = Vehicles.Names[409]}
			},

			['BMW'] = {
				{id = 527, name = Vehicles.Names[527]},
				{id = 458, name = Vehicles.Names[458]},
				{id = 404, name = Vehicles.Names[404]},
				{id = 494, name = Vehicles.Names[494]},
				{id = 560, name = Vehicles.Names[560]},
				{id = 503, name = Vehicles.Names[503]},
				{id = 470, name = Vehicles.Names[470]},
				{id = 561, name = Vehicles.Names[561]}
			},

			['AUDI'] = {
				{id = 529, name = Vehicles.Names[529]},
				{id = 421, name = Vehicles.Names[421]},	
				{id = 603, name = Vehicles.Names[603]},		
				{id = 550, name = Vehicles.Names[550]}	
			},

			['Porsche'] = {
				{id = 566, name = Vehicles.Names[566]}	
			},

			['Volkswagen'] = {
				{id = 604, name = Vehicles.Names[604]},
				{id = 400, name = Vehicles.Names[400]}
			}
		},

		['Японский автопром'] = {
			['Toyota'] = {
				{id = 507, name = Vehicles.Names[507]},	
				{id = 540, name = Vehicles.Names[540]},
				{id = 401, name = Vehicles.Names[401]},
				{id = 438, name = Vehicles.Names[438]}
			},

			['Lexus'] = {
				{id = 516, name = Vehicles.Names[516]}
			},

			['Honda'] = {
				{id = 602, name = Vehicles.Names[602]}
			},

			['Mitsubishi'] = {
				{id = 562, name = Vehicles.Names[562]}
			}
		},

		['США'] = {
			['Chevrolet'] = {
				{id = 505, name = Vehicles.Names[505]}
			},

			['Cadillac'] = {
				{id = 554, name = Vehicles.Names[554]}
			}
		},

		['Великобритания'] = {
			['Bentley'] = {
				{id = 543, name = Vehicles.Names[543]}
			},

			['Rolls Royce'] = {
				{id = 587, name = Vehicles.Names[587]}
			},

			['Land Rover'] = {
				{id = 427, name = Vehicles.Names[427]},
				{id = 599, name = Vehicles.Names[599]}
			}
		},

		['Италия'] = {
			['Lamborghini'] = {
				{id = 422, name = Vehicles.Names[422]}
			}
		},

		['Южная Корея'] = {
			['Hyundai'] = {
				{id = 405, name = Vehicles.Names[405]}
			}
		},

		['Чехия'] = {
			['Škoda'] = {
				{id = 429, name = Vehicles.Names[429]}
			}
		}
	}

}

function getVehiclesList()
	return Vehicles.List
end

function getVehiclesNameList()
	return Vehicles.Names
end