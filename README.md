# Apify

Apify is a very small Ruby gem meant to simplify the retrieval of nested objects for use in JSON APIs.  

> *** Needs Improvement: This is currently not scalable and is only suitable for development in its current state.  For example, say a user has 1000 posts.  All of those posts will be returned in a call to user.apify.  The next version will set a limit on the number of responses for has many associations.

## Installation
  Add gem to Gemfile
```ruby
    gem 'apify', git: 'git://github.com/borentaylor05/apify.git'
```
## Usage
#### Include Modules
 Include the module in your models to access the apify method.
```ruby
    class User < ActiveRecord::Base
	    include Apify
	    belongs_to :company
    	has_many :posts
    end
```
 Optional: Include ApifyRespond module in ApplicationController.
```ruby
    class ApplicationController < ActionController::Base
	    include ApifyRespond
	    # adds respond method that takes a hash and returns JSON
	    # e.g. respond({status: 200, user: User.first.apify})
    end
```
#### Using the Methods
 Call the method from a controller.
```ruby
    def get_user
        respond({ status: 200, user: User.first.apify })
    end
```
  The apify method resolves all associations for that model and returns the objects / collections as hashes. Without the apify method, the call above only returns a foreign key value for company and no mention of posts.
  **The above call to respond returns the following JSON object**.
```json
// DB Schema:
// Company has_many users 
// User belongs_to a company
// User has_many posts
// Post belongs_to user
{
    "status": 200,
    "user": {  
       "id":1,
       "name":"Its Me",
       "company_id":1,
       "updated_at":"2015-09-06T15:16:57.734Z",
       "company":{  
          "id":1,
          "name":"MyComp",
          "updated_at":"2015-09-06T15:16:30.624Z"
   },
   "posts":[  
      {  
         "id":1,
         "body":"A post",
         "updated_at":"2015-09-06T15:33:24.163Z",
         "user_id":1
      }
   ]
}
```
It works with Collections too!
```ruby
    User.all.apify  # this works too!
```
## Fine Tuning
#### Exclude Associations
To exclude certain associations (e.g. has_many_through tables with only foreign keys), use the **Apify.except** method.
```ruby
    class User < ActiveRecord::Base
    	include Apify
    	Apify.except :user_games # add associations to exclude (comma separated)
    	belongs_to :company
    	has_many :posts
    end
```

#### Exclude (Blacklist) Attributes
To exclude or blacklist certain attributes from ever being returned in a response, use the **Apify.blacklist** method.
```ruby
    class User < ActiveRecord::Base
    	include Apify
    	# note :created_at is not in the above response
    	Apify.blacklist :created_at	
    	belongs_to :company
    	has_many :posts
    end
```

> ****NOTE: Apify.except and Apify.blacklist set class variables. This means even though you may blacklist :created_at in User, it will be blacklisted in all other models as well. Same with associations. I will improve this in the future. 

