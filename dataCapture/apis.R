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
  )
  return(data)
}