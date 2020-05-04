import subprocess

q_e_type = "dl"
q_e_name = "demo-us-cdp-dl"
#result = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_describe.sh' , q_e_type , q_e_name])
subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_describe.sh' , q_e_type , q_e_name])
#print(result)
