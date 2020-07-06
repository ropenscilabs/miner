#' Get the name of the current world. 
#' 
#' @return the current world miner uses is working in.
#'
#'
#' @examples
#' \dontrun{
#' mc_connect()
#' currentWorld <- getCurrentWorld()
#' playerWorld <- getPlayerWorld()
#' if(currentWorld != playerWorld){
#'    setWorld(playerWorld)
#' }
#' 
#' }
#' @seealso [getPlayerWorld()], [getWorlds()] and [setWorld()]
#'
#' @export
getCurrentWorld <- function()
{
    out <- mc_sendreceive("getCurrentWorld()")
    out
    
}
