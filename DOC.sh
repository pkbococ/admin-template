# Configurar emulador de terminal como login-shell desde la interface

# Linux Mint 21.1 setup
sudo apt-get install build-essential autoconf automake gdb git libxml2 libxml2-dev libffi-dev zlib1g-dev libssl-dev bash curl gnupg2 rubygems ruby-dev libxslt-dev libcurl4-openssl-dev nodejs npm software-properties-common

cd $HOME
freetds_element=$(wget http://www.freetds.org/software.html -q -O - | grep "Last stable release")
freetds_download=$(echo "$freetds_element" | cut -d'"' -f 2)
wget $freetds_download --output-document=freetds.tar.gz
mkdir .freetds
tar -xzf freetds.tar.gz -C .freetds --strip-components=1
cd $HOME/.freetds
./configure --prefix=/usr/local --with-tdsver=7.3
sudo make
sudo make install

sudo npm install --global yarn

gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
command curl -sSL https://rvm.io/mpapis.asc | sudo gpg2 --import -
command curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg2 --import -
rvmsudo rvm get stable --auto-dotfiles
rvm fix-permissions system
rvm group add rvm $USER
sudo reboot 0

openssl version
# Instalar para openssl >= 3
rvm pkg install openssl
rvm install ruby-2.7.1 --with-openssl-dir=$HOME/.rvm/usr

# Instalar para openssl < 3
rvm install ruby-2.7.1

# De ser reinstalación...
cd Workbench/template
yarn install --check-files

# Project setup
gem install rails -v '6.0.3.2' -V --no-document
rails _6.0.3.2_ new template
cd template
git config pull.rebase false
gem install bundler
bundle install

rails g controller home index
yarn add admin-lte@3.0.5 jquery popper.js
yarn add @fortawesome/fontawesome-free
rails webpacker:install

# gem 'devise', '~> 4.9', '>= 4.9.2'
bundle install
rails generate devise:install
rails generate scaffold User employee_id:string{10} name:string{400} email:string{150} active:boolean developer:boolean
rake db:migrate RAILS_ENV=development
rails generate devise User
rake db:migrate RAILS_ENV=development
