#' List all users available to query
#'
#' Depends on having the SPOTIFYAPIDIR environment variable set.
#'
#' @return user_list A list of all users. Can reference to pull token information.
#' @export
#' @examples
#' list_users()
list_users <- function(){

	folder <- Sys.getenv('SPOTIFYAPIDIR')

	return(dir(folder,full.names=TRUE))
}
