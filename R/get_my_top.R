#' Combine id/secret and return header.
#'
#' Combine id/secret and return header.
#'
#' @param tkn use saved token info to get header.
#' @param n number of results to return.
#' @param type either 'tracks' or 'artists' depending on usage
#' @param time_range takes either 'short_term', 'medium_term' or 'long_term'. Set to 'short_term' by default.
#' @param output by default, will return a tibble object. Will allow 'raw' to return the raw endpoint call.
#' @return tibble with relevant information
#' @export
#' @examples
#' get_my_top()
get_my_top <- function(tkn,n=20,type='tracks',time_range='short_term',output='tbl'){
	my_top <- httr::content(httr::GET(paste('https://api.spotify.com/v1/me/top/',type,sep=''),
		query=list(limit=n,time_range=time_range),get_auth_header(tkn)))

	out <- my_top

	if( output == 'tbl' && type == 'tracks' ) {
		out <- tibble::as.tibble(plyr::rbind.fill(lapply(my_top$items,function(x){
			data.frame(artist=x$artists[[1]]$name,album=x$album$name,album_id=x$album$id,track=x$name,track_id=x$id)
			# data.frame(artist=x$artists$name)
		})))
	}

	if( output == 'tbl' && type == 'artists' ){
		out <- tibble::as.tibble(plyr::rbind.fill(lapply(my_top$items,function(x){
			data.frame(id=x$id,name=x$name,followers=x$followers$total,popularity=x$popularity)
		})))
	}

	return(out)
}
