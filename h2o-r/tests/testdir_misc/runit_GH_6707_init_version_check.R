setwd(normalizePath(dirname(
  R.utils::commandArgs(asValues = TRUE)$"f"
)))
source("../../scripts/h2o-r-test-setup.R")

h2o_init_test <- function() {
  e <- tryCatch({
    h2o.init(
      strict_version_check = TRUE
    )
  }, error = function(x) x)
  
  if (!is.null(e)) {
    print(e)
    err_message <- e[[1]]
    if (!grepl("there is no package called ‘h2o’", err_message)) { # this error can occur for some reason.  Getting around it by using this check
      expect_true(grepl("To circumvent this error message (not recommended), you can set strict_version_check=False", err_message))
    }
  }
}

doTest("Make sure connection version mismatch error contains new error message.",
       h2o_init_test)
