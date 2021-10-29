# employee_development_1
# employee_development2
Employee development program at everyleaf
model Task
controller TasksController
table tasks name:string description text

### How to deploy on Heroku

#### Creation of the app on heroku
$ heroku login
$ heroku create everyleaf-app
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
#### Compile the app and push it on heroku
```
$ rails assets:precompile RAILS_ENV=production
$ git add -A
$ git commit -m "update"
$ git push heroku master
