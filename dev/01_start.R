golem::fill_desc(
  pkg_name = "SaldaeAnalyticsDashboard",
  pkg_title = "Saldae Analytics",
  pkg_description = "A web-based reactive platform dedicated for time series data processing wrangling and forecasting",
  author_first_name = "Farid",
  author_last_name = "Azouaou",
  author_email = "contact@saldaeanalytics.com",
  repo_url = NULL
)     
golem::set_golem_options()
usethis::use_mit_license( name = "Saldae Users" )
usethis::use_readme_rmd( open = FALSE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Experimental" )
usethis::use_news_md( open = FALSE )
usethis::use_git()
golem::use_recommended_tests()
golem::use_recommended_deps()
golem::remove_favicon()
golem::use_favicon()
golem::use_utils_ui()
golem::use_utils_server()
rstudioapi::navigateToFile("dev/02_dev.R" )
