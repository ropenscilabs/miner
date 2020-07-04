#' Set world
#'
#' Get the world miner uses for its locations. The default is the "normal" overworld,
#' but by using this command with a world as parameter, the world that's used for locations changes
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
#' @seealso [getWorlds()] and [player.getWorld()]
#'
#' @export
setWorld <- function(world)
{
   if (is.null(world) || is.na(world)){
    
     "[error]: no input given!"
    
   } else {
     
     mc_send(merge_data("setWorld()", world))
     cat("set world to", world , "\n")
     
   }
     
     
   
    
}
