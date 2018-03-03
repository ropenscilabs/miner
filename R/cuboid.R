cuboid <- function(
  xlen = 10, ylen = 10, zlen = 10,
  blockid = 1,
  styleid = 0,
  fill = FALSE,
  offset = c(0, -1, 0),
  pos = getPlayerPos(tail(getPlayerIds(), 1), tile = TRUE),
  xlim, ylim, zlim
){

  s <- 1 - fill
  xvec <- c(0, rep(s, xlen - 2), 0)
  yvec <- c(0, rep(s, ylen - 2), 0)
  zvec <- c(0, rep(s, zlen - 2), 0)
  prism <- 1 - outer(outer(xvec, yvec), zvec)
  
  if(missing(xlim)) xlim <- c(1, xlen)
  if(missing(ylim)) ylim <- c(1, ylen)
  if(missing(zlim)) zlim <- c(1, zlen)
  xx <- seq(xlim[1], xlim[2])
  yy <- seq(ylim[1], ylim[2])
  zz <- seq(zlim[1], zlim[2])
  
  p <- pos + offset
  for(x in xx){
    for(y in yy){
      for(z in zz){
        if(prism[x, y, z] == 1){
          setBlock(x + p[1], y + p[2], z + p[3], blockid, styleid)
        }
      }
    }
  }
  pos
}
