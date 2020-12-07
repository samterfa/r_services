FROM rocker/tidyverse

#### Uncomment the following lines to install packages into your container not included in the rocker/tidyverse container. ####
# RUN install2.r {CRAN packages separated by spaces}

# RUN installGithub.r {Github packages separated by spaces}

#### This copies the files in this directory to files in your container.
COPY [".", "./"]

#### This starts your R-powered service.
ENTRYPOINT ["Rscript", "-e", "pr <- plumber::plumb(commandArgs()[9]); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')), swagger = F)"]
CMD ["Plumber.R"]