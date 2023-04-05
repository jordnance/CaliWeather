class SettingsUtil {
  static const List<String> languages = [
    'English',
    'Spanish',
  ];
  static const List<String> units = [
    'Fahrenheit',
    'Celsius',
    'Kelvin',
  ];
  static const List<String> fontsize = [
    'Small',
    'Normal',
    'Large',
  ];
  static const List<String> alerts = [
    'API Related',
    'Water',
    'Energy',
  ];

  static const List<String> citySelection = [
    'Adelanto',
    'Agoura Hills',
    'Alameda',
    'Albany',
    'Alhambra',
    'Aliso Viejo',
    'Alturas',
    'Amador',
    'American Canyon',
    'Anaheim',
    'Anderson',
    'Angels Camp',
    'Antioch',
    'Apple Valley',
    'Arcadia',
    'Arcata',
    'Arroyo Grande',
    'Artesia',
    'Arvin',
    'Atascadero',
    'Atherton',
    'Atwater',
    'Auburn',
    'Avalon',
    'Avenal',
    'Azusa',
    'Bakersfield',
    'Baldwin Park',
    'Banning',
    'Barstow',
    'Beaumont',
    'Bell',
    'Bell Gardens',
    'Bellflower',
    'Belmont',
    'Belvedere',
    'Benicia',
    'Berkeley',
    'Beverly Hills',
    'Big Bear Lake',
    'Biggs',
    'Bishop',
    'Blue Lake',
    'Blythe',
    'Bradbury',
    'Brawley',
    'Brea',
    'Brentwood',
    'Brisbane',
    'Buellton',
    'Buena Park',
    'Burbank',
    'Burlingame',
    'Calabasas',
    'Calexico',
    'California City',
    'Calimesa',
    'Calipatria',
    'Calistoga',
    'Camarillo',
    'Campbell',
    'Canyon Lake',
    'Capitola',
    'Carlsbad',
    'Carmel-By-The-Sea',
    'Carpinteria',
    'Carson',
    'Cathedral City',
    'Ceres',
    'Cerritos',
    'Chico',
    'Chino',
    'Chino Hills',
    'Chowchilla',
    'Chula Vista',
    'Citrus Heights',
    'Claremont',
    'Clayton',
    'Clearlake',
    'Cloverdale',
    'Clovis',
    'Coachella',
    'Coalinga',
    'Colfax',
    'Colma',
    'Colton',
    'Colusa',
    'Commerce',
    'Compton',
    'Concord',
    'Corcoran',
    'Corning',
    'Corona',
    'Coronado',
    'Corte Madera',
    'Costa Mesa',
    'Cotati',
    'Covina',
    'Crescent City',
    'Cudahy',
    'Culver City',
    'Cupertino',
    'Cypress',
    'Daly City',
    'Dana Point',
    'Danville',
    'Davis',
    'Del Mar',
    'Del Rey Oaks',
    'Delano',
    'Desert Hot Springs',
    'Diamond Bar',
    'Dinuba',
    'Dixon',
    'Dorris',
    'Dos Palos',
    'Downey',
    'Duarte',
    'Dublin',
    'Dunsmuir',
    'East Palo Alto',
    'El Cajon',
    'El Centro',
    'El Cerrito',
    'El Monte',
    'El Paso De Robles',
    'El Segundo',
    'Elk Grove',
    'Emeryville',
    'Encinitas',
    'Escalon',
    'Escondido',
    'Etna',
    'Eureka',
    'Exeter',
    'Fairfax',
    'Fairfield',
    'Farmersville',
    'Ferndale',
    'Fillmore',
    'Firebaugh',
    'Folsom',
    'Fontana',
    'Fort Bragg',
    'Fort Jones',
    'Fortuna',
    'Foster City',
    'Fountain Valley',
    'Fowler',
    'Fremont',
    'Fresno',
    'Fullerton',
    'Galt',
    'Garden Grove',
    'Gardena',
    'Gilroy',
    'Glendale',
    'Glendora',
    'Gonzales',
    'Grand Terrace',
    'Grass Valley',
    'Greenfield',
    'Gridley',
    'Grover Beach',
    'Guadalupe',
    'Gustine',
    'Half Moon Bay',
    'Hanford',
    'Hawaiian Gardens',
    'Hawthorne',
    'Hayward',
    'Healdsburg',
    'Hemet',
    'Hercules',
    'Hermosa Beach',
    'Hesperia',
    'Hidden Hills',
    'Highland',
    'Hillsborough',
    'Hollister',
    'Holtville Imperial',
    'Hughson',
    'Huntington Beach',
    'Huntington Park',
    'Huron',
    'Imperial Imperial',
    'Imperial Beach',
    'Indian Wells',
    'Indio',
    'Industry',
    'Inglewood',
    'Ione',
    'Irvine',
    'Irwindale',
    'Isleton',
    'Jackson',
    'Jurupa Valley',
    'Kerman',
    'King City',
    'Kingsburg',
    'La Canada Flintridge',
    'La Habra',
    'La Habra Heights',
    'La Mesa',
    'La Mirada',
    'La Palma',
    'La Puente',
    'La Quinta',
    'La Verne',
    'Lafayette',
    'Laguna Beach',
    'Laguna Hills',
    'Laguna Niguel',
    'Laguna Woods',
    'Lake Elsinore',
    'Lake Forest',
    'Lakeport',
    'Lakewood',
    'Lancaster',
    'Larkspur',
    'Lathrop',
    'Lawndale',
    'Lemon Grove',
    'Lemoore Kings',
    'Lincoln Placer',
    'Lindsay Tulare',
    'Live Oak Sutter',
    'Livermore',
    'Livingston',
    'Lodi',
    'Loma Linda',
    'Lomita',
    'Lompoc',
    'Long Beach',
    'Loomis Placer',
    'Los Alamitos',
    'Los Altos',
    'Los Altos Hills',
    'Los Angeles',
    'Los Banos',
    'Los Gatos',
    'Loyalton',
    'Lynwood',
    'Madera',
    'Malibu',
    'Mammoth Lakes',
    'Manhattan Beach',
    'Manteca',
    'Maricopa',
    'Marina',
    'Martinez',
    'Marysville',
    'Maywood',
    'Mcfarland',
    'Mendota',
    'Menlo Park',
    'Merced',
    'Mill Valley',
    'Millbrae',
    'Milpitas',
    'Mission Viejo',
    'Modesto',
    'Monrovia',
    'Montague',
    'Montclair',
    'Monte Sereno',
    'Montebello',
    'Monterey',
    'Monterey Park',
    'Moorpark',
    'Moraga',
    'Moreno Valley',
    'Morgan Hill',
    'Morro Bay',
    'Mount Shasta',
    'Mountain View',
    'Murrieta',
    'Napa Napa',
    'National City',
    'Needles',
    'Nevada City',
    'Newark',
    'Newman',
    'Newport Beach',
    'Norco',
    'Norwalk',
    'Novato',
    'Oakdale',
    'Oakland',
    'Oakley',
    'Oceanside',
    'Ojai',
    'Ontario',
    'Orange',
    'Orange Cove',
    'Orinda',
    'Orland Glenn',
    'Oroville Butte',
    'Oxnard',
    'Pacific Grove',
    'Pacifica',
    'Palm Desert',
    'Palm Springs',
    'Palmdale',
    'Palo Alto',
    'Palos Verdes Estates',
    'Paradise',
    'Paramount',
    'Parlier',
    'Pasadena',
    'Patterson',
    'Perris',
    'Petaluma',
    'Pico Rivera',
    'Piedmont',
    'Pinole',
    'Pismo Beach',
    'Pittsburg',
    'Placentia',
    'Placerville',
    'Pleasant Hill',
    'Pleasanton',
    'Plymouth',
    'Point Arena',
    'Pomona',
    'Port Hueneme',
    'Porterville',
    'Portola',
    'Portola Valley',
    'Poway',
    'Rancho Cordova',
    'Rancho Cucamonga',
    'Rancho Mirage',
    'Rancho Palos Verdes',
    'Rancho Santa Margarita',
    'Red Bluff',
    'Redding',
    'Redlands',
    'Redondo Beach',
    'Redwood City',
    'Reedley',
    'Rialto',
    'Richmond',
    'Ridgecrest',
    'Rio Dell',
    'Rio Vista',
    'Ripon',
    'Riverbank',
    'Riverside',
    'Rocklin',
    'Rohnert Park',
    'Rolling Hills',
    'Rolling Hills Estates',
    'Rosemead',
    'Roseville Placer',
    'Ross',
    'Sacramento',
    'Salinas',
    'San Anselmo',
    'San Bernardino',
    'San Bruno',
    'San Buena',
    'San Carlos',
    'San Clemente',
    'San Diego',
    'San Dimas',
    'San Fernando',
    'San Francisco',
    'San Gabriel',
    'San Jacinto',
    'San Joaquin',
    'San Jose',
    'San Juan Bautista',
    'San Juan Capistrano',
    'San Leandro',
    'San Luis Obispo',
    'San Marcos',
    'San Marino',
    'San Mateo',
    'San Pablo',
    'San Rafael',
    'San Ramon',
    'Sand City',
    'Sanger',
    'Santa Ana',
    'Santa Barbara',
    'Santa Clara',
    'Santa Clarita',
    'Santa Cruz',
    'Santa Fe Springs',
    'Santa Maria',
    'Santa Monica',
    'Santa Paula',
    'Santa Rosa',
    'Santee',
    'Saratoga',
    'Sausalito',
    'Scotts Valley',
    'Seal Beach',
    'Seaside',
    'Sebastopol',
    'Selma',
    'Shafter',
    'Shasta Lake',
    'Sierra Madre',
    'Signal Hill',
    'Simi Valley',
    'Solana Beach',
    'Soledad',
    'Solvang',
    'Sonoma',
    'Sonora',
    'South El Monte',
    'South Gate',
    'South Lake Tahoe',
    'South Pasadena',
    'South San Francisco',
    'St Helena',
    'Stanton',
    'Stockton',
    'Suisun City',
    'Sunnyvale',
    'Susanville',
    'Sutter Creek',
    'Taft',
    'Tehachapi',
    'Tehama',
    'Temecula',
    'Temple City',
    'Thousand Oaks',
    'Tiburon',
    'Torrance',
    'Tracy',
    'Trinidad',
    'Truckee',
    'Tulare',
    'Tulelake',
    'Turlock',
    'Tustin',
    'Twentynine Palms',
    'Ukiah',
    'Union City',
    'Upland',
    'Vacaville',
    'Vallejo',
    'Ventura',
    'Vernon',
    'Victorville',
    'Villa Park',
    'Visalia',
    'Vista',
    'Walnut',
    'Walnut Creek',
    'Wasco',
    'Waterford',
    'Watsonville',
    'Weed',
    'West Covina',
    'West Hollywood',
    'West Sacramento',
    'Westlake Village',
    'Westminster',
    'Westmorland',
    'Wheatland',
    'Whittier',
    'Williams',
    'Willits',
    'Willows',
    'Windsor',
    'Winters',
    'Woodlake',
    'Woodland',
    'Woodside',
    'Yorba Linda',
    'Yountville',
    'Yreka',
    'Yuba City',
    'Yucaipa',
    'Yucca Valley',
  ];
}
