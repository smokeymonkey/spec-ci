* spec-ci 
spec-ci is testing configspec on docker use serverspec. 
* ~/.ssh/config sample 
Host docker 
  HostName      172.17.42.1 
  Port          54322 
  User          ec2-user 
  IdentityFile  ~/.ssh/mykey.pem 
  StrictHostKeyChecking no 
  UserKnownHostsFile /dev/null 
