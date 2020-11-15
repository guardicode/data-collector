@echo off
echo ----------hostname----------
hostname
echo ----------ipconfig----------
ipconfig /all
echo ----------tasklist----------
tasklist
echo ----------netstat 1----------
netstat -a -n -o -b
ping 127.0.0.1 -n 60 > NUL
for /l %%x in (2, 1, 5) do (
   echo ----------netstat %%x----------
   netstat -n -o -b
   ping 127.0.0.1 -n 60 > NUL
)
