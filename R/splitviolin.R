#' Split Violin Plot
#'
#' @param mapping Set of aesthetic mappings created by aes() or aes_().
#' @param data The data to be displayed in this layer. 
#' @param stat Which statistic. Defaults to "ydensity"
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param ... Other arguments passed on to layer(). These are often aesthetics, used to set an aesthetic to a fixed value, like colour = "red" or size = 3. They may also be parameters to the paired geom/stat.
#' @param draw_quantiles If not(NULL) (default), draw horizontal lines at the given quantiles of the density estimate.
#' @param trim If TRUE (default), trim the tails of the violins to the range of the data. If FALSE, don't trim the tails.
#' @param scale if "area" (default), all violins have the same area (before trimming the tails). If "count", areas are scaled proportionally to the number of observations. If "width", all violins have the same maximum width.
#' @param na.rm If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed.
#' @param show.legend Whether or not to show the legend.
#' @param inherit.aes If mapping is specified and inherit.aes = TRUE (the default), the mapping is combined with the default mapping at the top level of the plot.
#'
#' @export
#'
#' @examples
#' ggplot(ggplot2::diamonds, aes(cut, carat)) + geom_split_violin()
geom_split_violin <- function (mapping = NULL, 
                               data = NULL, 
                               stat = "ydensity", 
                               position = "identity", ..., 
                               draw_quantiles = NULL, 
                               trim = TRUE, 
                               scale = "area", 
                               na.rm = FALSE, 
                               show.legend = NA, 
                               inherit.aes = TRUE) {
  GeomSplitViolin <- ggplot2::ggproto(
    "GeomSplitViolin", 
    GeomViolin, 
    draw_group = function(self, data, ..., draw_quantiles = NULL) {
      data <- transform(data, 
                        xminv = x - violinwidth * (x - xmin), 
                        xmaxv = x + violinwidth * (xmax - x))
      grp <- data[1,'group']
      newdata <- plyr::arrange(
        transform(data, x = if(grp%%2==1) xminv else xmaxv), 
        if(grp%%2==1) y else -y
      )
      newdata <- rbind(newdata[1, ], newdata, newdata[nrow(newdata), ], newdata[1, ])
      newdata[c(1,nrow(newdata)-1,nrow(newdata)), 'x'] <- round(newdata[1, 'x']) 
      if (length(draw_quantiles) > 0 & !scales::zero_range(range(data$y))) {
        stopifnot(all(draw_quantiles >= 0), all(draw_quantiles <= 1))
        quantiles <- ggplot2:::create_quantile_segment_frame(data, draw_quantiles)
        aesthetics <- data[rep(1, nrow(quantiles)), setdiff(names(data), c("x", "y")), drop = FALSE]
        aesthetics$alpha <- rep(1, nrow(quantiles))
        both <- cbind(quantiles, aesthetics)
        quantile_grob <- ggplot2::GeomPath$draw_panel(both, ...)
        ggplot2:::ggname("geom_split_violin", 
                         grid::grobTree(ggplot2::GeomPolygon$draw_panel(newdata, ...), quantile_grob))
      } else {
        ggplot2:::ggname("geom_split_violin", ggplot2::GeomPolygon$draw_panel(newdata, ...))
      }
    }
  )
  
  
  layer(data = data, 
        mapping = mapping, 
        stat = stat, 
        geom = GeomSplitViolin, 
        position = position, 
        show.legend = show.legend, 
        inherit.aes = inherit.aes, 
        params = list(trim = trim, 
                      scale = scale, 
                      draw_quantiles = draw_quantiles, 
                      na.rm = na.rm, ...)
  )
}
