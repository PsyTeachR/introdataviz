#' If Null
#'
#' @param a value to check if NULL
#' @param b replacement if NULL
#'
#' @return value or replacement
#' @keywords internal
"%||%" <- function(a, b) {
  if (!is.null(a)) a else b
}

#' Flat Violin Plot
#'
#' @param mapping Set of aesthetic mappings created by aes() or aes_().
#' @param data The data to be displayed in this layer. 
#' @param stat Which statistic. Defaults to "ydensity"
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param trim If FALSE, the default, each density is computed on the full range of the data. If TRUE, each density is computed over the range of that group: this typically means the estimated x values will not line-up, and hence you won't be able to stack density values. This parameter only matters if you are displaying multiple densities in one plot or if you are manually adjusting the scale limits.
#' @param scale if "area" (default), all violins have the same area (before trimming the tails). If "count", areas are scaled proportionally to the number of observations. If "width", all violins have the same maximum width.
#' @param show.legend Whether or not to show the legend.
#' @param inherit.aes If mapping is specified and inherit.aes = TRUE (the default), the mapping is combined with the default mapping at the top level of the plot.
#' @param ... Other arguments passed on to layer(). These are often aesthetics, used to set an aesthetic to a fixed value, like colour = "red" or size = 3. They may also be parameters to the paired geom/stat.
#'
#' @export
#'
#' @examples
#' ggplot(iris, aes(Species, Sepal.Width)) + geom_flat_violin()
geom_flat_violin <- function(mapping = NULL, data = NULL, stat = "ydensity",
                             position = "dodge", trim = TRUE, scale = "area",
                             show.legend = NA, inherit.aes = TRUE, ...) {
  # define flat violin geom
  GeomFlatViolin <- ggplot2::ggproto(
    "Violinist", 
    Geom,
    setup_data = function(data, params) {
      data$width <- data$width %||%
        params$width %||% (ggplot2::resolution(data$x, FALSE) * 0.9)
      
      # ymin, ymax, xmin, and xmax define the bounding rectangle for each group
      data %>%
        dplyr::group_by(group) %>%
        dplyr::mutate(ymin = min(y),
               ymax = max(y),
               xmin = x,
               xmax = x + width / 2) %>%
        dplyr::ungroup()
      
    },
    draw_group = function(data, panel_scales, coord) {
      # Find the points for the line to go all the way around
      data <- transform(data, xminv = x,
      xmaxv = x + violinwidth * (xmax - x))
      
      # Make sure it's sorted properly to draw the outline
      newdata <- rbind(plyr::arrange(transform(data, x = xminv), y),
      plyr::arrange(transform(data, x = xmaxv), -y))
      
      # Close the polygon: set first and last point the same
      # Needed for coord_polar and such
      newdata <- rbind(newdata, newdata[1,])
      
      ggplot2:::ggname("geom_flat_violin", 
                       ggplot2::GeomPolygon$draw_panel(newdata, panel_scales, coord))
    },
    draw_key = draw_key_polygon,
    default_aes = aes(weight = 1, colour = "grey20", 
                      fill = "white", size = 0.5,
                      alpha = NA, linetype = "solid"),
    required_aes = c("x", "y")
  )
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomFlatViolin,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      trim = trim,
      scale = scale,
      ...
    )
  )
}
