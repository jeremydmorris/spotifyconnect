#' Register User
#'
#' Given full redirec_uri, extract code, register user and return user connection object
#'
#' @param redirect_uri
#' @return User connection object to be used in further API requests.
#' @export
#' @examples
#' register_user()
register_user <- function(redirect_uri){
	parsed_redirect <- httr::parse_url(redirect_uri)
	user_code <- parsed_redirect$query$code

	#construct body of POST request
	request_body <- list(grant_type='authorization_code',code=user_code,redirect_uri=Sys.getenv('SPOTIFYREDIRECTURI'))

	#get user tokens
	user_token <- httr::content(httr::POST('https://accounts.spotify.com/api/token',get_auth_header(type='app'),body=request_body,encode='form'))

	out <- user_token
	return(out)
}