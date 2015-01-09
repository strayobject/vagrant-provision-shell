
echo "CREATE DATABASE raid CHARACTER SET 'utf8';" >> db.sql
echo "grant all on techcal.* to vagrant@localhost identified by 'vagrant';" >> db.sql

mysql -u root -proot < db.sql

