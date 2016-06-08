Lemon
=====
Lemon uses Mandrill webhooks to capture email event data and performs analytics on data received.


Installation
------------
```
$ git clone https://github.com/GeekG1rl/lemon
$ cd lemon
$ bundle install
$ bin/rake db:create
$ bin/rake db:migrate
```


Running the app
---------------
Open terminal:
```
$ bin/rails s
```

Open another terminal window:
```
$ cd llirdnam-master/llirdnam
$ go run llirdnam.go http://localhost:9000/event
```

Analytics:
```
http://localhost:9000
```


Technologies
------------
* Rails 4.2.6
* ActiveRecord
* PostgreSQL
* RSpec
* Capybara


Ideas for extending the app
---------------------------

* I chose to return analytics data as JSON so other developers can hook in and display as they see fit
