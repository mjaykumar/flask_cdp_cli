from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/<cluster>')

def index(cluster):
    import subprocess
    q_e_type = request.args.get('etype')
    q_e_name = request.args.get('ename')
    subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_describe.sh' , q_e_type , q_e_name])
    result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_describe.sh' , q_e_type , q_e_name])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    json_output = jsonify(result.decode()) #return json output
    return json_output
