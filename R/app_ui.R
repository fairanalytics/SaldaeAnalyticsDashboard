#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom dplyr %>%
#' @import SaldaeDataExplorer
#' @noRd

# require("shiny")
# require("dplyr")
# require("SaldaeDataExplorer")
# library("waiter")
app_ui <- function(request) {
  tagList(
    shiny.info::powered_by("Fair Analytics", link = "https://www.fairanalytics.net/", position = "bottom right"),
    shinyalert::useShinyalert(),
    golem_add_external_resources(),
    shinybusy::add_busy_bar(color = "#C4D517"),
    bs4Dash::dashboardPage(
      preloader = list(html = tagList(waiter::spin_circle_square(), "Loading ..."), color = "darkcyan"),
      bs4Dash::dashboardHeader(title =  tags$a(href = 'https://www.fairanalytics.net/'),
                               titleWidth = "50%"),# header
      controlbar = bs4Dash::dashboardControlbar(
        collapsed = TRUE,
        div(class = "p-3", bs4Dash::skinSelector()),
        pinned = FALSE
      ),
      fullscreen = TRUE,
      # help = TRUE,
      bs4Dash::dashboardSidebar(
        bs4Dash::bs4SidebarUserPanel(
          image = "/www/favicon.ico",
          name = "Saldae Analytics"
        ),                        
        bs4Dash::sidebarMenu(
                                  bs4Dash::menuItem("Data View", tabName = "data_upload", icon = icon("table")),
                                         
                                         bs4Dash::menuItem("Explore & Prepare", icon = icon("check-circle"), startExpanded = FALSE,
                                                           bs4Dash::menuSubItem("Exploration", icon = icon("chart-pie"), tabName = "data_exploration"),
                                                           bs4Dash::menuSubItem("Insights", icon = icon("lightbulb"), tabName = "data_insights"),
                                                           bs4Dash::menuSubItem("Aggregation", icon = icon("react"), tabName = "data_aggregation"),
                                                           bs4Dash::menuSubItem("Growth Rate", icon = icon("percent"), tabName = "growth_rate")
                                         ),
                                  bs4Dash::menuItem(" Anomaly Pool", icon = icon("searchengin"), startExpanded = FALSE,
                                                                  bs4Dash::menuSubItem("Anomaly Suit",tabName = "anomaly_pool")
                                         ),
                                         
                                  bs4Dash::menuItem("AI & Analytics", icon = icon("chart-line"), startExpanded = FALSE,
                                                                  bs4Dash::menuSubItem("Causality", tabName = "causal_impact"),
                                                                  bs4Dash::menuSubItem("Forecasting", icon = icon("fas fa-chart-bar"), tabName = "advanced_analytics")
                                                                  # bs4Dash::menuSubItem("Scenario Simulation", tabName = "simulation_engine")
                                         ),
                                  bs4Dash::menuItem("Reporting/Dashboard", icon = icon("file-signature"), startExpanded = FALSE,
                                                                  bs4Dash::menuSubItem("Generate and publish", tabName = "saldae_report")
                                         ),
                                         
                                         bs4Dash::menuItem("Focus", icon = icon("briefcase"), startExpanded = FALSE,
                                                                  
                                                                  bs4Dash::menuSubItem("Business", tabName = "business_charts")
                                         ),
                                         bs4Dash::menuItem("Data Provider", icon = icon("globe-africa"), tabName = "SA_data_provider")
                                         
                                         
                                         
                                         #- tagara sidebarMenu
                                       ),
        collapsed = TRUE                        
               #- tagara dashboardSidebar
                                ),
      bs4Dash::dashboardBody(
        
        
        bs4Dash::tabItems(
          bs4Dash::tabItem("data_upload",
                                  
                                  uiOutput("contact_form")
                                  ,
                                  tisefka_inu <- SaldaeModulesUI::ghred_tisefka_UI(id = "tisefka_tizegzawin"),
                                  
                                  
                                  
          ),
          bs4Dash::tabItem("data_exploration", 
                                  # SaldaeModulesUI::SA_Value_box_UI("SA_valuebox"),
                                  SaldaeModulesUI::SA_key_figures_UI("SA_key_figures"),
                                  
                                  SaldaeModulesUI::SA_tisefka_UI("SA_module_tisefka",mod_title= "Saldae Module")
                                  
                                  ),
          
          bs4Dash::tabItem("data_insights", 
                                  SaldaeModulesUI::SA_tisefka_multiple_UI("SA_multiple_test",mod_title= "Saldae Module")
                                  ),
          bs4Dash::tabItem("anomaly_pool", 
                                  SaldaeModulesUI::SA_anomaly_UI("SA_anomaly_pool",mod_title= "Saldae Module")
          ),
          
          
          bs4Dash::tabItem("business_charts",
                                  fluidRow(
                                    col_6(SaldaeModulesUI::Saldae_taftilt_UI("SA_taftilt_test",mod_title= "Saldae CandleStick Module")),
                                    col_6(SaldaeModulesUI::Saldae_amadal_UI("SA_amadal_test",mod_title= "Saldae Map Module"))
                                  ),
                                  SaldaeModulesUI::Saldae_kefrida_UI("SA_kefrida_test",mod_title= "Saldae Waterfall Module")
                                  
                                  
          ),
          
          bs4Dash::tabItem("data_aggregation",
                                  SaldaeModulesUI::SA_tisefka_aggregator_UI("SA_time_aggregator")
                                  ),
          bs4Dash::tabItem("growth_rate",
                                  SaldaeModulesUI::SA_tisefka_gemmu_UI("SA_tisfka_gemmu")
          ),
          
          
          # ------------ Advanced Analytics
          ## Causal Impact and Clustering
          bs4Dash::tabItem("causal_impact",
                                  SaldaeForecasting::SA_clustering_core_ui("SA_clustering_core_test"),
                                  fluidRow(
                                    column(4, d3scatter::d3scatterOutput("clust_mds")),
                                    column(8, plotOutput("by_clusters"))
                                  )),

          ## Prediction
          bs4Dash::tabItem("advanced_analytics",
                                  SaldaeModulesUI::SA_tisefka_forecast_UI("SA_tisfka_forecast")
          ),
          #------------ reporting pool
          
          bs4Dash::tabItem("saldae_report",
                                  SaldaeModulesUI::SA_reporting_UI("Saldae_reporting")
          ),
          ## Saldae Data

          bs4Dash::tabItem("SA_data_provider",
                                  # SA_EuroStat_UI("SA_eurostat_test")
          )
        #- tagara menu item
        )
        
        

      )
    )
  )
}
#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
#' @export
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'SaldaeAnalyticsDashboard'
    )
  )
}
