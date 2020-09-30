# README

Ruby version 2.7.1

for start this app run:

$ docker-compose up dev

is it nesessary to install some dependensies, use:

$ docker-compose run dev bundle install
$ docker-compose run dev bundle update

Afret that, create database:

$ docker-compose run dev rake db:create
$ docker-compose run dev rake db:migrate (if nesessary)


You can find rails app server on localhost:3000

You can find pgadmin on localhost:4001
For connection to pgadmin use next settings (also you can set it in docker-compose.yml file):
login: test@1.com
password: 123

In pgadmin for connect to DB create server and use next settings:
- host name/adress: db
- port: 5432 (according docker-compose settings)
- maintenance database: postgres
- password: /.. empty field ../
 

Start build with rails server and use bot

$ docker-compose up dev


To starting application on Amazon Cloud9 please check next configuration:
- ./config/environments/development.rb
      config.hosts << "c7c0e963d21a452eaa23596002aaa9b9.vfs.cloud9.eu-central-1.amazonaws.com" # set your own cloud9 host
- ./config/webpacker.yml
  dev_server:
    host: ...
    port: ...
    public: ...
# configure this values for webpacker here


To start app on Amazon Cloud9 use command

$ rails server  #- to starting rails 

$ bin/webpack-dev-server  #- to starting webpacker

You must start rails server and webpack-dev-server together (if you use webpacker:vue like frontend, not Rails ActionView)