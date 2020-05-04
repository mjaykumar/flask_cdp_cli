from flask import Flask, request, jsonify

app = Flask(__name__)

#@app.route('/<en_describe>')
#def index(en_describe):
@app.route('/cdp_api/en_describe')
def en_describe():
    import subprocess
    q_e_type = request.args.get('etype')
    q_e_name = request.args.get('ename')
    subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_describe.sh' , q_e_type , q_e_name])
    result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_describe.sh' , q_e_type , q_e_name])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    json_output = jsonify(result.decode()) #return json output
    return json_output


@app.route('/cdp_api/en_list')
def en_list():
    import subprocess
    q_e_type = request.args.get('etype')
    subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , q_e_type])
    result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , q_e_type])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    json_output = jsonify(result.decode()) #return json output
    return json_output

@app.route('/cdp_api/en_status')
def en_status():
    import subprocess
    q_e_type = request.args.get('etype')
    q_e_name = request.args.get('ename')
    subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_status.sh' , q_e_type , q_e_name])
    result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_status.sh' , q_e_type , q_e_name])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    json_output = jsonify(result.decode()) #return json output
    return json_output


@app.route('/cdp_api/dl_start_working')
def dl_start_working():
    import subprocess
    q_e_name = request.args.get('ename')
   # subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'start'])
    result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'start'])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    json_output = jsonify(result.decode()) #return json output
    return json_output


@app.route('/cdp_api/dl_stop_working')
def dl_stop_working():
    import subprocess
    q_e_name = request.args.get('ename')
    #subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'stop'])
    result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'stop'])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    json_output = jsonify(result.decode()) #return json output
    return json_output


@app.route('/cdp_api/dl_start')
def dl_start():
    import subprocess
    q_e_name = request.args.get('ename')
    result = subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'start'])
    #result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'start'])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    #json_output = jsonify(result.decode()) #return json output
    #return json_output
    #return result
    if result == 0:
       status = "Success"
    else:
       status = "Failure"
    print(status)
    return status






@app.route('/dl_stop_no_server_logs')
def dl_stopno_server_logs():
    import subprocess
    q_e_name = request.args.get('ename')
    result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'stop'])
    json_output = jsonify(result.decode()) #return json output
    return json_output



@app.route('/cdp_api/dl_stop')
def dl_stop():
    import subprocess
    q_e_name = request.args.get('ename')
    result = subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'stop'])
    #result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'stop'])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    #json_output = jsonify(result.decode()) #return json output
    #return json_output
    if result == 0:
       status = "Success"
    else:
       status = "Failure"
    print(status)
    return status



@app.route('/cdp_api/dh_stop')
def dh_stop():
    import subprocess
    q_e_name = request.args.get('ename')
    result = subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datahub_startStop.sh' , q_e_name , 'stop'])
    #result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'stop'])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    #json_output = jsonify(result.decode()) #return json output
    #return json_output
    if result == 0:
       status = "Success"
    else:
       status = "Failure"
    print(status)
    return status


@app.route('/cdp_api/dh_start')
def dh_start():
    import subprocess
    q_e_name = request.args.get('ename')
    result = subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datahub_startStop.sh' , q_e_name , 'start'])
    #result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'start'])
    #return '<h1> Entity :  {}  Cluster : {} action : {}</h1>'.format(env,dl,dh) #return string format
    #json_output = jsonify(result.decode()) #return json output
    #return json_output
    #return result
    if result == 0:
       status = "Success"
    else:
       status = "Failure"
    print(status)
    return status


