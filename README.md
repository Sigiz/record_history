ActiveRecord history

## Installation

```
gem install record_history
rails g record_history:install
```

## Usage

    # activate history logging for model
    class Item < ActiveRecord::Base
      has_record_history
    end

    # activate history logging for model (only for "name" field)
    class Item < ActiveRecord::Base
      has_record_history :only => [:name]
    end
  
    # activate history logging for model (except 'name' field)
    class Item < ActiveRecord::Base
      has_record_history :ignore => [:name]
    end
  
    # activate history logging for model (on update)
    class Item < ActiveRecord::Base
      has_record_history :on => [:update]
    end
  
    # get history for object
    item = Item.first
    history = item.first.record_history
    history.first.old_value
    hostory.first.new_value
  
  
    # declare that User is author for some record_history items
    class User < ActiveRecord::Base
      is_record_history_author
    end
  
    # get record_history items created by user
    User.first.written_history
  
test
