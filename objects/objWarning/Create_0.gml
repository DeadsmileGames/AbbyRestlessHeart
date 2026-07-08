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

warning_text = "WARNING\n\nThis game contains sensitive themes,\npsychological distress, and scenes with\nintense flashing lights.\n\nPlayer discretion is advised.";

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

paper_w = 580;
paper_h = 440;
paper_x = (_gw - paper_w) / 2;

paper_y = _gh + 180; 
paper_target_y = (_gh - paper_h) / 2;

col_wood_base    = make_color_rgb(28, 19, 14);
col_wood_deep    = make_color_rgb(18, 11, 8);
col_wood_grain   = make_color_rgb(46, 32, 24);
col_wood_knot    = make_color_rgb(13, 8, 6);
col_ambient_shd  = make_color_rgb(8, 5, 4);

col_paper        = make_color_rgb(245, 238, 222);
col_paper_shadow = make_color_rgb(218, 208, 188);
col_pencil_lead  = make_color_rgb(55, 52, 48);
col_blood_pencil = make_color_rgb(166, 45, 45);
col_notebook_line = make_color_rgb(192, 214, 216);
col_margin_line  = make_color_rgb(225, 130, 130);
col_ink_main     = make_color_rgb(35, 32, 28);
col_ink_sub      = make_color_rgb(115, 108, 96);