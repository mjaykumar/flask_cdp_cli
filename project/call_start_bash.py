import subprocess
q_e_name = "demo-us-cdp-dl"
subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_datalake_startStop.sh' , q_e_name , 'start'])

