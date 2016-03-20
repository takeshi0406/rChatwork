#' make API client object
#'
#' @param token
#'
#' @return API object
#'
#' @export
chatworkClient <- R6::R6Class("chatworkClient",
  public=list(
    initialize=function(access_token) {
      private$access_token <- access_token
    },

    post_messages=function(message, room_id) {
      result <- RCurl::postForm(
        uri=private$make_uri('rooms', room_id, 'messages'),
        .opts=list(
          httpheader=private$make_header(),
          postfields=private$make_body(message)
        )
      )
      return(
        rjson::fromJSON(result)
      )
    },

    get_messages=function(room_id, force = FALSE) {
      result <- RCurl::getForm(
        uri=paste0(
          private$make_uri('rooms', room_id, 'messages'),
          ifelse(force, '?force=1', '?force=0')
        ),
        .opts=list(
          httpheader=private$make_header()
        )
      )
      return (
        rjson::fromJSON(result) # jsonをparseする。dataframeの形に成形したほうがいいかな…
      )
    }
  ),

  private=list(
    access_token=NA,
    url='https://api.chatwork.com/v1',

    make_header=function() {
      return (
        c('X-ChatWorkToken'=private$access_token)
      )
    },

    make_uri=function(...) {
      return (
        Reduce(
          function(x, y){paste(x, y, sep='/')},
          as.character(list(private$url, ...))
        )
      )
    },

    make_body=function(message) {
      return (
        #change character code for Windows
        utils::URLencode(iconv(paste0('body=', message), 'SHIFT_JIS','UTF-8'))
      )
    }
  )
)
