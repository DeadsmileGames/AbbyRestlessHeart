//Chapter controls
global.ChapterOneIsComplete = false;
global.ChapterTwoIsComplete = false;
global.ChapterThreeIsComplete = false;
global.ChapterFourIsComplete = false;

//player
global.isMila = false
global.hp = 20
global.atk = 1
global.def = 1
global.hp_max = 20
global.inventory = [
	{ name: "STICK", type: "weapon", sprite: sprPlayerIdle, value: 2, info: "+2 ATK" },
    { name: "BANDAGE", type: "shield", sprite: sprPlayerIdle, value: 1, info: "+1 DEF" },
    { name: "BREAD", type: "heal", sprite: sprPlayerIdle, value: 10, info: "HEAL 10 HP" }
];

//UI
global.current_objective = "";
global.current_chapter = 1;


//fontes
global.fonteNormal = fontNormal;
global.fonteMenu = fontMenu;
global.fonteTitulo = fontTitulo;
global.fonteTitulo2 = fontTitulo2
global.fonteLegenda = fontLegenda;
global.fonteLegendaM = fontLegenda2;
global.fonteNM = fontNormal;
global.fonteTM = fontTitulo;
global.fonteLM = fontLegenda;
gpu_set_texfilter(false);

//settings
global.vol_bgm = 1.0
global.vol_sfx = 1.0
global.fullscreen = window_get_fullscreen()

//intro
global.history_answers = array_create(7, -1);


//Chapter 1 - SweetHome - Letter puzzle
global.puzzle_active = false;
global.puzzle_solved = false;
global.keyYellow = false
global.keyBlue = false
global.keyGreen = false
global.crt_active = false
global.minigames = 0;