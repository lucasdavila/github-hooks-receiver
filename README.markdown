github-hooks-receiver is a simple (and experimental) sinatra app to receive post-receive-hooks from github
read more about post-receive-hooks here http://help.github.com/post-receive-hooks/

# how to use?

1 - clone this git repo:
$ cd ~
$ git clone git://github.com/lucasdavila/github-hooks-receiver.git
$ cd github-hooks-receiver

2 - create your hooks in hooks/post-receive folder (this file is a shell script aka sh), ex:
$ touch hooks/post-receive/my_hook
$ nano hooks/post-receive/my_hook

//now add your commands
cd /path/to/my/app-project
git reset --hard
git pull origin master

//and save your hook pressing
ctrl + x
y

//remember this file need execution permission, to check permissions execute:
$ ls -la

//to add execution permission execute:
$ sudo chmod +x my_hook_file_name

4 - install dependencies (you must have installed ruby )
$ bundle install

3 - run your server
$ ruby rooks_receiver.rb

4 - add your post-receive-hook url to github hooks page
ex url: http://your-host/post-receive/<hook-name>
github hooks page: https://github.com/your_user/your_project/admin/hooks

yep :) now your can receive post-receive-hooks from github.
