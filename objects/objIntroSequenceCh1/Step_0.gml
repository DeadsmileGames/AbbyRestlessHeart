var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

timer++;

switch (state) {
    case 0: 
        paper_y += (paper_target_y - paper_y) * 0.08;
        paper_angle += (paper_target_angle - paper_angle) * 0.06;
        
        if (abs(paper_y - paper_target_y) < 10) {
            state = 1;
            timer = 0;
            if (audio_exists(Beep)) {
                var sfx = audio_play_sound(Beep, 1, false);
                audio_sound_gain(sfx, global.vol_sfx * 0.5, 0);
            }
        }
        break;
        
    case 1: 
        if (timer > 15) {
            draw_text_progress += 0.3; 
            if (draw_text_progress >= 9) { 
                state = 2;
                timer = 0;
            }
        }
        break;
        
    case 2: 
        if (timer > 20) {
            state = 3;
            timer = 0;
        }
        break;
        
    case 3: 
        sub_text_progress += 0.25;
        
        if (sub_text_progress < 9 && (timer % 2 == 0) && (array_length(lead_shards) < max_lead_shards)) {
            array_push(lead_shards, {
                xx: _gw / 2 + random_range(-100, 100),
                yy: paper_y + paper_h / 2 + 50,
                vx: random_range(-1.5, 1.5),
                vy: random_range(-3, -1),
                alpha: 1.0,
                size: choose(2, 3)
            });
        }
        
        if (sub_text_progress >= 10) { 
            state = 4;
            timer = 0;
        }
        break;
        
    case 4: 
        version_alpha = min(1, version_alpha + 0.05);
        credits_alpha = min(1, credits_alpha + 0.05);
        if (version_alpha >= 1) {
            state = 5;
            timer = 0;
        }
        break;
        
    case 5: 
        if (timer > 90) { 
            state = 6;
            timer = 0;
        }
        break;
        
    case 6:
        version_alpha = max(0, version_alpha - 0.04);
        credits_alpha = max(0, credits_alpha - 0.04);
        paper_alpha = max(0, paper_alpha - 0.03);

        if (timer % 3 == 0 && array_length(ash_particles) < max_ash_particles) {
            array_push(ash_particles, {
                xx: paper_x + random(paper_w),
                yy: paper_y + random(paper_h),
                vx: random_range(-0.8, 0.8),
                vy: random_range(-1.5, -0.5),
                alpha: paper_alpha,
                size: choose(2, 3, 4)
            });
        }
        
        if (paper_alpha <= 0) {
            state = 7;
            timer = 0;
        }
        break;
        
    case 7: 
        room_goto(rm_IntroChapter1);
        instance_destroy();
        break;
}

var shards_len = array_length(lead_shards);
for (var i = shards_len - 1; i >= 0; i--) {
    var s = lead_shards[i];
    s.xx += s.vx;
    s.yy += s.vy;
    s.vy += 0.2; 
    s.alpha -= 0.03;
    if (s.alpha <= 0) array_delete(lead_shards, i, 1);
}

var ash_len = array_length(ash_particles);
for (var i = ash_len - 1; i >= 0; i--) {
    var a = ash_particles[i];
    a.xx += a.vx;
    a.yy += a.vy;
    a.alpha -= 0.02;
    if (a.alpha <= 0) array_delete(ash_particles, i, 1);
}