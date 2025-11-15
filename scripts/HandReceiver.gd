extends Node

var socket:= WebSocketPeer.new()

func _ready():
	socket.connect_to_url("ws://localhost:8765")
	set_process(true)
	
func _process(delta):
	socket.poll()
	
	while socket.get_peer(1).get_available_packet_count() > 0:
		var msg = socket.get_peer(1).get_packet().get_string_from_utf8()
		var data = JSON.parse_string(msg)
		
		if not data or not data.has("hand") or data["hand"] == null:
			continue
			
		var hx = data["hand"]["x"]
		var hy = data["hand"]["y"]
		var vx = data["hand"]["vx"]
		var vy = data["hand"]["vy"]
