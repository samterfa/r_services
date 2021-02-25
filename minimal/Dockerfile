FROM rocker/tidyverse

#### Install CRAN or Github packages not included in rocker/tidyverse container.
RUN install2.r plumber  # Add more packages separated by spaces.

# RUN installGithub.r # Uncomment to add Github packages.

#### Copies the files in this directory to files in your container.
COPY [".", "./"]

#### This starts your R-powered service.
ENTRYPOINT ["Rscript", "-e", "pr <- plumber::plumb(commandArgs()[9]); pr$run(host='0.0.0.0', port = 8000), swagger = F)"]

CMD ["Plumber.R"]