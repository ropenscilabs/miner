#' Get player world
#'
#' Get player world. The default is to get the world of the first player spawned
#' in the game, but the world of other players can be gotten using the
#' `player_id` argument.
#'
#' @param player_id  Integer giving the ID of a player. You can find IDs of all
#'   current players using [getPlayerIds()].
#'
#' @return The worldname a player is in.
#'
#'
#' @examples
#' \dontrun{
#' mc_connect()
#' getPlayerWorld()
#'
#' player <- getPlayerIds()[1]
#' getPlayerWorld(player)
#' }
#'
#' @seealso [getWorlds()] and [setWorld()]
#'
#' @export
getPlayerWorld <- function(player_id = NULL)
{

  if(is.null(player_id)){
    out <- mc_sendreceive("player.getWorld()")
  } else {
    out <- mc_sendreceive(merge_data("player.getWorld", player_id))
  }
    out
}
