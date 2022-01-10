function (name, role, photo, logo = NULL, href = NULL, links = NULL, 
          heading = "Contact information", heading_size = "h2", footnote = NULL, 
          logo_height = 170, photo_width = 128, photo_height = 128) 
{
  if (!inherits(photo, "character") || length(photo) != 1) 
    stop("`photo` must be a path or url to a single image.")
  if (inherits(logo, "character")) {
    if (inherits(href, "character") && length(href) != length(logo)) 
      stop("`logo` and `href` must be equal length if `href` is not NULL.")
    close_tag <- paste0("\" style=\"float:right;height:", 
                        logo_height, "px;margin:5px;\" target=\"_blank\">")
    if (!is.null(href)) 
      close_tag <- paste0(close_tag, "</a>")
    if (is.null(href)) 
      x <- purrr::map2(logo, ~paste0("<img src=\"", .x, 
                                     close_tag))
    if (!is.null(href)) 
      x <- purrr::map2(logo, href, ~paste0("<a href=\"", 
                                           .y, "\"><img src=\"", .x, close_tag))
    x <- paste(unlist(x), collapse = "")
  }
  else {
    x <- ""
  }
  id <- paste0("<div style=\"clear: left;\"><img src=\"", 
               photo, "\" alt=\"\" style=\"float: left; margin-right:5px; width:", 
               photo_width, "; height:", photo_height, ";\" /></div><h4>", 
               name, "</h4><h4>", role, "</h4>")
  if (inherits(links, "list")) {
    if (is.null(names(links))) {
      links <- paste(links, collapse = "")
    }
    else {
      links <- purrr::map2(links, names(links), ~paste0("<a href=\"", 
                                                        .x, "\" target=\"_blank\">", .y, "</a>")) %>% 
        unlist() %>% paste(collapse = " | ")
    }
    id <- paste0(id, links)
  }
  if (!is.null(heading)) 
    heading <- shiny::HTML(paste0("<", heading_size, ">", 
                                  heading, "</", heading_size, ">"))
  if (!is.null(footnote)) 
    footnote <- shiny::HTML(paste(purrr::map_chr(footnote, 
                                                 ~as.character(shiny::p(.x))), collapse = ""))
  shiny::tagList(shiny::HTML(x), heading, shiny::HTML(paste0(id, 
                                                             "</p>")), footnote)
}

