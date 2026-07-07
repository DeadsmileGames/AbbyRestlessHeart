if (cooldown > 0) cooldown--;

if (!instance_exists(objPlayer)) exit;
if (instance_exists(objBattleManager)) exit;

var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
var dentro_do_raio = (dist < trigger_distance && !is_triggered && !instance_exists(objDialogue));

var e_o_mais_perto = false;
if (dentro_do_raio) {
    var closest_interact = instance_nearest(objPlayer.x, objPlayer.y, objInteract);
    if (closest_interact == id) {
        e_o_mais_perto = true;
    }
}

show_prompt = e_o_mais_perto;

if (show_prompt && keyboard_check_pressed(ord("Z")) && objPlayer.config_open == false) {
    is_triggered = true;
    Interact(interact_pages);
    cooldown = 15;
}

if (is_triggered && !instance_exists(objInteractSystem) && !instance_exists(objDialogue)) {
    is_triggered = false;
}