extends Node

var playerLevel = 1
var enemyLevel = 1
var xp = 0
var xp_max = 5
var position = Vector2(0,0)
var minute = 0
var seconds = 0

var inventory = {
	"Grenades": 0,
	"Firing Speed": 0,
	"Ricochet": 0,
	"Missile": 0,
}

var upgrades = {
	0: "Grenades",
	1: "Firing Speed",
	2: "Ricochet",
	3: "Missile"
}

var tiles = {
	0: "res://Scenes/world_tiles/basictrees.tscn",
	1: "res://Scenes/world_tiles/bunchedtrees.tscn",
	2: "res://Scenes/world_tiles/circletrees.tscn",
	3: "res://Scenes/world_tiles/grass_world.tscn"
}

var upgrade_text = {
	"Grenades": "An explosive grenade will throw itself towards the nearest enemy and explode after 5 seconds.",
	"Firing Speed": "Quicken your trigger finger to fire bullets faster. Maximum 1.5s faster.",
	"Ricochet": "Bullets that land on enemies will break off into smaller, less damaging pellets.",
	"Missile": "Fires a missile straight up, and then homes in on the nearest enemy.",
}
