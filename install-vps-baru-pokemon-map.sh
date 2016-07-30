cd /
clear && clear
apt-get update
sudo apt-get install apt-transport-https
apt-get -y install aptitude
apt-get install gawk python-setuptools software-properties-common
#install pip
cd /tmp
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install -U pip
#install git
apt-get install git-all
apt-get nodejs npm
#install pokemon go map
cd /home
git clone -b master https://github.com/AHAAAAAAA/PokemonGo-Map
cd PokemonGo-Map
pip install -r requirements.txt
pip install -r requirements.txt --upgrade
pip install --upgrade six
git submodule init
git submodule update
git pull
#install x2go
cd /
echo "deb http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
echo "deb-src http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
curl https://repo.varnish-cache.org/ubuntu/GPG-key.txt | apt-key add - 
echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list
apt-key adv --recv-keys --keyserver keys.gnupg.net E1F958385BFE2B6E
apt-get update
apt-get upgrade
apt-get dist-upgrade
aptitude update && aptitude install x2go-keyring
aptitude install x2goserver
apt-get install xorg lxde-core
#install nginx
sudo -s
nginx=stable
add-apt-repository ppa:nginx/$nginx
apt-get update
apt-get install nginx-extras
#install yg diperlukan
sudo apt-get install at midori bleachbit gedit terminator filezilla unzip
sudo service nginx restart; sudo service php5-fpm restart
clear
