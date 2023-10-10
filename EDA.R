countNA <- function(data)
{
  return(data %>% is.na %>% sum())
  
  
}

simpleEdaScript <- function(df)
{
  list_data <- list(
    columnNames = colnames(df)
    , length      = sapply(df,length)
    , countNA     = sapply(data,countNA)
  )
  
  df_eda <- 
    as.data.frame(
      do.call(
        cbind
        , list_data
      )
    ) %>%
    mutate_all(as.character)
  
  return(df_eda)
}  

