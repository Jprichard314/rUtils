

countNA <- function(data)
{
  return(data %>% is.na %>% sum())
  
}

countUnique <- function(data)
{
  return(data %>% unique %>% length())
  
  
}

simpleEdaScript <- function(df)
{
  list_data <- list(
    columnNames = colnames(df)
    , type        = sapply(df, class)
    , length      = sapply(df,length)
    , countUnique = sapply(df,countUnique)
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

