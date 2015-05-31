# Todo_List

This is a functioning todo list app, with no known bugs (as of 05/31/15).
Using this you can add/edit/delete/view your own todos in one interactive place.
This project uses an sqlite3 database along with the ActiveRecord gem.

```
## Do the following in order to have your very own todo list!

(1) Fork this repo
(2) Clone this repo

## Do the Following steps from within the todo_list directory

(1) run `bundle install`
(2) `rake db:migrate` to run the migration and update the database
(3) run `ruby lib/todo_list.rb` to start the application
(4) Time todo some stuff
```


# Todo_List Tree

```

todo_list
    ├── Gemfile            # Details which gems are required by this project
    ├── Gemfile.lock       # File detailing which versions of gems are being used
    ├── README.md          # This file
    ├── Rakefile           # Defines `rake generate:migration` and `db:migrate`
    ├── config
    │   └── database.yml   # Defines the database configuration
    ├── console.rb         # `ruby console.rb` starts `pry` with models loaded
    ├── db
    │   ├── dev.sqlite3    # Default location of the database file
    │   ├── migrate        # Folder containing generated migrations
    │   │   └── 20150530110605_add_todo.rb     # Generated migration for TodoList table
    │   └── setup.rb       # `require`ing this file sets up the db connection
    └── lib
        ├── all.rb         # Require this file to auto-require _all_ `.rb` files in `lib`
        ├── todo.rb        # Ruby file containing model that inherits from ActiveRecord::Base
        └── todo_list.rb   # Ruby file containing the code necessary for application to run
```

# Credits

 This project was started using the <a href="https://github.com/tiy-austin-ror-may2015/model-skeleton">skeletal-framework</a> template provided by Justin Herrick.

 This project began by using the <a href ="https://github.com/jah2488/todo-csv">todo-list</a> program provided by Justin Herrick as a starting point.
