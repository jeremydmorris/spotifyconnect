#' Get audio features for specified track from API
#'
#' Get audio features for specified track from API
#'
#' @param track_id Valid track id from Spotify's API (or straight from the app if you want to do it that way instead).
#' @param output By default, results will be returned in a tibble. Any other value for this parameter will return the raw results.
#' @return Results will be returned in a tibble by default with all tracks requested. 
#' @export
#' @examples
#' get_my_top()
get_audio_features <- function(track_id,output='tibble'){
	af <- httr::content(httr::GET('https://api.spotify.com/v1/audio-features',query=list(ids=paste(unique(track_id),collapse=',')),get_auth_header(type='app')))
	out <- af
	if( output == 'tibble' ){
		out <- dplyr::bind_rows(lapply(af$audio_features,tibble::as.tibble))
	}
	return(out)
}
