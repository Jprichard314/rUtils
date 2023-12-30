
### Write Datasets to SQl
writeFunction__toSQL <- function(
    dataset
  , schema
  , database
  , server
  , name
  , port
  , driver
  , overwrite = TRUE
  , append = FALSE
)
{
  # Connect to database:
  conn <- dbConnect(odbc()
            ,Driver = driver
            ,Server = server
            ,Database = database
            ,TrustServerCertificate="yes"
            ,Encrypt = "yes"
            ,Port = port
            ,Trusted_Connection = "yes"
  )
  
  
  # Write table:
  dbWriteTable(
      conn
    , name = Id(schema = schema, table = name)
    , value = dataset
    , overwrite = overwrite
    , append = append
  )
  
  
}
