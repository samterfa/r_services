FROM rocker/tidyverse

#### Install CRAN or Github packages not included in rocker/tidyverse container.
# RUN # Add CRAN packages separated by spaces.

RUN installGithub.r samterfa/rSlack rstudio/plumber # Add Github packages separated by spaces.

#### Copies the files in this directory to files in your container.
COPY [".", "./"]

#### This starts your R-powered service.
ENTRYPOINT ["Rscript", "-e", "pr <- plumber::plumb(commandArgs()[9]); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')), swagger = F)"]

CMD ["Plumber.R"]