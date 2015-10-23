# This is my demostration for naming-convention error on rails
##Background
In English, noun in sungular that ending with `fe` will be transformed to `ves` in plural.

For example: `cafe` -> `caves` or `wife` -> `wives`.
## What do rails does?
When you name your model with the `ve`-ending (like `thank_give` on this project).
Your `model` in plural is `ThankGives`, and rails treats the singular as `ThankGife` (not `ThankGive` as expected).

To get list all `models` in rails app, run this snip-code on `rails console`:
```
ActiveRecord::Base.connection.tables.map do |model|
  model.capitalize.singularize.camelize
end
```
Example:

```ruby
irb(main):001:0> ActiveRecord::Base.connection.tables.map do |model|
irb(main):002:1*   model.capitalize.singularize.camelize
irb(main):003:1> end
=> ["SchemaMigration", "ThankGife", "User"]
```
## Exploring the error
### Relationship
One `ThankGive` belongs to one `User`.
One `User` has many `ThankGive`.
### Expecations
Create database and then seed it:
```
$ rake db:create db:migrate
$ rake db:seed
Creating User
Creating ThankGive
```
Go to `rails console` and see what happen:
```
$ rails c
```
#### One `ThankGive` belongs to one `User`
```
irb(main):001:0> ThankGive.first.user
  ThankGive Load (0.4ms)  SELECT  `thank_gives`.* FROM `thank_gives`  ORDER BY `thank_gives`.`id` ASC LIMIT 1
  User Load (0.3ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 1 LIMIT 1
=> #<User id: 1, name: "CQBinh", created_at: "2015-10-23 02:33:25", updated_at: "2015-10-23 02:33:25">
```
OK, but...
#### One `User` has many `ThankGive`
```
irb(main):002:0> User.first.thank_gives
  User Load (0.5ms)  SELECT  `users`.* FROM `users`  ORDER BY `users`.`id` ASC LIMIT 1
NameError: uninitialized constant User::ThankGife
```
