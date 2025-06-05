extends Node

var keys = {
	"cidade": false,
	"caverna": false
}
var player_current_attack = false
var current_scene = "cidade" # cidade, caverna, boss_arena
var transition_scene = false
var target_scene = ""  
var last_scene = ""

#Posições do jogador ao entrar/sair de cenas
var player_exit_caverna_ladder_posx = 107
var player_exit_caverna_ladder_posy = 282

var player_start_caverna_posx = 143
var player_start_caverna_posy = 114

var player_start_cityx = 34
var player_start_cityy = -30

var player_return_from_boss_caverna_posx = 490
var player_return_from_boss_caverna_posy = 510

var game_first_loadin = true


func finish_changescenes():#Transição de cenas
	if transition_scene:
		transition_scene = false
		match target_scene:
			"cidade":
				current_scene = "cidade"
				print("Transição para a Cidade")
			"caverna":
				current_scene = "caverna"
				print("Transição para a Caverna (vinda do boss)")
			"boss_arena":
				current_scene = "boss_arena"
				print("Transição para a Arena do Boss")
		target_scene = ""
