from jenkinsapi.jenkins import Jenkins


jenkinsurl = 'http://http://10.1.94.108:8080/'
jenkinsuser = 'admin'
jenkinspassword = 'admin'

server = jenkins.Jenkins(jenkinsurl, username=jenkinsuser, password=jenkinspassword)
user = server.get_whoami()
version = server.get_version()
print('Hello %s from Jenkins %s' % (user['fullName'], version))
