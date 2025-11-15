import asyncio
import websockets
import json

godot_clients = set()

async def phone_handler(websocket):
    async for message in websocket:
        data = json.loads(message)

        #forward to all connected godot clients
        for client in godot_clients:
            await client.send(json.dumps({"phone":data}))

async def godot_handler(websocket):
    godot_clients.add(websocket)
    try:
        await websocket.wait_closed()
    finally:
        godot_clients.remove(websocket)

async def main():
    print("Phone -> ws://localhost:8765")
    print("Godot -> ws://localhost:8766")

    phone_server = websockets.serve(phone_handler, "0.0.0.0", 8765)
    godot_server = websockets.serve(godot_handler, "0,0,0,0", 8766)

    await asyncio.gather(phone_server, godot_server)

asyncio.run(main())