from flask import Flask, request

app = Flask(__name__)

@app.route('/<cluster>')

def index(cluster):
    name = request.args.get('name')
    action = request.args.get('action')
    return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(cluster,name,action) 

