cd /
clear && clear
#install x2go
sudo apt-get install apt-transport-https
apt-get update && apt-get -y install aptitude
apt-get install gawk python-setuptools software-properties-common
sudo add-apt-repository ppa:x2go/stable
apt-get update
sudo apt-get install x2goserver x2goserver-xsession
apt-get install xorg lxde-core
#install yg diperlukan
sudo apt-get install at ffmpeg midori firefox bleachbit gedit terminator filezilla libimage-exiftool-perl unzip python-pip
#install mechanize & beautifulsoup
easy_install mechanize
easy_install BeautifulSoup4
#install names
pip install names
#install Utorrent
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/utserver.tar.gz -o utserver.tar.gz
tar xvzf utserver.tar.gz -C /tmp/
cd /tmp/utorrent* && unzip ./webui.zip
sudo su
chown -R root:root /tmp/utorrent*
mv /tmp/utorrent* /opt/utorrent
apt-get install openssl
cd /opt/utorrent && sudo ./utserver
