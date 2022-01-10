# library(leaflet)
# 
# future_key_figures%>%leaflet()
# bb <- future_key_figures%>%dplyr::mutate(Country = attribute )%>%
#   dplyr::select(-attribute)
# 
# mytitle <- "Farid"
# EU_map <- sf::st_as_sf(eurostat::get_eurostat_geospatial(output_class = "spdf", resolution = 10))
# 
# tisefka_eurostat <- tigris::geo_join(EU_map,bb,  by_sp="NUTS_ID", by_df="geo", how = "inner")
# 
# bb %>%
#   sf::st_transform(crs = "+init=epsg:4326") %>%
#   leaflet::leaflet(width = "100%") %>%
#   leaflet::setView(lng=9.6,lat=53.6,zoom=3) %>%
#   leaflet::addProviderTiles(provider = "CartoDB.Positron") %>%
#   leaflet::addPolygons(
#     # popup = popups,
#     stroke = TRUE, weight=1,
#     smoothFactor = 0,
#     fillOpacity = 0.3,
#     color = ~ pal(target_variable)) %>%
#   leaflet::addControl(html = "EuroStat", position = "bottomleft") %>%
#   leaflet::addLegend("bottomleft",
#                      pal = pal,
#                      values = ~ forecast,
#                      title = mytitle,
#                      opacity = 0.3)