#!/bin/bash


# generate the key
if [ -f /etc/pki/keystore ]
then
echo "file already exist"
else
keytool -genkey -alias replserver \
    -keyalg RSA -keystore /opt/keystore \
    -dname "CN=wcwe, OU=Paradigm, O=Quantela, L=Hyd, S=Hyd, C=IN" \
    -storepass Test1234 -keypass Test1234
sleep 10
chmod 664 /opt/keystore
fi

sed -i '/               redirectPort="8443"/a\    <Connector\n\           protocol="org.apache.coyote.http11.Http11NioProtocol"\n\           port="8443" maxThreads="200"\n\           scheme="https" secure="true" SSLEnabled="true"\n\           keystoreFile="/opt/keystore" keystorePass="Test1234"\n\           clientAuth="false" sslProtocol="TLS"/>' /opt/tomcat/conf/server.xml

cd /opt/tomcat/bin/
./catalina.sh start

#sleep 20
#sed -i 's/mongo.hosts=.*/mongo.hosts=172.17.0.2/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/mongo.ports=.*/mongo.ports=27017/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/mongo.dbName=.*/mongo.dbName=atlantisdb/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/mongo.username=.*/mongo.username=atlantisuser/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/mongo.password=.*/mongo.password=E48uAUMhuk/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties

#sed -i 's/atlantis.host=.*/atlantis.host=172.17.0.2/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/atlantis.port=.*/atlantis.port=8443, 8080/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties

#sed -i 's/postgre.host=.*/postgre.host=172.17.0.2/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/postgre.port=.*/postgre.port=5432/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/postgre.dbName=.*/postgre.dbName=atlantisdb/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/postgre.username=.*/postgre.username=sysadmin/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties
#sed -i 's/postgre.password=.*/postgre.password=test123/'  /opt/tomcat/webapps/atlantis-analytics/WEB-INF/classes/config.properties


tail -f /opt/tomcat/logs/catalina.out

