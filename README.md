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
