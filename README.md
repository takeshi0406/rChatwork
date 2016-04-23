# rChatwork
chatwork library for R

# Installation

``` bash
library(devtools)
install_github("takeshi0406/rChatwork")
```

# Usage
refer api document.
http://developer.chatwork.com/

only two method was implemented.

``` r
library(rChatwork)

client <- rChatwork::chatworkClient$new('your access token')

# post message to room 12345
client$post_messages(message = 'hello chatwork!', room_id = 12345)

# get 100 message from 12345
client$get_messages(room_id = 12345, force = TRUE)
```
