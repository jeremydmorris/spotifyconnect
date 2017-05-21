#' Pull client id and secret from environment vars.
#'
#' Pull client id and secret from environment vars.
#'
#' @param type return list by default. If set to 'auth64' return base64 encoded.
#' @return list with client id and secret
#' @examples
#' get_client_info()
get_client_info <- function(type='list'){

	id <- Sys.getenv('SPOTIFYCLIENTID')
	secret <- Sys.getenv('SPOTIFYCLIENTSECRET')

	out <- list(client_id=id,client_secret=secret)

	if( type == 'auth64' ){
		out <- RCurl::base64(paste(id,secret,sep=':'))[[1]]
	}

	if( type == 'header' ){
		out <- httr::add_headers('Authorization'=paste('Basic',RCurl::base64(paste(Sys.getenv('SPOTIFYCLIENTID'),Sys.getenv('SPOTIFYCLIENTSECRET'),sep=':'))[[1]]))
	}

	return(out)
}
