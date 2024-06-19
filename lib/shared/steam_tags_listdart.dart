const List<String> steamTags = [
  'Action',
  'Adventure',
  'Casual',
  'Experimental',
  'Puzzle',
  'Racing',
  'RPG',
  'Simulation',
  'Sports',
  'Strategy',
  'Tabletop',
  'Action RPG',
  'Action-Adventure',
  'Arcade',
  'Auto Battler',
  'Automobile Sim',
  'Base Building',
  'Baseball',
  'Basketball',
  'Battle Royale',
  'BMX',
  'Board Game',
  'Bowling',
  'Building',
  'Card Game',
  'Character Action Game',
  'Chess',
  'Clicker',
  'Cycling',
  'Diplomacy',
  'eSports',
  'Experimental',
  'Exploration',
  'Farming Sim',
  'Fighting',
  'Football',
  'God Game',
  'Golf',
  'Hacking',
  'Hidden Object',
  'Hockey',
  'Idler',
  'Interactive Fiction',
  'Management',
  'Match 3',
  'Medical Sim',
  'Mini Golf',
  'Mining',
  'MMORPG',
  'MOBA',
  'Motocross',
  'Open World',
  'Outbreak Sim',
  'Party-Based RPG',
  'Pinball',
  'Platformer',
  'Point & Click',
  'Rhythm',
  'Roguelike',
  'RTS',
  'Sandbox',
  'Shooter',
  'Skateboarding',
  'Skating',
  'Skiing',
  'Snowboarding',
  'Soccer',
  'Space Sim',
  'Stealth',
  'Strategy RPG',
  'Survival',
  'Tennis',
  'Tower Defense',
  'Trivia',
  'Turn-Based Strategy',
  'Visual Novel',
  'Walking Simulator',
  'Word Game',
  'Wrestling',
  '2D Fighter',
  '2D Platformer',
  '3D Fighter',
  '3D Platformer',
  '4X',
  'Action Roguelike',
  'Arena Shooter',
  'Beat \'em up',
  'Bullet Hell',
  'Card Battler',
  'Choose Your Own Adventure',
  'City Builder',
  'Collectathon',
  'Colony Sim',
  'Combat Racing',
  'CRPG',
  'Dating Sim',
  'Dungeon Crawler',
  'Education',
  'Flight',
  'FPS',
  'Grand Strategy',
  'Hack and Slash',
  'Heist',
  'Hero Shooter',
  'Horror',
  'Immersive Sim',
  'Investigation',
  'JRPG',
  'Life Sim',
  'Looter Shooter',
  'Metroidvania',
  'Mystery Dungeon',
  'On-Rails Shooter',
  'Open World Survival Craft',
  'Political Sim',
  'Precision Platformer',
  'Programming',
  'Real Time Tactics',
  'Roguelite',
  'Roguevania',
  'Runner',
  'Shoot \'Em Up',
  'Side Scroller',
  'Sokoban',
  'Solitaire',
  'Souls-like',
  'Spectacle fighter',
  'Spelling',
  'Survival Horror',
  'Tactical RPG',
  'Third-Person Shooter',
  'Time Management',
  'Top-Down Shooter',
  'Trading',
  'Trading Card Game',
  'Traditional Roguelike',
  'Turn-Based Tactics',
  'Twin Stick Shooter',
  'Typing',
  'Wargame',
  '2.5D',
  '2D',
  '360 Video',
  '3D',
  '3D Vision',
  'Abstract',
  'Anime',
  'Cartoon',
  'Cartoony',
  'Cinematic',
  'Colorful',
  'Comic Book',
  'Cute',
  'First-Person',
  'FMV',
  'Hand-drawn',
  'Isometric',
  'Minimalist',
  'Noir',
  'Pixel Graphics',
  'Psychedelic',
  'Realistic',
  'Split Screen',
  'Stylized',
  'Text-Based',
  'Third Person',
  'Top-Down',
  'Voxel',
  'VR',
  '1980s',
  '1990\'s',
  'Agriculture',
  'Aliens',
  'Alternate History',
  'America',
  'Atmospheric',
  'Assassin',
  'Bikes',
  'Capitalism',
  'Cats',
  'Cold War',
  'Comic Book',
  'Conspiracy',
  'Crime',
  'Cyberpunk',
  'Dark',
  'Dark Fantasy',
  'Demons',
  'Destruction',
  'Detective',
  'Dinosaurs',
  'Diplomacy',
  'Dog',
  'Dragons',
  'Dynamic Narration',
  'Economy',
  'Education',
  'Faith',
  'Family Friendly',
  'Fantasy',
  'Foreign',
  'Futuristic',
  'Gambling',
  'Game Development',
  'Gothic',
  'Heist',
  'Historical',
  'Horses',
  'Illuminati',
  'Investigation',
  'Jet',
  'Lemmings',
  'LGBTQ+',
  'Logic',
  'Loot',
  'Lovecraftian',
  'Magic',
  'Management',
  'Mars',
  'Mechs',
  'Medieval',
  'Memes',
  'Military',
  'Modern',
  'Motorbike',
  'Mystery',
  'Mythology',
  'Nature',
  'Naval',
  'Ninja',
  'Offroad',
  'Old School',
  'Otome',
  'Parkour',
  'Philosophical',
  'Pirates',
  'Political',
  'Politics',
  'Pool',
  'Post-apocalyptic',
  'Programming',
  'Retro',
  'Robots',
  'Romance',
  'Rome',
  'Satire',
  'Science',
  'Sci-fi',
  'Sniper',
  'Snow',
  'Space',
  'Stealth',
  'Steampunk',
  'Submarine',
  'Superhero',
  'Supernatural',
  'Surreal',
  'Survival',
  'Swordplay',
  'Tactical',
  'Tanks',
  'Thriller',
  'Time Travel',
  'Trains',
  'Transhumanism',
  'Transportation',
  'Underground',
  'Underwater',
  'Vampire',
  'War',
  'Werewolves',
  'Western',
  'World War I',
  'World War II',
  '6DOF',
  'Archery',
  'Artificial Intelligence',
  'Asymmetric VR',
  'ATV',
  'Automation',
  'Base Building',
  'Boxing',
  'Building',
  'Bullet Time',
  'Character Customization',
  'Choices Matter',
  'Class-Based',
  'Combat',
  'Conversation',
  'Crafting',
  'Deckbuilding',
  'Driving',
  'Fishing',
  'Flight',
  'FMV',
  'Grid-Based Movement',
  'Gun Customization',
  'Hack and Slash',
  'Hacking',
  'Hex Grid',
  'Hunting',
  'Inventory Management',
  'Level Editor',
  'Linear',
  'Martial Arts',
  'Mining',
  'Moddable',
  'Multiple Endings',
  'Music-Based Procedural Generation',
  'Narration',
  'Naval Combat',
  'Nonlinear',
  'Open World',
  'Perma Death',
  'Physics',
  'Procedural Generation',
  'PvE',
  'PvP',
  'Quick-Time Events',
  'Resource Management',
  'Sailing',
  'Score Attack',
  'Stealth',
  'Story Rich',
  'Tabletop',
  'Team-Based',
  'Text-Based',
  'Time Manipulation',
  'Trading',
  'Turn-Based Combat',
  'Turn-Based Tactics',
  'Tutorial',
  'Vehicular Combat',
  'Female Protagonist',
  'Silent Protagonist',
  'Villain Protagonist',
  'Minigames',
  'Intentionally Awkward Controls',
  '4 Player Local',
  'Asynchronous Multiplayer',
  'Co-op',
  'Co-op Campaign',
  'Local Co-Op',
  'Local Multiplayer',
  'Massively Multiplayer',
  'Multiplayer',
  'Online Co-Op',
  'Singleplayer',
  'Based on a Novel',
  'Batman',
  'Documentary',
  'Drama',
  'Dungeons & Dragons',
  'Episodic',
  'Experience',
  'Feature Film',
  'Games Workshop',
  'Indie',
  'Lara Croft',
  'LEGO',
  'Mod',
  'Movie',
  'Music',
  'Real-Time',
  'Real-Time with Pause',
  'Remake',
  'Sequel',
  'Soundtrack',
  'Star Wars',
  'Time Attack',
  'Turn-Based',
  'Warhammer 40K',
  'Animation & Modeling',
  'Audio Production',
  'Benchmark',
  'Design & Illustration',
  'GameMaker',
  'Gaming',
  'Photo Editing',
  'RPGMaker',
  'Software',
  'Software Training',
  'Utilities',
  'Video Production',
  'Web Publishing',
  'Addictive',
  'Beautiful',
  'Classic',
  'Competitive',
  'Cult Classic',
  'Difficult',
  'Emotional',
  'Epic',
  'Fast-Paced',
  'Funny',
  'Great Soundtrack',
  'Lore-Rich',
  'Masterpiece',
  'Psychological',
  'Relaxing',
  'Replay Value',
  'Short',
  'Unforgiving',
  'Comedy',
  'Dark Comedy',
  'Blood',
  'Gore',
  'Mature',
  'NSFW',
  'Nudity',
  'Sexual Content',
  'Violent',
  'Controller',
  'Hardware',
  'Mouse only',
  'Steam Machine',
  'Touch-Friendly',
  'TrackIR',
  'Voice Control',
  'Crowdfunded',
  'Early Access',
  'Free to Play',
  'Kickstarter',
];
