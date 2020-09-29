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
