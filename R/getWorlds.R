#' Get a vector of all worlds recognized by Spigot. 
#' 
#' @return A vector containing all worlds recognized by Spigot.
#'
#'
#' @examples
#' \dontrun{
#' mc_connect()
#' worlds <- getWorlds()
#' setWorld(worlds[1])
#' }
#' @seealso [getPlayerWorld()] and [setWorld()]
#'
#' @export
getWorlds <- function()
{
    result <- mc_sendreceive("getWorlds()")
    out <- strsplit(result, split = ',')
    out[[1]]
    
}
