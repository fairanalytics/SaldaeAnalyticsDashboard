FROM rocker/r-ver:3.6.3
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libgit2-dev libssh2-1-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.2.1")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.4.0.2")'
RUN Rscript -e 'remotes::install_version("processx",upgrade="never", version = "3.4.1")'
RUN Rscript -e 'remotes::install_version("attempt",upgrade="never", version = "0.3.0")'
RUN Rscript -e 'remotes::install_version("DT",upgrade="never", version = "0.13")'
RUN Rscript -e 'remotes::install_version("glue",upgrade="never", version = "1.3.1")'
RUN Rscript -e 'remotes::install_version("htmltools",upgrade="never", version = "0.4.0")'
RUN Rscript -e 'remotes::install_version("SaldaeDataExplorer",upgrade="never", version = "0.1")'
RUN Rscript -e 'remotes::install_version("SaldaeModulesUI",upgrade="never", version = "0.1")'
RUN Rscript -e 'remotes::install_version("SaldaeForecasting",upgrade="never", version = "0.1")'
RUN Rscript -e 'remotes::install_version("shinydashboard",upgrade="never", version = "0.7.1")'
RUN Rscript -e 'remotes::install_version("prophet",upgrade="never", version = "0.6")'
RUN Rscript -e 'remotes::install_version("pkgload",upgrade="never", version = "1.0.2")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "2.2.1")'
RUN Rscript -e 'remotes::install_github("jcheng5/d3scatter@aba6687f7af974a55ee07b52bea0ccbf110623e8")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');SaldaeAnalyticsDashboard::run_app()"
