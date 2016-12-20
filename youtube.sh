cd /
clear && clear
#create password
passwd
#install x2go
apt-get update && apt-get -y install aptitude
sudo apt-get install apt-transport-https
apt-get install openssl
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
#install youtube-dl
pip install youtube-dl
#folder upload
mkdir /root/upload
cd /root/upload
echo "1p" > start.txt
curl https://github.com/nurd1n/LEMP-Wordpress/raw/secret/youtube-start.sh -o start.sh
mkdir data
mkdir data/description
mkdir data/thumbnail
touch data/url
touch data/title
touch data/tags
touch data/privacy
touch data/playlist
mkdir secret
touch secret/client.json
touch secret/channel.json
#install chrome
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install
#install names
pip install names
#install youtube-upload
pip install --upgrade google-api-python-client progressbar2
curl -L https://github.com/tokland/youtube-upload/archive/master.zip -o master.zip
unzip master.zip
cd youtube-upload-master
python setup.py install
cd /tmp
#install Utorrent
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/utserver.tar.gz -o utserver.tar.gz
tar xvzf utserver.tar.gz -C /tmp/
cd /tmp/utorrent*
unzip ./webui.zip
sudo su
chown -R root:root /tmp/utorrent*
mv /tmp/utorrent* /opt/utorrent
cd /opt/utorrent
sudo ./utserver
