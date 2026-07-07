text_alpha = 0;
fade_out_alpha = 0;
is_fading_out = false;

if (!variable_global_exists("vol_bgm")) global.vol_bgm = 1.0;
if (!variable_global_exists("vol_sfx")) global.vol_sfx = 1.0;
if (!variable_global_exists("fullscreen")) global.fullscreen = window_get_fullscreen();
if (!variable_global_exists("achievements")) global.achievements = true;
if (!variable_global_exists("crt_active")) global.crt_active = true;

ini_open("configuracoes.ini");
global.fullscreen = ini_read_real("Video", "Fullscreen", global.fullscreen);
global.vol_bgm = ini_read_real("Audio", "Volume_BGM", global.vol_bgm);
global.vol_sfx = ini_read_real("Audio", "Volume_SFX", global.vol_sfx);
global.achievements = ini_read_real("Gameplay", "Achievements", global.achievements);
global.crt_active = ini_read_real("Video", "CRT_Active", true);
ini_close();

window_set_fullscreen(global.fullscreen);

warning_text = "WARNING\n\nThis game contains sensitive themes, psychological distress,\nand scenes with intense flashing lights.\n\nPlayer discretion is advised.\n\n\nPress [Z] to continue.";