
usethis::use_package("shiny")
usethis::use_package("prophet")
usethis::use_package("d3scatter")
usethis::use_package("shinydashboard")
usethis::use_package("SaldaeDataExplorer")
usethis::use_package("SaldaeModulesUI")
usethis::use_package("SaldaeForecasting")
usethis::use_package("SaldaeReporting")



golem::add_js_file("script" )
golem::add_js_handler("handlers" )
golem::add_css_file( "custom" )

#-------Test 
usethis::use_test( "app" )

#---- Project management
usethis::use_github()
# usethis::use_travis()
# usethis::use_appveyor()

#---------- Deploy App

rstudioapi::navigateToFile("dev/03_deploy.R")
