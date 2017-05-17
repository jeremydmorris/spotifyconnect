#' Load user's authentication information into a variable for use.
#'
#' Pull user information and retrieve an access_token using refresh endpoint.
#'
#' @param user_file Full path to users's saved authentication info
#' @return access_token Valid access token
#' @export
#' @examples
#' load_user()
load_user <- function(user_file){

	user_info <- rjson::fromJSON(file=user_file)
	user_access <- spotify_connect_refresh(user_info)

	return(user_access)
}
