puzzle_x = 0;
puzzle_y = 0;
game_over = false;
win = false;
global.puzzle_active = true;

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

box_w = 560;
box_h = 380;
bx1 = (gui_w - box_w) / 2;
by1 = (gui_h - box_h) / 2;
bx2 = bx1 + box_w;
by2 = by1 + box_h;

rhythm_bar_y = 0;
rhythm_speed = 1.8; 
rhythm_dir = 1;

target_min = 65;
target_max = 85;

plant_growth = 0;
score_target = 100;
fail_meter = 0;
max_fail = 100;

plant_flash = false;
flash_timer = 0;

move_sound = Beep;
error_sound = Beep;