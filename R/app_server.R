#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd


app_server <-   function(input, output, session) {
  #---- load guiding modules
  library("dplyr")
  options(shiny.maxRequestSize=30*1024^2) 
  
  SaldaeModulesUI::sald_guide_loader()
  shinyhelper::observe_helpers(help_dir = "saldae_guide")
  
  #---- upload data
  tisefka_inu <- callModule(module = SaldaeModulesUI::ghred_tisefka_mod, id = "tisefka_tizegzawin")
  
  

  #---- one plot multiple graphs
  output$plot_inu <- callModule(module =  SaldaeModulesUI::SA_tisefka_mod, id = "SA_module_tisefka",tisefka = reactive({tisefka_inu()}))
  
  #----- multiple plot multiple graphs
  callModule(module =  SaldaeModulesUI::SA_tisefka_multiple_mod, id = "SA_multiple_test", tisefka = reactive({tisefka_inu()}))
  
  #------- CandleStick View
  callModule(module =  SaldaeModulesUI::Saldae_taftilt_mod, id = "SA_taftilt_test", tisefka = reactive({tisefka_inu()}))
  
  #------ Waterfall view
  callModule(module =  SaldaeModulesUI::Saldae_kefrida_mod, id = "SA_kefrida_test", tisefka = reactive({tisefka_inu()}))
  
  #------ Map
  callModule(module =  SaldaeModulesUI::Saldae_amadal_mod, id = "SA_amadal_test", tisefka = reactive({tisefka_inu()}))
  
  
  #------ Data Clustering

  clust_results <- callModule(module =  SaldaeForecasting::SA_clustering_core_mod, id = "SA_clustering_core_test", tisefka = reactive({tisefka_inu()}))
  mds_matrix <- reactive({SaldaeForecasting::clustering_tisefka_mds(tsclust_results = clust_results())})
  output$clust_mds <- d3scatter::renderD3scatter({
    req(mds_matrix())
    d3scatter::d3scatter(mds_matrix(), ~dist_x, ~dist_y,~factor(cluster), width="100%", height=250)
  })
  output$by_clusters <- renderPlot({
    req(mds_matrix())
    SaldaeForecasting::clustering_sekened_crosstalk(cluster_mapping = clust_results()$cluster_mapping,tisefka = clust_results()$tisefka_origin,mds_CT = mds_matrix())
  })
  #----- Value Box
  callModule(module = SaldaeModulesUI::SA_Value_box_server, id = "SA_valuebox", tisefka = tisefka_vb)
  
  #----- multiple plot multiple graphs: aggregation and anomaly detection
  callModule(module =  SaldaeModulesUI::SA_tisefka_aggregator_mod, id = "SA_time_aggregator", tisefka = reactive({tisefka_inu()}))
  
  #----- anomaly pool module
  callModule(module =  SaldaeModulesUI::SA_anomaly_mod, id = "SA_anomaly_pool", tisefka = reactive({tisefka_inu()}))
  
  
  #----- multiple plot multiple graphs: growth rates
  callModule(module =  SaldaeModulesUI::SA_tisefka_gemmu_mod, id = "SA_tisfka_gemmu", tisefka = reactive({tisefka_inu()}))
  
  
  #------ Forecasting tool
  tisefka_forecasting <- callModule(module =  SaldaeModulesUI::SA_tisefka_forecast_mod, id = "SA_tisfka_forecast", tisefka = reactive({tisefka_inu()}))
  
  #------ Reporting Pool
  callModule(module = SaldaeModulesUI::SA_reporting_mod, id = "Saldae_reporting",tisefka_list = reactive({tisefka_forecasting()}))
  
  #------ Data Provider EuroStats
  # callModule(module = SA_EuroStat_mod, id = "SA_eurostat_test")
  
  ###########################################
  #########                           #######
  ###             TAGARA                  ###
  ########                            #######
  ###########################################
  #--- mdel shiny
  session$onSessionEnded(function() {
    stopApp()
  })
  #----- tagara
}