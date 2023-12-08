extends TileMap

var projectResolution
var projectTilesRes
var GraphPoints : AStar2D
var RoomArray = []
var RoomGraph = []

# Called when the node enters the scene tree for the first time.
func _ready():
	get_screen_transform()
	projectResolution= get_viewport().get_visible_rect().size
	# projectTilesRes = Vector2(ceilf(projectResolution.x / 16), ceilf(projectResolution.y / 16))
	projectTilesRes = Vector2(60, 60)
	
	GraphPoints = AStar2D.new()
	
	
	for i in range(projectTilesRes.x):
		for j in range(projectTilesRes.y):
			set_cell(0, Vector2(i, j), 6, Vector2(6, 8), 0)                                                                                                                                                                                                                                                                                                                                                                                                             

	
	for i in range(8):
		make_an_island(randi_range(0, projectTilesRes.x - 14), randi_range(0, projectTilesRes.y - 14))
	var graph_drawer = Graph_drawer.new(GraphPoints)
	$"..".add_child(Graph_drawer)

			

	pass # Replace with function body.
	
func make_an_island(x, y):
	var height = randi_range(6, 14)
	var width = randi_range(6, 14)
	var newRoom = Room.new(Vector2i(x, y), height, width)
	for createdRoom in RoomArray:
		if (room_intersect(createdRoom, newRoom)):
			return
	RoomArray.append(newRoom)
	var id = GraphPoints.get_available_point_id()
	var nearPoint = GraphPoints.get_closest_point(newRoom.center)
	GraphPoints.add_point(GraphPoints.get_available_point_id(), newRoom.center)
	if (nearPoint != -1):
		GraphPoints.connect_points(id, nearPoint)
	
	
	for i in range(height):
		for j in range(width):
			set_cell(0, Vector2(x + i, y + j), 0, Vector2(0, 0), 0)
	

	
func room_intersect(room1: Room, room2: Room):
	var intersected = false
	for corner in room1.corners:
		if (corner.x >= room2.position.x - 2 and corner.x <= room2.position.x + room2.width + 2) and (corner.y >= room2.position.y - 2 and corner.y <= room2.position.y + room2.height + 2):
			intersected = true
			return intersected
	return intersected
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

