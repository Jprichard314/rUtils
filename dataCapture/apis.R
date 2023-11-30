# R Utility Functions

# Getting data from a CARTO API
getData_phlCartoApi <- function(query,format = 'CSV'){
  
  
  # construct Request URL.
  service <- 'https://phl.carto.com/api/v2/sql?q='
  query   <- query
  format  <- format
  url     <- URLencode(
    paste(
      service
      , query
      ,"&Format=", format
      , sep=''
    )
  )
  
  # Get Data
  request <- httr::GET(url)
  
  # Header returns four items, the data is in the rows
  # item per https://carto.com/developers/sql-api/reference/#operation/getSQLStatement
  data_raw    <- httr::content(request)$rows
  
  #TODO: add any level of testing or error handling...
  
  # Write data to a data.frame
  data <- do.call(
    rbind
    , data_raw
  ) %>%
    as.data.frame %>%
    # Coerce all data to characters from lists
    mutate_all(as.character) %>%
    # Rewrite nulls to NA
    mutate_all(na_if,"NULL")
  return(data)
}


getData_cartoDbMonthQuery <- function(
    baseQuery
    , monthsOfData = 12
) 
{
  #'Purpose:
  #'  This function wraps a sql query written to Philadelphia's CartoDB Api because
  #'  url encoding doesn't seem to work well with Postgres's interval syntax.
  #'  
  #'  It takes today's date and captures back a number of months determined by the user.
  #'Input
  #'  baseQuery    -- Select and from statement for 
  #'  monthsOfData -- defaults to 12, but the number of months back we're capturing.
  #'Output
  #'  X months of 311 data.
  
  # calculate query date.
  start_date <- floor_date(
    Sys.Date()
    , unit = 'month'
  ) - months(monthsOfData)
  
  # Write query using glue.
  query <-  glue(
    "{baseQuery} '{start_date}'"
  )
  
  # get data
  temp <- getData_phlCartoApi( query )
  return(temp)
}