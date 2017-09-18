# File load_Functions.R - file of all small functions used in code. These were put into a separate file so that they can be loaded at the beginning of a session and used for all other script files.


#1. pkgTest
# Function pkgTest - An R function to test if a package is installed. If not, the package and all dependencies will be installed from the default CRAN mirror.
## Code taken from Stack Overflow - http://stackoverflow.com/questions/9341635/how-can-i-check-for-installed-r-packages-before-running-install-packages

pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}

pkgTest("shiny")
pkgTest("rsconnect")
pkgTest("tidyverse")
pkgTest("reshape")