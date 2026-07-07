if (instance_exists(objDialogue)) {
    hspd = 0;
    vspd = 0;
    exit;
}

if (instance_exists(objMinigamePuzzle2) || instance_exists(objMinigamePuzzle) || instance_exists(objMinigamePuzzle3)) {
    hspd = 0;
    vspd = 0;
    exit; 
}

if (instance_exists(objPlayer)) {
    if (objPlayer.config_open) {
        hspd = 0;
        vspd = 0;
        exit;
    }
}

if (instance_exists(objInteractSystem)) {
    hspd = 0;
    vspd = 0;
    state = "idle";
    exit;
}


if (instance_exists(objBattleManager)) {
    hspd = 0;
    vspd = 0;
    exit;
}

if (instance_exists(objPlayer)) {
    var _dist = point_distance(x, y, objPlayer.x, objPlayer.y);
    
    switch (state) {
        case "idle":
            hspd = 0;
            vspd = 0;
            if (_dist <= chase_radius) {
                state = "alert_anim";
                alert_timer = 0;
                audio_play_sound(Beep, 1, false);
            }
            break;
            
        case "alert_anim":
            hspd = 0;
            vspd = 0;
            alert_timer++;
            
            if (alert_timer < 15) {
                jump_y_offset = -12 * sin((alert_timer / 15) * pi);
            } else {
                jump_y_offset = 0;
            }
            
            if (alert_timer >= alert_max_time) {
                state = "chase";
            }
            break;
            
        case "chase":
            if (_dist <= chase_radius) {
                var _dir = point_direction(x, y, objPlayer.x, objPlayer.y);
                hspd = lengthdir_x(spd, _dir);
                vspd = lengthdir_y(spd, _dir);
            } else {
                state = "idle";
            }
            break;
    }
}

if (place_meeting(x + hspd, y, obj)) {
    while (!place_meeting(x + sign(hspd), y, obj)) {
        x += sign(hspd);
    }
    hspd = 0;
}
x += hspd;

if (place_meeting(x, y + vspd, obj)) {
    while (!place_meeting(x, y + sign(vspd), obj)) {
        y += sign(vspd);
    }
    vspd = 0;
}
y += vspd;

depth = -y;