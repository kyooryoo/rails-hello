## Create a rails project
1. navigate to the location where will hold the project.
2. create a folder for the new project with: mkdir <new_project>
3. navigate to the project folder with: cd <new_project>
4. create the new application with: rails new <new_app>

## Intro to MVC
* rails uses Model, View, and Controller, the MVC web development framework
* user request is handled by router, passed to Controller
* controller generate the view or after getting models involved
* model update or retrieve data from a database, and feedback to controller
* core components of MVC have multiple instances, in subfolder within app folder
* router is defined by the file routes.rb within config folder

## Create some pages
* run the rails server with: rails server

* go to http://localhost:3000/welcome/home, confirm the page does not exist
* next steps will create a "welcome" controller with a "home" action
* check currently available routes with: rails routes
* add one line of code in routes.rb: get 'welcome/home', to: 'welcome#home'
* check currently available routes again with: rails routes
* go to http://localhost:3000/welcome/home, confirm the error has changed
* create "welcome_controller.rb" and create a class "WelcomeController":
* go to http://localhost:3000/welcome/home, confirm the error has changed
* back to the controller "welcome_controller.rb" and define a method "home"
* go to http://localhost:3000/welcome/home, confirm there is a new error
* go to "views" folder and create a "welcome" folder with "home.html.erb"
* Input a H1 tag in the file: <h1>This is the Welcome homepage</h1>
* go to http://localhost:3000/welcome/home, confirm the page now works

* follow the same steps above to create a "about" page
* go to http://localhost:3000/welcome/about, confirm the about page works

## Create some links
* go to "home.html.erb" and add a line to Home page with following code:
<%= link_to 'Home', welcome_home_path %>
* here, the <% and %> starts and ends the ruby code within html templates
* the = following the <% ask rails to render the ruby code after evaluation
* the 'Home' is the text content of the link that is shown to the user
* the "welcome_home" is the path name from the prefix field of: rails routes

* follow the same steps above to create a "Home" link in the about template

## Adjust the routes
* to have home page as the real home page and the about page under it
* change routes settings in routes.rb to:
root to: 'welcome#home'
get 'about', to: 'welcome#about'
* check currently updated routes with: rails routes
* update the link settings in Home and About page templates accordingly

## Apply version control
* check the installed git: "git --version" and "git config --list"
* use following code to config git if not done before:
git config --global user.name "Your Name"
git config --global user.email "youremail@yourcompany.com"
* rails v5 creates projects with a Git repo by default, no need to: git init
* check current repo status with: git status
* start to track all files with: git add -A
* check current repo status and confirm all files are tracked: git status
* commit with some comment: git commit -m "some comment"
* check repo status to confirm the commit is done: git status
* demo an accident of deletion: rm -rf config
* check current repo status after deletion: git status
* recover deleted file with: git checkout -f
* check repo status after recovery with: git status

## Use online collaboration repo
* prepare a GitHub or a Bitbucket account, we use GitHub from here on
* use pub key instead of username and password for auth with following steps:
1. get local pub key: cat ~/.ssh/id_rsa.pub, and copy it
2. go to GitHub account profile, under settings, SSH and GPG keys, add it
* create a new repo on GitHub and choose SSH as the repo link
* use the two lines of sample scrips for pushing an existing repo
* push further change: "git Add -A", "git commit -m 'xxx'", and "git push"

## Publish to Heroku
* as Heroku does not support sqlite3, check its gem is in dev group in Gemfile
* add a production group in Gemfile, and add gem 'pg' within this group
* update Gemfile.lock with: bundle install --without production
* verify the installation of Heroku: heroku --version
* login Heroku and create an app: "heroku login" and "heroku create"
* make sure local change is committed and pushed to remote GitHub repo
* add local public key to Heroku: heroku keys:add
* push to Heroku: git push heroku master
* open the app with the returned URL after this push
* optionally, app name could be renamed: heroku rename <app_new_name>

## Add some DB features
* use rails scaffold feature to prepare a migration for creating a table:
rails generate scaffold Article title:string description:text
* run a migration to create the table: rails db:migrate
* go to http://localhost:3000/articles to check out-of-box features

### manually create a new users table in database with following steps
1. prepare a migration file: rails generate  migration create_users
2. go to db/migrate edit newly created file with add: t.string :username
3. back to console to deploy the migration: rails db:migrate
4. check the schema.rb file in db folder that new users table is there

* actually, there are two options for adding email attribute the users table
a. rollback the previous migration, update the migration file and deploy again
1) rollback: rails db:rollback, check the schema.rb that users table is dropped
2) update the migration file by adding:
t.string :email
t.timestamps
3) deploy the migration again: rails db:migrate
4) check schema.rb file that this change to users table has been applied
b. as the best practice, fix the mistake with a new migration but not rollback
1) create a new migration: rails generate migration add_attributes_to_users
2) add following code to the change method in this new migration file:
add_column :users, :email, :string
add_column :users, :created_at, :datetime
add_column :users, :updated_at, :datetime
3) deploy the migration with: rails db:migrate
4) check the modification is applied to users table in schema.rb file

5. create model file "user.rb" within app/models folder
6. add following code to the model file user.rb or the class User:
class User < ApplicationRecord
end
* after creating the model, we get database access feature from rails by default
7. go to rails console to test out the database access feature: rails console
1) test connection to the users table with: User.all
2) check the User class definition with: User
3) create an empty user instance with: user = User.new
4) assign value to attribute with: user.username = "Bill Gates"
5) assign value to another attribute with: user.email = "billgates@comapny.com"
6) check the change of the instance attributes: user
7) save new instance to the database: user.save
8) check the update of users table with: User.all
* alternatively, we can instantiate with attribute values directly
1) user = User.new(username: "Steve Jobs", email: "stevejobs@comapny.com")
2) user.save
* alternatively, we can create a table record without instantiation
1) User.create(username: "Elon Musk", email: "elonmusk@company.com")

### modify the attribute of a table record
1. check all records in the target table: User.all
2. grab the target record with id: user = User.find(2)
3. edit the email of this record: user.email = "stevejobs@apple.com"
4. save the change to the database: user.save
5. check the change in table: User.all

### delete a record from a table
1. find the id of the target record: User.all
2. grab the target record to delete: user = User.find(2)
3. delete the record with destroy method: user.destroy
4. check the change to the table: User.all

### apply data validation to data input
1. add following code to the user.rb model file:
validates :username, presence: true, length: { minimum: 3, maximum: 50 }
validates :email, presence: true, length: { minimum: 3, maximum: 50 }
2. reload the rails console or restart the rails console: reload!
3. try adding an empty user into table:
user = User.new
user.save
4. check if there is any error and the error detail:
user.errors.any?
user.errors.full_messages
5. try adding a user with invalid attributes into table and check the error:
user = User.new(username: "a", email: "b")
user.save
user.errors.full_messages

## manually build the UI for data access
* if use scaffold generation, then the work is done automatically
1. add one line of code into routes.rb in config: resources :users
* this one line code above add many default paths into routes
* use "rails routes" before and after adding this code to check the change
2. go to http://localhost:3000/users/new to check the error about the Controller
3. create "users_controller.rb" controller file within app/controllers folder
class UsersController < ApplicationController
  def new
    @user = User.new
  end
end
4. go to http://localhost:3000/users/new to check the error of missing templates
5. create "new.html.erb" within newly created "users" folder in "views" folder
<h1>Create a User</h1>
6. go to http://localhost:3000/users/new to check the page works somehow
7. add following code into "new.html.erb" to create a form for data input:
<%= form_for @user do |f| %>
  <p>
    <%= f.label :username %>
    <%= f.text_field :username %>
  </p>

  <p>
    <%= f.label :email %>
    <%= f.text_field :email %>
  </p>

  <p>
    <%= f.submit %>
  </p>
<% end %>
8. go to http://localhost:3000/users/new to check the page has a form now
9. click the "Create User" to check the error
10. go to "users_controller.rb" and add a place holder "create" method:
def create
  render plain: params[:user].inspect
end
11. go to users/new page to submit the form and check the data passed in
12. update the create method in users controller:
def create
  #render plain: params[:user].inspect
  @user = User.new(user_params)
  @user.save
end
13. still within users controller, create a method to whitelist input params
private
  def user_params
    params.require(:user).permit(:username, :email)
  end
14. go to http://localhost:3000/users/new and submit some data
15. go to rails console check data input was successful with: User.all
* there is no template defined for create, so nothing to show after data input
16. check routes: rails routes, there is a user#show action with prefix user
* use the controller#action, and prefix_path to create the show after data input
17. Update the create action in user controller with:
def create
  @user = User.new(user_params)
  if @user.save
    redirect_to user_path(@user)
  else
    render :new
  end
end
* we use if to check if data input pass the validation or not
* if it passes, we redirect to another view to show the created user
* if not, we render the new page with the form for user input again
18. user_path direct to user#show action, so we need to create a show method:
def show
  @user = User.find(params[:id])
end
* this action will pass target user to the view of "show"
* params of id could be used here because of URL Pattern, check rails routes
19. create "show.html.erb" to show the created user in "views/user" folder:
<h1>Showing selected user</h1>
<p>Username: <%= @user.username %></p>
<p>Email: <%= @user.email %></p>
* this view catches the user object from controller and display its attributes

## improve the usability
1. show some notice after new user is created, update create action as follows:
def create
  @user = User.new(user_params)
  if @user.save
    flash[:notice] = "New user created!"
    redirect_to user_path(@user)
  else
    render :new
  end
end
* this newly added flash should be handled somewhere
2. go to app/views/layouts/application.html.erb and update the body tag:
<body>
  <% flash.each do |name, msg| %>
    <ul>
      <li><%= msg %></li>
    </ul>
  <% end %>
  <%= yield %>
</body>
* this file wrap any view and will handle the flash message
3. next, add code in "new" view to display data input validation errors
<% if @user.errors.any? %>
<h2>Following errors happened!</h2>
<ul>
  <% @user.errors.full_messages.each do |msg| %>
  <li><%= msg %></li>
  <% end %>
</ul>
<% end %>
4. test creating a new user or making some errors
