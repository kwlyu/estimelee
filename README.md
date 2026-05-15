# About this repository

## R/RStudio and Maize

Because of the lack of web development skills, we use [Shinyapps](https://www.shinyapps.io/) to host our program, written in [the R programming language](https://www.r-project.org/). Carleton provides two servers ([maize](https://maize.mathcs.carleton.edu/)) for students to access Posit Workbench remotely. If you don't already have a machine that runs [RStudio](https://posit.co/download/rstudio-desktop/) locally, you can use the Maize servers to clone and update this repository. Visit the [Carleton Math and Stats Department](https://www.carleton.edu/math/resources/statistics-and-r-studio-help/) website for more help. *Note that this shiny app is memory intensive (it frequently requires over 1 GB of memory), so a local machine is recommended (but not required).*

# What's in this repository

The root folder contains several subfolders; they each hold three separate Shinyapps. We did this because we couldn't figure out how to do multipage shinyapps. 

- The `main` folder holds the main page hosted [here](https://estimelee.shinyapps.io/main/). It serves as a landing page for teachers or students who want to create or play a contest.
- The `create` folder holds [the site](https://estimelee.shinyapps.io/create/) where you create a new contest.
- The `play` folder holds [the site](https://estimelee.shinyapps.io/play/) where people actually play during the contest.

# Publish the website

Currently, all three shiny apps are published under the account associated with [Kunwu Lyu](https://github.com/kwlyu); this can be migrated. You can make changes to the shiny app (`app.R`) and publish to [the same destinations](estimelee.shinyapps.io/play/).

Once you have access to the shiny account, go under: **Account \> Tokens \> Show \> Show Secrete \> Copy to clipboard**. With the token, go into the shiny app, hit **Publish \> Other Destination \> Add new account \> Shinyapps.io**, paste the token into the window, and connect account. Once it's connected, you can publish the newly edited website to the shiny account. For more information, refer to [this tutorial](https://shiny.posit.co/r/articles/share/shinyapps/).