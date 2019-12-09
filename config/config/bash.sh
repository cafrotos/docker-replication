#!/bin/bash
BASE_PATH=$(dirname $0)

echo "Waiting for mysql to get up"
# Give 60 seconds for master and slave to come up
sleep 10

echo "Create MySQL Servers (master / slave repl)"
echo "-----------------"
# 
# 
# 
# Reset all slave on 2 slave server
echo "* Reset all slave on 2 slave server"
# slave 1
mysql --host slave1 -uroot -p$MYSQL_ROOT_PASSWORD -AN -e 'STOP SLAVE;';
mysql --host slave1 -uroot -p$MYSQL_ROOT_PASSWORD -AN -e 'RESET SLAVE ALL;';
# slave 2
mysql --host slave2 -uroot -p$MYSQL_ROOT_PASSWORD -AN -e 'STOP SLAVE;';
mysql --host slave2 -uroot -p$MYSQL_ROOT_PASSWORD -AN -e 'RESET SLAVE ALL;';

# 
# 
# 
#  Create replication user
echo "* Create replication user"
# for slave 1
mysql --host master -uroot \
  -p$MYSQL_ROOT_PASSWORD -AN \
  -e "GRANT REPLICATION SLAVE ON *.* TO '$SLAVE1_REPLICATION_USER'@'%' IDENTIFIED BY '$REPLICATION_PASSWORD';"
mysql --host master -uroot \
  -p$MYSQL_ROOT_PASSWORD -AN -e 'FLUSH PRIVILEGES;'
# for slave 2
mysql --host master -uroot \
  -p$MYSQL_ROOT_PASSWORD -AN \
  -e "GRANT REPLICATION SLAVE ON *.* TO '$SLAVE2_REPLICATION_USER'@'%' IDENTIFIED BY '$REPLICATION_PASSWORD';"
mysql --host master -uroot \
  -p$MYSQL_ROOT_PASSWORD -AN -e 'FLUSH PRIVILEGES;'

# 
# 
# 
# Get MASTER_LOG_POS and MASTER_LOG_FILE from master server
echo "* Get MASTER_LOG_POS and MASTER_LOG_FILE from master server"
MASTER_LOG_POS=$(eval "mysql --host master -uroot \
  -p$MYSQL_ROOT_PASSWORD -e 'show master status \G' | grep Position | sed -n -e 's/^.*: //p'")
MASTER_LOG_FILE=$(eval "mysql --host master -uroot \
  -p$MYSQL_ROOT_PASSWORD -e 'show master status \G' | grep File | sed -n -e 's/^.*: //p'")

# 
# 
# 
# 
# Login replica user in slave server
echo "* Login replica user in slave server"
# slave 1
mysql --host slave1 -uroot \
  -p$MYSQL_ROOT_PASSWORD -AN -e "CHANGE MASTER TO master_host='master', master_port=3306, \
  master_user='$SLAVE1_REPLICATION_USER', master_password='$REPLICATION_PASSWORD', \
  master_log_file='$MASTER_LOG_FILE',
  master_log_pos=$MASTER_LOG_POS;"
# slave 2
mysql --host slave2 -uroot \
  -p$MYSQL_ROOT_PASSWORD -AN -e "CHANGE MASTER TO master_host='master', master_port=3306, \
  master_user='$SLAVE2_REPLICATION_USER', master_password='$REPLICATION_PASSWORD', \
  master_log_file='$MASTER_LOG_FILE', 
  master_log_pos=$MASTER_LOG_POS;"

# 
# 
# 
# Start both Slave Servers
echo "* Start both Slave Servers"
mysql --host slave1 -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "START SLAVE;"
mysql --host slave2 -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "START SLAVE;"

echo "* Get status slave"
mysql --host slave1 -uroot -p$MYSQL_ROOT_PASSWORD -e "show slave status \G"
mysql --host slave2 -uroot -p$MYSQL_ROOT_PASSWORD -e "show slave status \G"

echo "MySQL servers created!"
echo "--------------------"

mysql --host master -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "source /tmp/startup.sql"