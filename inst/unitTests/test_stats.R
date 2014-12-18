## Test functions present in the stats.R file

### {{{ --- Test setup ---

if(FALSE) {
  library( "RUnit" )
  library( "metagene" )
}

### }}}

valid_data <- matrix(1:100, ncol = 5)

###################################################
## Test the Basic_Stats$new() function (initialize)
###################################################

base_msg <- "Basic_Stat initialize -"

## Invalid data class
test.basic_stat_initialize_invalid_data_class <- function() {
  obs <- tryCatch(Basic_Stat$new(data = c(1,2)), error=conditionMessage)
  exp <- "data must be a matrix with at least one value"
  msg <- paste(base_msg, "An invalid data class did not generate an exception with expected message." )
  checkIdentical(obs, exp, msg)
}

## Invalid data dimensions
test.basic_stat_initialize_invalid_data_dimension <- function() {
  obs <- tryCatch(Basic_Stat$new(data = matrix()), error=conditionMessage)
  exp <- "data must be a matrix with at least one value"
  msg <- paste(base_msg, "Invalid data dimensions did not generate an exception with expected message." )
  checkIdentical(obs, exp, msg)
}

## Invalid alpha class
test.basic_stat_initialize_invalid_data_dimension <- function() {
  obs <- tryCatch(Basic_Stat$new(data = matrix()), error=conditionMessage)
  exp <- "data must be a matrix with at least one value"
  msg <- paste(base_msg, "Invalid data dimensions did not generate an exception with expected message." )
  checkIdentical(obs, exp, msg)
}

## Invalid average value
test.basic_stat_initialize_invalid_average_value <- function() {
  obs <- tryCatch(Basic_Stat$new(data = valid_data, average = "abc"), error=conditionMessage)
  exp <- "average parameter must be either 'mean' or 'median'"
  msg <- paste(base_msg, "Invalid average value did not generate an exception with expected message." )
  checkIdentical(obs, exp, msg)
}

## Invalid range class
test.basic_stat_initialize_invalid_range_class <- function() {
  obs <- tryCatch(Basic_Stat$new(data = valid_data, range = "abc"), error=conditionMessage)
  exp <- "range parameter must be a numeric of length 2"
  msg <- paste(base_msg, "Invalid range class did not generate an exception with expected message." )
  checkIdentical(obs, exp, msg)
}

## Invalid range length
test.basic_stat_initialize_invalid_range_length <- function() {
  obs <- tryCatch(Basic_Stat$new(data = valid_data, range = 1), error=conditionMessage)
  exp <- "range parameter must be a numeric of length 2"
  msg <- paste(base_msg, "Invalid range class did not generate an exception with expected message." )
  checkIdentical(obs, exp, msg)
}

## Invalid cores numeric values - zero
test.basic_stat_initialize_zero_core_number <- function() {
  obs <- tryCatch(Basic_Stat$new(data = valid_data, cores = 0), error=conditionMessage)
  exp <- "cores must be positive numeric or BiocParallelParam instance."
  msg <- paste(base_msg, "A zero core number argument did not generate an exception with expected message.")
  checkIdentical(obs, exp, msg)
}

## Invalid cores numeric values - negative value
test.basic_stat_initialize_negative_core_number <- function() {
  obs <- tryCatch(Basic_Stat$new(data = valid_data, cores = -1), error=conditionMessage)
  exp <- "cores must be positive numeric or BiocParallelParam instance."
  msg <- paste(base_msg, "A negative core number argument did not generate an exception with expected message.")
  checkIdentical(obs, exp, msg)
}

## Invalid cores non-numeric values - string
test.basic_stat_initialize_string_core_number <- function() {
  obs <- tryCatch(Basic_Stat$new(data = valid_data, cores = "1"), error=conditionMessage)
  exp <- "cores must be positive numeric or BiocParallelParam instance."
  msg <- paste(base_msg, "A string core number argument did not generate an exception with expected message.")
  checkIdentical(obs, exp, msg)
}

###################################################
## Test the Basic_Stats$get_statistics() function
###################################################

base_msg <- "Basic_Stat get_statistics -"

## Valid case
test.basic_stat_get_statistics_valid_case <- function() {
  basic_stat <- Basic_Stat$new(data = valid_data)
  obs <- basic_stat$get_statistics()
  msg <- paste(base_msg, "Statistics do not have correct class.")
  checkEquals(class(obs), "data.frame", msg)
  msg <- paste(base_msg, "Statistics do not have the correct dimensions.")
  checkIdentical(as.numeric(dim(obs)), c(20, 4), msg)
  msg <- paste(base_msg, "Statistics do not have the right colnames.")
  checkIdentical(colnames(obs), c("position", "value", "qinf", "qsup"), msg)
}