#' Combine id/secret and return header.
#'
#' Combine id/secret and return header.
#'
#' @param tkn use saved token info to get header.
#' @return object add_headers from httr with correct information.
#' @examples
#' get_auth_header()
get_auth_header <- function(tkn,type='user'){

	auth_header <- NULL

	if( type == 'user' ){
		auth_header <- httr::add_headers('Authorization'=paste('Bearer',tkn$access_token))
	}

	if( type == 'app' ){
		auth_header <- httr::add_headers('Authorization'=paste('Basic',RCurl::base64(paste(Sys.getenv('SPOTIFYCLIENTID'),Sys.getenv('SPOTIFYCLIENTSECRET'),sep=':'))[[1]]))
	}

	return(auth_header)
}
