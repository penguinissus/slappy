# Source - https://stackoverflow.com/a
# Posted by Umer Farooq, modified by community. See post 'Timeline' for change history
# Retrieved 2025-11-15, License - CC BY-SA 4.0

import websocket
import time
import threading
def on_message(ws, message):
    print(message) # sensor data here in JSON format
    openBracket = message.find("[")
    closeBracket = message.find("]")
    print(str(openBracket) + " " + str(closeBracket))

def on_error(ws, error):
    print("### error ###")
    print(error)

def on_close(ws, close_code, reason):
    print("### closed ###")
    print("close code : ", close_code)
    print("reason : ", reason  )

def on_open(ws):
    print("connection opened")
    
def stopafter(ws,sec):
    time.sleep(sec)
    ws.close()
    print('closed boom')

if __name__ == "__main__":
    ws = websocket.WebSocketApp("ws://Sophia.civichall.org:8080/sensor/connect?type=android.sensor.accelerometer",
        on_open=on_open,
        on_message=on_message,
        on_error=on_error,
        on_close=on_close)
    
    threading.Thread(target=stopafter, args=(ws, 4)).start()
    ws.run_forever()