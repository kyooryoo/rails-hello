# A hello world ruby on rails project

## Create a rails project
1. navigate to the location where will hold the project
2. create a folder for the new project with:
```
mkdir <new_project>
```
3. navigate to the project folder with:
```
cd <new_project>
```
4. create the new application with:
```
rails new <new_app>
```

## Intro to MVC
* rails uses `Model`, `View`, and `Controller`, the `MVC` web dev framework
* user http request is handled by `router`, then distributed to `controller`
* `controller` generate the `view` or after interaction with `models`
* `model` update or retrieve data from a database, and feedback to `controller`
* core components of MVC have multiple instances, in subfolder within `app` folder
* `router` is defined by the file `routes.rb` within `config` folder

## Create home and about pages
1. run the rails server and check the default page at http://localhost:3000:
```
rails server
```
2. go to http://localhost:3000/welcome/home, check what the error says
3. create a `welcome` controller with a `home` action to fixe the error
4. check currently available routes with:
```
rails routes
```
5. add one line of code in `routes.rb`:
```
get 'welcome/home', to: 'welcome#home'
```
6. check updated available routes again with:
```
rails routes
```
7. go to http://localhost:3000/welcome/home, check the new error message
8. create `welcome_controller.rb` at app/controllers/ with an empty class:
```
class WelcomeController < ApplicationController
end
```
9. go to http://localhost:3000/welcome/home, check the new error message
10. back to the controller `welcome_controller.rb` and define a method `home`
```
def home
end
```
11. go to http://localhost:3000/welcome/home, check the new error message
12. go to `views` folder and create `home.html.erb` within a `welcome` folder
```
<h1>This is the Welcome homepage</h1>
```
13. go to http://localhost:3000/welcome/home, confirm the page now works
14. follow the same steps above to create an `about` page
15. go to http://localhost:3000/welcome/about, confirm the `about` page works

## Create some links
1. go to `home.html.erb` and add a line to Home page with following code:
```
<%= link_to 'Home', welcome_home_path %>
```
* here, the `<%` and `%>` starts and ends the ruby code within html templates
* the `=` following the `<%` ask rails to render the ruby code after evaluation
* the `Home` is the text content of the link that is shown to the user
* the `welcome_home` is the path name from the `prefix` of routes
2. follow the same format above to create a `Home` link in the about template

## Adjust the routes
1. change `home` page to the site level home page with `about` page under it
2. change routes settings in `routes.rb` to:
```
root to: 'welcome#home'
get 'about', to: 'welcome#about'
```
3. check currently updated routes with:
```
rails routes
```
4. update the link in `Home` and `About` view templates to each other

## Apply version control
1. check the installed `git`:
```
git --version
git config --list
```
2. use following code to config git if not done before:
```
git config --global user.name "Your Name"
git config --global user.email "youremail@yourcompany.com"
```
* rails v5 creates projects with a Git repo by default, no need to `git init`
3. check current repo status with:
```
git status
```
4. start to track all files with:
```
git add -A
```
5. confirm all files are tracked:
```
git status
```
6. commit with some comment:
```
git commit -m "some comment"
```
7. confirm the commit is done:
```
git status
```
8. demo an accident of deletion:
```
rm -rf config
```
9. check current repo status after deletion:
```
git status
```
10. recover deleted file before commit:
```
git checkout -f
```
11. check repo status after recovery:
```
git status
```

## Enable online collaboration
1. prepare a `GitHub` or a `Bitbucket` account, we use `GitHub` from here on
2. use pub key instead of username and password for auth with following steps:
a. get local pub key:
```
cat ~/.ssh/id_rsa.pub, and copy it
```
b. go to GitHub `account` profile, under `settings`, `SSH and GPG keys`, add it
3. create a new repo on GitHub and choose SSH as the repo link
4. use the two lines of sample scrips for pushing an existing repo
5. push further change with following code:
```
git Add -A
git commit -m "your comment"
git push
```

## Publish or deply to Heroku
0. prepare a heroku account for deploying project to public
1. as `Heroku` does not support `sqlite3`, check gem in dev group in Gemfile
* rails uses `sqlite3` as the project database by default
2. add a `production` group in `Gemfile`, and add gem `pg` within this group
3. update `Gemfile.lock` with performing following command:
```
bundle install --without production
```
4. verify the installation of Heroku:
```
heroku --version
```
5. login Heroku and create an app:
```
heroku login
heroku create
```
6. make sure local change is committed and pushed to remote GitHub repo
7. add local public key to Heroku:
```
heroku keys:add
```
8. push to Heroku:
```
git push heroku master
```
9. open the app with the returned URL after this push
10. optionally, app name could be renamed with:
```
heroku rename <app_new_name>
```

## Add some DB features
1. use rails `scaffold` feature to prepare a migration for creating a table:
```
rails generate scaffold Article title:string description:text
```
2. run a `migration` to create the table:
```
rails db:migrate
```
* any change to database is known as a `migration`
3. go to http://localhost:3000/articles to check out-of-box features

## manually create pages instead of scaffold
1. prepare a migration file:
```
rails generate  migration create_users
```
2. go to db/migrate, update the `change` method in the migration file:
```
def change
  create_table :users do |t|
    t.string :username
  end
end
```
3. back to console to deploy the migration:
```
rails db:migrate
```
4. check the `schema.rb` file in db folder that new users table is there

* for adding email attribute the users table, there are two options
a. `rollback` the previous migration, update the migration file and deploy again
1) rollback:
```
rails db:rollback
```
check the `schema.rb` that users table is dropped
2) update the migration file by adding:
```
t.string :email
t.timestamps
```
3) deploy migration again:
```
rails db:migrate
```
4) check `schema.rb` file that this change to users table has been applied
b. a bette way, fix the mistake with `a new migration` but not rollback
1) create a new migration:
```
rails generate migration add_attributes_to_users
```
2) add following code to the change method in this new migration file:
```
add_column :users, :email, :string
add_column :users, :created_at, :datetime
add_column :users, :updated_at, :datetime
```
3) deploy the migration with:
```
rails db:migrate
```
4) check the modification is applied to users table in schema.rb file

5. create model file `user.rb` within `app/models` folder
6. add following code to the model file `user.rb`:
```
class User < ApplicationRecord
end
```
* creating the model gets database access feature from rails by default
7. go to rails console to test out the database access feature: ```rails console```
1) test connection to the users table with: ```User.all```
2) check the User class definition with: ```User```
3) create an empty user instance with: ```user = User.new```
4) assign value to attribute with: ```user.username = "Bill Gates"```
5) assign value to another attribute with: ```user.email = "billgates@comapny.com"```
6) check the change of the instance attributes: ```user```
7) save new instance to the database: ```user.save```
8) check the update of users table with: ```User.all```
* alternatively, we can instantiate with attribute values directly
```
user = User.new(username: "Steve Jobs", email: "stevejobs@comapny.com")
user.save
```
* alternatively, we can create a table record without instantiation
```
User.create(username: "Elon Musk", email: "elonmusk@company.com")
```

* the backend database manipulation technic below will be used later
### modify the attribute of a table record
1. check all records in the target table: ```User.all```
2. grab the target record with id: ```user = User.find(2)```
3. edit the email of this record: ```user.email = "stevejobs@apple.com"```
4. save the change to the database: ```user.save```
5. check the change in table: ```User.all```

### delete a record from a table
1. find the id of the target record: ```User.all```
2. grab the target record to delete: ```user = User.find(2)```
3. delete the record with destroy method: ```user.destroy```
4. check the change to the table: ```User.all```

### apply data validation to data input
1. add following code to the `user.rb` model file:
```
validates :username, presence: true, length: { minimum: 3, maximum: 50 }
validates :email, presence: true, length: { minimum: 3, maximum: 50 }
```
2. reload the rails console or restart the rails console: ```reload!```
3. try adding an empty user into table:
```
user = User.new
user.save
```
4. check if there is any error and the error detail:
```
user.errors.any?
user.errors.full_messages
```
5. try adding a user with invalid attributes into table and check the error:
```
user = User.new(username: "a", email: "b")
user.save
user.errors.full_messages
```
* the backend database manipulation technic above will be used later

## manually build the UI for data access
* scaffold does following work automatically with less customization
1. add one line of code into `routes.rb` in `config`: ```resources :users```
* this one line code above add many default paths into routes
* run ```rails routes``` before and after adding this code to check the change
2. go to http://localhost:3000/users/new to check the error about the Controller
3. create `users_controller.rb` controller file within app/controllers folder
```
class UsersController < ApplicationController
  def new
    @user = User.new
  end
end
```
4. go to http://localhost:3000/users/new to check the error about templates
5. create `new.html.erb` within newly created `users` folder in `views` folder
```
<h1>Create a User</h1>
```
6. go to http://localhost:3000/users/new to check the page works somehow
7. add following code into `new.html.erb` to create a form for data input:
```
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
```
8. go to http://localhost:3000/users/new to check the page has a form now
9. click the `Create User` to check the error
10. go to `users_controller.rb` and add a place holder `create` method:
```
def create
  render plain: params[:user].inspect
end
```
11. go to `users/new` page to submit the form and check the data passed in
12. update the `create` method in users controller:
```
def create
  #render plain: params[:user].inspect
  @user = User.new(user_params)
  @user.save
end
```
13. still within users controller, create a method to whitelist input params
```
private
  def user_params
    params.require(:user).permit(:username, :email)
  end
```
14. go to http://localhost:3000/users/new and submit some data
15. go to rails console check data input was successful with: ```User.all```
* there is no template defined for create, so nothing to show after data input
16. check routes: ```rails routes```, there is a `user#show` action with prefix `user`
* use the `controller#action`, and `prefix_path` to create the `show` after data input
17. Update the `create` action in user controller with:
```
def create
  @user = User.new(user_params)
  if @user.save
    redirect_to user_path(@user)
  else
    render :new
  end
end
```
* we use if to check if data input pass the validation or not
* if it passes, we redirect to another view to show the created user
* if not, we render the new page with the form for user input again
18. `user_path` direct to `user#show` action, so we need to create a `show` method:
```
def show
  @user = User.find(params[:id])
end
```
* this action will pass target user to the view of `show`
* params of `id` could be used here because of `URL Pattern`, check rails routes
19. create `show.html.erb` to show the created user in `views/user` folder:
```
<h1>Showing selected user</h1>
<p>Username: <%= @user.username %></p>
<p>Email: <%= @user.email %></p>
```
* this view catches the user object from controller and display its attributes

## improve the usability
1. show some notice after new user is created, update create action as follows:
```
def create
  @user = User.new(user_params)
  if @user.save
    flash[:notice] = "New user created!"
    redirect_to user_path(@user)
  else
    render :new
  end
end
```
* this newly added `flash` should be handled somewhere
2. go to `app/views/layouts/application.html.erb` and update the body tag:
```
<body>
  <% flash.each do |name, msg| %>
    <ul>
      <li><%= msg %></li>
    </ul>
  <% end %>
  <%= yield %>
</body>
```
* this file wrap any view and will handle the `flash` message
3. next, add code in `new` view to display data input validation errors
```
<% if @user.errors.any? %>
<h2>Following errors happened!</h2>
<ul>
  <% @user.errors.full_messages.each do |msg| %>
  <li><%= msg %></li>
  <% end %>
</ul>
<% end %>
```
4. test the result by creating a new user or making some input errors

## add edit feature
1. check rails routes for Prefix, URI Pattern, and Control#Action for user `edit`
* follow URI Pattern to go to http://localhost:3000/users/1/edit check the error
2. go to user controller and create a place holder action of edit:
```
def edit
end
```
* go to http://localhost:3000/users/1/edit check the new error
3. create `edit.html.erb` in app/views/users with a simple head:
```
<h1>Edit existing user</h1>
```
* next steps will use some code from the previous section to fulfill this one
4. update `edit` action in user controller with the same code for show action:
```
def edit
  @user = User.find(params[:id])
end
```
* this find the user with the id params from URI pattern and pass it to view
5. update the edit view with the same code from the show view:
```
<% if @user.errors.any? %>
<h2>Following errors happened!</h2>
<ul>
  <% @user.errors.full_messages.each do |msg| %>
  <li><%= msg %></li>
  <% end %>
</ul>
<% end %>

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
```
* this view shows the detail attributes of the user passed from edit action
6. click the update button in the form of edit page to check its error
* here, the error says we need to create an update action for users controller
7. create an `update` action in users controller by reusing some code:
```
def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:notice] = "User updated!"
    redirect_to user_path(@user)
  else
    render :edit
  end
end
```
8. go to http://localhost:3000/users/1/edit to check the feature is working

## add the feature to show all existing users
1. check rails routes for the prefix, URI, and controller#action for user `index`
* this is the home page for users, which shows all existing users
2. create index action in users controller as follows:
```
def index
  @users = User.all
end
```
3. create `index.html.erb` view in `app/views/users` with following code:
```
<h1>Listing all users</h1>

<p><%= link_to "Create new user", new_user_path %></p>

<table>
  <tr>
    <th>User Name</th>
    <th>Email</th>
  </tr>
  <% @users.each do |user| %>
    <tr>
      <td><%= user.username %></td>
      <td><%= user.email %></td>
      <td><%= link_to 'Edit', edit_user_path(user) %></td>
      <td><%= link_to 'Show', user_path(user) %></td>
    </tr>
  <% end %>
</table>
```
4. check the result and add following link code to `new`, `show`, and `edit` view
```
<%= link_to "Back to users listing", users_path %>
```
* so there is a back link in the page if `create`, `show`, and `edit` user pages
5. further add a link to the edit page for the `show` page
```
<%= link_to "Edit this user", edit_user_path(@user) %>
```

## use partial to reduce code redundancy
1. extract the identical form in the views of show and edit into a `partial` form
2. create a partial form file `_form.html.erb` in `app/views/users`
* notice all partial views have prefix `_` in their names
3. cut the code for error message and form from `new` into this partial form
4. in `new` and `show` views, refer the partial form with: ```<%= render 'form' %>```
5. browsing the updated pages, should be the same as before
6. with the same technic, extract the error message into a partial too
7. cut the `ul` tag for messages from the `application` to `_messages` in `layouts`
* layouts are all located in `app/views/layouts`, with a `html.erb` extention
8. refer to the message in application layout: ```<%= render 'layouts/messages' %>```
9. test the result by creating a new user

## add the delete feature
1. check rails routes about the `DELETE` verb, and the `destroy` action.
2. create the destroy action in users controller:
```
def destroy
  @user = User.find(params[:id])
  @username = @user.username
  @user.destroy
  flash[:notice] = "User @username was deleted!"
  redirect_to users_path
end
```
3. add the delete link into the user list table in users index page
```
<td><%= link_to 'Delete', user_path(user), method: :delete, data: {confirm: "Are you sure?"} %></td>
```
* this line of code is added after the `show` and `edit` line of td
* notice the `method: :delete` specifies the verb used
* notice the `data` part displays a message for confirmation
4. test the delete feature in browser
5. add links to articles and users in the site hope pate app/views/welcome
```
<h1>This is the Welcome homepage</h1>
<%= link_to 'Articles', articles_path %> |
<%= link_to 'Users', users_path %> |
<%= link_to 'About', about_path %>
```

## polish further and deploy the current project
1. reduce code redundancy further by extracting repeated code to a function:
* create private method `set_user` within users controller
```
def set_user
  @user = User.find(params[:id])
end
```
2. apply `set_user` action to related actions in users controller on top:
```
before_action :set_user, only: [:edit, :update, :show, :destroy]
```
3. remove the code from the actions of `edit`, `update`, `show`, and `destroy`
4. test the final effect, git push the repo, then deploy to heroku
```
git status
git add -A
git commit -m "added user pages"
git push heroku master
heroku run rails db:migrate
```
* after pushing to heroku, the last command creates the database on heroku

## styling the Application
1. install `bootstrap` and have some basic configuration:
2. update Gemfile by adding:
```
gem 'bootstrap-sass', '~> 3.3.7'
```
above
```
gem 'sass-rails',   '5.0.6'
```
3. run: ```bundle install```
4. create `custom.css.scss` within `app/assets/stylesheets` with:
```
@import "bootstrap-sprockets";
@import "bootstrap";
```
5. update `applications.js` within `app/assets/javascripts` with:
```
//= require rails-ujs
//= require jquery
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree
```
6. restart the server to see the change of style

## add navigation to every page
1. add navigation render code to the top of `body` tag of `application` layout
```
<%= render 'layouts/navigation' %>
```
* the `application` layout file is located in `app/views/layouts`
2. create `navigation` partial file in the layouts folder:
* go to https://getbootstrap.com/docs/3.3/components/#navbar copy the code
* the file name for the partial file should be `_navigation.html.erb`
3. back to home page of the server, refresh to check the default nav bar
4. add following code on top of `custom.css.scss` file:
```
$navbar-default-bg: black;
```
5. remove static active effect: remove `class="active"` in nav bar file line 17
6. modify `Brand` to `Hello World` in nav bar file line 11
7. further style the brand with updating the brand code line 11 with:
```
<a class="navbar-brand" id="logo" href="#">Hello World</a>
```
8. add following code at the bottom of the `custom.css.scss` file:
```
#logo {
  float: left;
  font-size: 1.7em;
  color: #fff;
  text-transform: uppercase;
  letter-spacing: -1px;
  font-weight: bold;
}

#logo:hover {
  color: #fff;
  text-decoration: none;
}
```
9. update the link of the brand to site home page by modifying line 11 to:
```
<%= link_to "Hello World", root_path, class: "navbar-brand", id: "logo" %>
```
10. similarly, update other links on nav bar and dropdown list:
* update line 17 and line 18 of two main nav bar links with:
```
<li><%= link_to "Articles", articles_path %></li>
<li><%= link_to "Users", users_path %></li>
```
* update `Dropdown` with `Actions` on line 20, and top two links with:
```
<li><%= link_to "New Article", new_article_path %></li>
<li><%= link_to "New User", new_user_path %></li>
```
* update another main nav bar link on line 39 with:
```
<li><%= link_to "About", about_path %></li>
```

## revise the home page with a jumbotron:
1. go to https://getbootstrap.com/docs/3.3/components/#jumbotron
* copy and paste the code to `home.html.erb` in `app/views/welcome/`
* modify the text body somehow
```
<div class="jumbotron">
  <h1>Hello, world!</h1>
  <p>This is a hello world Rails application for learning Ruby on Rails.</p>
  <p><%= link_to "Learn more", about_path, class: "btn btn-danger btn-lg" %></p>
</div>
```
2. refresh the site home page to check the current result
3. for adding some space between components on the page body:
* wrap the `<%= yield %>` in application layout with following div:
```
<div class="container">
  <%= yield %>
</div>
```
4. for center align text, add a center class in `custom.css.scss` file:
```
.center {
  text-align: center;
}
```
* then update the `class` attribute of `jumbotron` in home page to:
```
<div class="center jumbotron">
```
5. refresh the site home page to check the result
6. download a theme image `ruby-on-rails.jpg` and save in `app/assets/images`
7. update `custom.css.scss` by adding following class definitions:
```
.jumbotron {
  background-image: asset-url('ruby-on-rails.jpg');
  background-size: cover;
  height: 550px;
  padding-top: 10px;
}

.jumbotron h1{
  color: #fff;
  margin-bottom: 30px;
  letter-spacing: -1px;
  font-weight: bold;
}

.jumbotron p{
  color: #fff;
}
```
8. add another `#btn-home` id and apply it to the `Learn more` button
```
#btn-home {
  font-size: 1.2em;
  margin-top: 290px;
  color: white;
}
```
* update the `Learn more` button with this newly defined "btn-home" id:
```
<p><%= link_to "Learn more", about_path, class: "btn btn-danger btn-lg", id: "btn-home" %></p>
```
9. refresh the site home page to see the result of adjustment

## add footer to the home page
1. add the render code to the end of the body tag in `application.html.erb`
```
<%= render 'layouts/footer' %>
```
2. create `_footer.html.erb` partial file in `app/views/layouts`
```
<div class="container">
  <footer class="footer">
    <small>
      Copyright &copy; <a href="https://github.com/your-repo">Your Project</a>
      by <a href="https://your-website/">Your Name</a>
    </small>
    <nav>
      <ul>
        <li><%= link_to 'Articles', articles_path %></li>
        <li><%= link_to 'Users', users_path %></li>
        <li><%= link_to 'About', about_path %></li>
      </ul>
    </nav>
  </footer>
</div>
```
3. create following footer style definitions in `custom.css.scss`
```
footer {
  text-align: right;
  margin-top: 5px;
  padding-top: 5px;
  border-top: 1px solid #eaeaea;
  color: #777;
}

footer a:hover {
  color: #222;
  background-color: white;
}

footer small {
  float: left;
}

footer ul {
  float: right;
  list-style: none;
}

footer ul li {
  float: left;
  margin-left: 15px;
}
```
4. refresh the home page to check the final result
