#' Get all tracks from playlist
#'
#' Get all tracks from playlist
#'
#' @param tkn User credentials. May need to spoof this if requesting a public playlist.
#' @param playlist_id Valid playlist ID from Spotify.
#' @return Raw data returned from API
#' @export
#' @examples
#' get_playlist_tracks()
get_playlist_tracks <- function(tkn,playlist_id,output='tbl'){
	header_auth_type <- 'user'
	if( is.null(tkn$access_token) ){
		header_auth_type <- 'app'
	}
	pl_tracks <- httr::content(httr::GET(paste('https://api.spotify.com/v1/users/',tkn$username,'/playlists/',playlist_id,'/tracks',sep=''),
			get_auth_header(type=header_auth_type)))

	out <- pl_tracks
	
	if( output == 'tbl'){
		out <- tibble::as.tibble(plyr::rbind.fill(lapply(pl_tracks$items,function(x){
			# cat(x$track$name,fill=TRUE)
			data.frame(artist=x$track$artists[[1]]$name,album=x$track$album$name,album_id=x$track$album$id,track=x$track$name,track_id=x$track$id)
			# data.frame(artist=x$artists$name)
		})))
	}

	return(out)
}
