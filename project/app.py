from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/<cluster>')

def index(cluster):
    import subprocess
    env = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'env']) 
    dl = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'dl'])
    dh = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'dh'])
    subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'env'])
    subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'dl'])
    subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'dh'])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    json_output = jsonify(env.decode(),dl.decode(),dh.decode()) #return json output
    return json_output
