https://docs.cloudera.com/management-console/cloud/cli/topics/mc-install-cdp-client-on-linux.html
Notes : --
cdp datalake start-datalake --datalake-name  demo-us-cdp-dl
cdp datalake stop-datalake --datalake-name  demo-us-cdp-dl
cdp datalake list-datalakes | jq '.datalakes[] | .status'
cdp datalake list-datalakes | jq '.datalakes[].status'
cdp datalake describe-datalake --datalake-name "demo-us-cdp-dl" | jq -r .datalake.status
 
 

cdp environments list-environments | jq '.environments[].status'
cdp environments list-environments | jq '.environments[] | .status'
cdp environments list-environments | jq '.environments[] | .status'


cdp environments  describe-environment --environment-name directconnect-us-cdp  | jq -r '.environment.status'
------------------

mkdir ~/flaskcdp
virtualenv ~/flaskcdp --no-site-packages

source ~/flaskcdp/bin/activate
~/flaskcdp/bin/pip install cdpcli
~/flaskcdp/bin/pip install flask
~/flaskcdp/bin/pip install --upgrade cdpcli
~/flaskcdp/bin/pip install --upgrade flask
 cdp datalake describe-datalake --datalake-name directconnect-us-cdp-dl
cdp datahub describe-cluster --cluster-name demo-us-cdp-de | jq -r '.cluster.status' 	
datahub :
------------------------------

cdp datahub describe-cluster --cluster-name demo-us-cdp-de | jq -r '.cluster.status' 


ML :
------------

cdp ml list-workspaces | jq -r '.workspaces[]."instanceName"'

"instanceName": "	",
            "environmentName": "demo-us-cdp",


 --environment-name  (string)  The  environment  for  the  workspace  to
       describe.

       --workspace-name 


------------------------------------------------------------------



virtualenv ~/flaskcdp --no-site-packages
source ~/flaskcdp/bin/activate
cdp --version
~/flaskcdp/bin/pip install flask
cdp --version
flask --version
deactivate

export FLASK_APP=app.pi
flask run
curl -i "localhost:5000/api/foo?a=hello&b=world"
curl -i "http://localhost:5000/jayq"

export FLASK_APP=myapp
export FLASK_ENV=development
flask run
	
	
	curl -i "http://localhost:5000/dl?name=demo-us-cdp-dl&action=start"
	http://localhost:5000/dl?name=demo-us-cdp-dl&action=start
	10.10.29.51
	http://10.10.29.51:5000/dl?name=demo-us-cdp-dl&action=start
	
	curl -i "http://10.10.29.51:5000/dl?etype=dl&ename=demo-us-cdp-dl"
