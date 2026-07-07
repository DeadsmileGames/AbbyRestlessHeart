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
stone_x = bx1 + box_w / 2;
stone_y = by1 + box_h / 2 + 20;

cursor_x = stone_x;
cursor_y = stone_y;
crack_active = false;
crack_x = 0;
crack_y = 0;
crack_hp = 0; 
cracks_broken = 0;
target_cracks = 5; 
pickaxe_durability = 100;
hit_flash = 0;
shake_x = 0;
shake_y = 0;

move_sound = Beep;
error_sound = Beep;