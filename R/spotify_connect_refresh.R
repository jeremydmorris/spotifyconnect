#' Refresh access token given user info.
#'
#' Access tokens need to be refreshed every hour. This function provides a simple way to get a new access token given the users' refresh token.
#'
#' @param tkn the user's authentication info as given by load_user
#' @return tkn with new access token
#' @examples
#' spotify_connect_refresh()
spotify_connect_refresh <- function(tkn){

	my_headers <- httr::add_headers(c(Authorization=paste('Basic',get_client_info(type='auth64'),sep=' ')))

	my_body <- list(grant_type='refresh_token',refresh_token=tkn$refresh_token)

	my_token <- httr::content(httr::POST('https://accounts.spotify.com/api/token',my_headers,body=my_body,encode='form'))

	out <- tkn

	.spotifyconnect_env[[ tkn$username ]]$access_token <- my_token$access_token
	.spotifyconnect_env[[ tkn$username ]]$access_token_created <- Sys.time()

	return(out)
}
