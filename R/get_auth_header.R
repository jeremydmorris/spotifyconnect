#' Combine id/secret and return header.
#'
#' Combine id/secret and return header.
#'
#' @param tkn use saved token info to get header.
#' @param type either startup, app or user depending on the situation.
#' @return object add_headers from httr with correct information.
#' @examples
#' get_auth_header()
get_auth_header <- function(tkn,type='user'){

	auth_header <- NULL

	if( type == 'startup' ){
		auth_header <- httr::add_headers('Authorization'=paste('Bearer',tkn$access_token))
	}

	if( type == 'app' ){
		if( is.null(.spotifyconnect_env$my_app) ){
			my_headers <- httr::add_headers(c(Authorization=paste('Basic',get_client_info(type='auth64'),sep=' ')))
			my_body <- list(grant_type='client_credentials')
			my_token <- httr::content(httr::POST('https://accounts.spotify.com/api/token',my_headers,body=my_body,encode='form'))

			.spotifyconnect_env$my_app <- my_token
			.spotifyconnect_env$my_app$access_token_created <- Sys.time()
	
			auth_header <- httr::add_headers('Authorization'=paste('Bearer',.spotifyconnect_env$my_app$access_token,sep=' '))
		}else{
			if( difftime(Sys.time(),.spotifyconnect_env$my_app$access_token_created,units='secs') > 3500 ){
				.spotifyconnect_env$my_app <- NULL
				get_auth_header(type='app')
			}
			auth_header <- httr::add_headers('Authorization'=paste('Bearer',.spotifyconnect_env$my_app$access_token,sep=' '))
		}
	}

	if( type == 'user' ){
		if( difftime(Sys.time(),.spotifyconnect_env[[ tkn$username ]]$access_token_created,units='secs') > 3500 ){
			spotify_connect_refresh(tkn)
		}
		auth_header <- httr::add_headers('Authorization'=paste('Bearer',.spotifyconnect_env[[ tkn$username ]]$access_token))
	}

	return(auth_header)
}
