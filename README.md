# db_model

Light model for mapping data from databases  

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  db_model:
    github: tbrand/db_model
```

## Usage

```crystal
require "db_model"

# define mapped model
db_model User, id : Int32, account_name : String, passhash : String

# open db as usual
db = DB.open("some uri") # typeof(db) is DB::Database

# get array of users by arbitary queries
users = User.query(db, "select * from users") # Array(User)

user = users.first
user.to_json # => {"id": 1, "name": "test", "passhash": "abcde"}

created = User.from_json("{\"id\": 2, \"name\": \"test\", \"passhash\": \"fgehik\"}")
created.id # => 2
created.name # => "name"
```

You can use this feature as cache.
For example, when you have redis instance
```crystal

redis = Redis.new
redis.set("user_1", user.to_json)

...

user = User.from_json(redis.get("user_1"))
```

## Contributing

1. Fork it ( https://github.com/tbrand/db_model/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tbrand](https://github.com/tbrand) Taichiro Suzuki - creator, maintainer
