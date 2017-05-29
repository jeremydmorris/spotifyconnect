#' Load user's authentication information into a variable for use.
#'
#' Pull user information and retrieve an access_token using refresh endpoint.
#'
#' @param username Just the users's username string.
#' @return access_token Valid access token
#' @export
#' @examples
#' load_user()
load_user <- function(username){

	user_info <- rjson::fromJSON(file=paste0(Sys.getenv('SPOTIFYAPIDIR'),'/',username,'.json'))

	user_access <- spotify_connect_refresh(user_info)

	return(user_info)
}
