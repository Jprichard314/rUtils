#' Generate a standard set of datefields on a dataset.
#'
#' @param field_datetime A column of dates. the field to generate dates from.
#' @param data A dataframe. the dataset to generate datefields for.
#'
#' @return a dataframe.
#' @export
#'
createDatetimeFields <- function(data, field_datetime){
  
  temp <- 
    data %>%
    mutate(!!glue::glue('{field_datetime}_week') := data[[field_datetime]] %>% lubridate::floor_date(., 'week'),
           !!glue::glue('{field_datetime}_month') := data[[field_datetime]] %>% lubridate::floor_date(., 'month'),
           !!glue::glue('{field_datetime}_day') := data[[field_datetime]] %>% lubridate::floor_date(., 'day')
           
           )
  
  return(temp)
  
  
}


createDatestable <- function(datetimeField){return('placeheld')}