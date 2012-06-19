simple_blog
===========

Just a simple blog with authorization

There are no requirements for views, so views part is very very simple.

Install
=============
bundle install

rake db:migrate

rake db:seed

rails s

and enjoy! :-)

Features
=============
You can assign special roles for users like manage_all_<resources> and manage_<resource> item_id, where <resources> and <resource> is a post(s), comment(s), role(s), and user(s).
For example, if you assign role manage_post, item_id 10 for user, then this user could manage this post with id=10 and if you assign role manage_all_post for this user, then this user could manage all posts.

Testing
=============
This application tested with rspec.

rake spec
