from flask import Flask, request ,jsonify,render_template
from flask_socketio import SocketIO, send, join_room, leave_room
from flask_cors import CORS
import json,time

app = Flask(__name__)
CORS(app)
app.secret_key='my secret'
socketio = SocketIO(app, cors_allowed_origins='*')

def load_users():
    with open('db.json') as f:
        return json.load(f)
    
users = load_users()
messages = {}

@app.route("/delete")
def delete():
    messages={}
    return jsonify({"response" : 'OK'}),200

@app.route("/delete")
def about():
    return render_template("index.html")

@app.route("/login", methods=['GET', 'POST'])
def login():
    
    username= request.form['username'] 
    password= request.form['password']
    
    for user in users:
        if user['username'] == username and user['password'] == password:
            
            return jsonify({"response" : hash('Python')}),200
        
    return jsonify({"response" : 'login failed'}),404

@socketio.on('incoming-msg')
def on_message(data):
    
    username= data["username"]
    room = data["room"]
    message = data["message"]
    
    time_stamp = time.strftime('%b-%d %I:%M%p')
    msg = {"username": username, "message": message, "datetime": time_stamp}
    if room not in messages.keys():
        messages[room] = [msg]
    else:
        messages[room].append(msg)
    send(msg,room=room)

@socketio.on('join')
def on_join(data):
    """User joins a room"""

    username = data["username"]
    room = data["room"]
    join_room(room)
    if(room in messages.keys()):
        send(messages[room])
    
    time_stamp = time.strftime('%b-%d %I:%M%p')
    msg = {"username": username, "message": username + " Joined conversation.", "datetime": time_stamp}
    # Broadcast that new user has joined
    send(msg, room=room,include_self=False)

@socketio.on('leave')
def on_leave(data):
    """User leaves a room"""

    username = data['username']
    room = data['room']
    leave_room(room)
    
    time_stamp = time.strftime('%b-%d %I:%M%p')
    msg = {"username": username, "message": username + " Left conversation.", "datetime": time_stamp}
    # Broadcast that user left
    send(msg, room=room,include_self=False)

if __name__ == "__main__":
    app.run(debug=True)

