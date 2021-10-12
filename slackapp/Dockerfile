FROM rocker/tidyverse

#### Install CRAN or Github packages not included in rocker/tidyverse container.

RUN install2.r plumber # Add CRAN packages separated by spaces.

RUN installGithub.r # Add Github packages separated by spaces.

#### Copies the files in this directory to files in your container.
COPY [".", "./"]

#### This starts your R-powered service.
ENTRYPOINT ["Rscript", "-e", "pr <- plumber::plumb(rev(commandArgs())[1]); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')))"]

CMD ["Plumber.R"]