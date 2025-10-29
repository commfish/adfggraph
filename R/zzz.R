# This script loads fonts quietly in the background and checks if extrafont is installed

.onLoad <- function(libname, pkgname) {
  # Try to load fonts quietly when the package is loaded
  #if ("extrafont" %in% rownames(installed.packages())) {
  if (requireNamespace("extrafont", quietly = TRUE)) {
    tryCatch({
      extrafont::loadfonts(quiet = TRUE)
    }, error = function(e) {
      packageStartupMessage(
        "\nCould not load fonts via extrafont::loadfonts().\n",
        "You may need to run extrafont::font_import() once to register system fonts.\n"
      )
    })
  }
}

.onAttach <- function(libname, pkgname) {
  # Friendly startup message
  packageStartupMessage(
    paste0(
      "\n", pkgname, " loaded successfully.",
      "\nIf you're using custom fonts (e.g., 'Times New Roman'), make sure you've run:\n",
      "   extrafont::font_import()  # once per system\n",
      "   extrafont::loadfonts()    # once per R session\n"
    )
  )
}
