import subprocess
#subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'env'])
#subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'dl'])
#subprocess.call(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'dh'])
dh = subprocess.check_output(['sh' , '/home/centos/project/cli/iqvia/python_cli/cdp_entity_list.sh' , 'dh'])
print(dh.decode())
print(type(dh.decode()))
