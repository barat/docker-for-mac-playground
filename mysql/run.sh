#!/bin/bash
echo  -n "Waiting for database connection..."
until nc -z -v -w30 mysql-test 3306
do
  echo  -n '.'
  # wait for 5 seconds before check again
  sleep 5
done
sysbench --test=oltp --oltp-table-size=10000 --mysql-host=mysql-test --mysql-db=test --mysql-user=root --mysql-password=passwd prepare;
sysbench --test=oltp --oltp-table-size=10000 --mysql-host=mysql-test --mysql-db=test --mysql-user=root --mysql-password=passwd --max-time=60 --oltp-read-only=off --max-requests=0 --num-threads=1 run;
sysbench --test=oltp --mysql-host=mysql-test --mysql-db=test --mysql-user=root --mysql-password=passwd cleanup;