extends GridMap

#All floors and rooms
var Floor_Sceens = [
	preload("res://Floor.tscn"),
	preload("res://Floor.tscn"),
	preload("res://Floor_3.tscn"),
	preload("res://Floor_2.tscn"),
	preload("res://Floor_4.tscn"),
	preload("res://Floor_4.tscn")
]

@onready var Pillar = preload("res://pillar.tscn")
#End of section
@export var view_distance:int = 10
var terrain_chunks = {}
var rooms:Dictionary = {}
@export var Player:CharacterBody3D

func _process(delta: float) -> void:
	gen_map()

func gen_map():
	if !rooms.is_empty():
		for room in rooms.keys():
			rooms.get(room).visible = false
	for X in range(-view_distance,view_distance):
		for Y in range(-view_distance,view_distance):
			if !rooms.has(local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y)):
				if (local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y)).x%20 == 0\
				 and (local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y)).z%20 == 0:
					if map_to_local(local_to_map(Player.position)+Vector3i(X,0,Y)).distance_to(Player.global_position)<=view_distance*10:
						var newt = Pillar.instantiate()
						newt.global_position = map_to_local(local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y))
						get_parent().add_child(newt)
						rooms[local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y)] = newt
				elif map_to_local(local_to_map(Player.position)+Vector3i(X,0,Y)).distance_to(Player.global_position)<=view_distance*10: 
					var _noise = FastNoiseLite.new()
					_noise.frequency = 1
					_noise.seed = 2
					var newt = Floor_Sceens[noise_to_useable(_noise,X,Y)].instantiate()
					newt.global_position = map_to_local(local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y))
					get_parent().add_child(newt)
					rooms[local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y)] = newt
			else:
				rooms.get(local_to_map(Vector3(Player.position.x,0,Player.position.z))+Vector3i(X,0,Y)).visible = true

func noise_to_useable(_noise:FastNoiseLite,X,Y):
	var Value = (_noise.get_noise_2d(X,Y) + 1)/2
	var Index = int(Value * Floor_Sceens.size())
	Index = min(Index, Floor_Sceens.size() -1)
	return Index
