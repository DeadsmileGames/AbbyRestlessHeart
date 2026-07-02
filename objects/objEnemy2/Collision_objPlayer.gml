if (!instance_exists(objDialogue) && !instance_exists(objBattleManager)) {
    start_battle(enemy_name, enemy_hp, enemy_atk, true, enemy_sprite_string, id, MazeOfMemories, "MYSTIC HEAL", "+atk");
}