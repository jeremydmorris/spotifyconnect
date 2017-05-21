#' Register User
#'
#' Given full redirec_uri, extract code, register user and return user connection object
#'
#' @param redirect Full URL from authorization process.
#' @return User connection object to be used in further API requests. This function will also call the user profile endpoint to store the username so we can store various information in the environment using the username as a key.
#' @export
#' @examples
#' register_user()
register_user <- function(redirect){
	parsed_redirect <- httr::parse_url(redirect)
	user_code <- parsed_redirect$query$code

	#construct body of POST request
	request_body <- list(grant_type='authorization_code',code=user_code,redirect_uri=Sys.getenv('SPOTIFYREDIRECTURI'))

	#get user tokens
	user_token <- httr::content(httr::POST('https://accounts.spotify.com/api/token',get_client_info(type='header'),body=request_body,encode='form'))
	# return(user_token)

	#get userdetails
	user_details <- httr::content(httr::GET('https://api.spotify.com/v1/me',get_auth_header(user_token,type='startup')))

	#now we want to write out the users's details and create an environment variable for the current session.
	#never want to store the auth token on disk so write the refresh token out along with user details.
	username <- user_details$id

	user_save <- list(
		username=username,
		refresh_token=user_token$refresh_token,
		scope=user_token$scope,
		created=Sys.time()
	)
	cat(rjson::toJSON(user_save),file=paste0(Sys.getenv('SPOTIFYAPIDIR'),'/',username,'.json'))

	.spotifyconnect_env[[ username ]]$access_token <- user_token$access_token
	.spotifyconnect_env[[ username ]]$access_token_created <- Sys.time()

	out <- user_save

	return(out)
}