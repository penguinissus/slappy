import cv2
import numpy as np
import asyncio
import websockets
import json
import time

async def send_data(websocket):
    cap = cv2.VideoCapture(0)

    prev_center = None
    prev_time = time.time()

    while True:
        ret, frame = cap.read()
        if not ret:
            continue

        frame = cv2.flip(frame, 1)
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

        #adjust to match skin tone under lighting
        lower = np.array([0, 30, 60])
        upper = np.array([20, 150, 255])
        mask = cv2.inRange(hsv, lower, upper)

        mask = cv2.erode(mask, None, iterations=2)
        mask = cv2.dilate(mask, None, iterations=2)

        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        data = {"hand": None}

        if contours:
            c = max(contours, key=cv2.contourArea)
            x, y, w, h = cv2.boundingRect(c)

            #compute center of hand
            cx = x + w // 2
            cy = y + h // 2

            #velocity
            current_time = time.time()
            dt = current_time - prev_time

            if prev_center is not None and dt > 0:
                vx = (cx - prev_center[0]) / dt
                vy = (cy - prev_center[1]) / dt
            else:
                vx, vy = 0, 0
            
            prev_center = (cx, cy)
            prev_time = current_time

            #normalize coordinates for sending (0 -> 1)
            h_img, w_img, _ = frame.shape
            date["hand"] = {
                "x": cx / w_img,
                "y": cy / h_img,
                "vx": vx,
                "vy": vy
            }

            #draw debug graphics (delete later)
            cv2.circle(frame, (cx, cy), 10, (0, 255, 0), 2)
            cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
        
        await websocket.send(json.dumps(data))

        cv2.imshow("Hand Blob Tracking", frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
    
    cap.release()

async def main():
    print("Server running at ws://localhost:8765")
    async with websockets.serve(send_data, "localhost", 8765):
        await asyncio.Future()

asyncio.run(main())