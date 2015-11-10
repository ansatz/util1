#!/usr/bin
#-----------------------------------------------------
# -- about
# run ipython from current directory 
# docker images of vncx, vim compile with python, python stack, and IPython

# -- refs
#http://superuser.com/questions/628371/how-to-run-linux-remmina-from-the-terminal
#----------------------------------------------------

#init
echo $(pwd)
source ~/.bashrc

tput setaf 1;
echo '-----starting docker vncx-----'
tput sgr0;

(drm vncx && sleep 2) || :  #try catch behaviour, ':' is like finally 

docker run -p 5900 --name vncx -e HOME=/ creack/firefox-vnc x11vnc -forever -usepw -create &

tput setaf 1; echo '-----starting remmina-----'; tput sgr0;
rconfig='/home/solver/.remmina/1446866243896.remmina'

#rconfig='14.remmina'
sleep 2
vncip=`docker inspect vncx | grep IPAddress | awk '{l=length($2);ll=l-3;print substr($2,2,ll)}'`
v_ip="server="$vncip":5900"
tput setaf 2; echo $v_ip; tput sgr0;

# "rconfig" w/o quotes multi-lines reads as single; single not expand
awk -v ip="$v_ip" '{ if ($1 ~ /^server/) {$0=ip; print ip;} else print $0}' $rconfig > 15.tmp && mv 15.tmp $rconfig 

remmina -c $rconfig &


tput setaf 1; echo '-----starting docker vpy-----'; tput sgr0;
(drm vpy && sleep 2) || :

docker run -d -p 80:8888 -v $(pwd):/notebooks  -e "PASSWORD=pie" --name vpy --link vncx:vncx -e "USE_HTTP=1" vim-python:latest
sleep 2

vimip=`docker inspect vpy | grep IPAddress | awk '{l=length($2);ll=l-3;print substr($2,2,ll)}'`
tput setaf 1; echo '-----docker ipython-vim shell-----'; 
echo 'psgrep remmina'
tput sgr0
eip='echo sudo firefox ' $vimip':8888/'
tput setaf 2; echo $eip; tput sgr0 #use ; instead of && so if error text still show

docker exec -i -t vpy /bin/bash


