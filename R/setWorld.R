#' Set world
#'
#' Get the world that miner uses for its locations. The default is the "normal" overworld,
#' but by using this command with a worldname as parameter, the world that is used for locations gets changed
#'
#' @param world  The world you want to change to. You can find IDs of all
#'   worlds using [getWorlds()], or the world a player is in by using [player.getWorld()].
#'   
#'
#' @examples
#' \dontrun{
#' mc_connect()
#' world <- getPlayerWorld()
#' setWorld(world)
#'
#' }
#'
#' @seealso [getWorlds()], [getCurrentWorld()] and [player.getWorld()]
#'
#' @export
setWorld <- function(world)
{
   if (is.null(world) || is.na(world)){
    
     "[error]: no input given!"
    
   } else {
     
     out <- mc_sendreceive(merge_data("setWorld", world))
     out

   }
     
     
   
    
}
