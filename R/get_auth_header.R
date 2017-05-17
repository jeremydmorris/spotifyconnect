#' Combine id/secret and return header.
#'
#' Combine id/secret and return header.
#'
#' @param tkn use saved token info to get header.
#' @return object add_headers from httr with correct information.
#' @examples
#' get_auth_header()
get_auth_header <- function(tkn){

	auth_header <- httr::add_headers('Authorization'=paste('Bearer',tkn$access_token))

	return(auth_header)
}
