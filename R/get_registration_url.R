#' Get Registration URL
#'
#' Given scope, generate URL to register a new user using Authorizatino Flow.
#'
#' @param scope List describing the kind of access being requested.
#' @return URL that will request access to a user's Spotify data.
#' @export
#' @examples
#' get_registration_url()
get_registration_url <- function(scope=c('playlist-read-collaborative','user-library-read','user-follow-read','user-read-email','user-read-private','user-top-read')){
	base_url <- 'https://accounts.spotify.com/authorize'
	out <- paste0(base_url,'?client_id=',Sys.getenv('SPOTIFYCLIENTID'),
		'&response_type=code',
		'&redirect_uri=',URLencode(Sys.getenv('SPOTIFYREDIRECTURI'),reserved=TRUE),
		'&scope=',URLencode(paste(scope,collapse=' ')))
	return(out)
}