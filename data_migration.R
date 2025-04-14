library(nycflights23)
library(DBI)
library(RPostgres)
library(yaml)

# Database Connection Function
db_connection <- function(config) {
  cnf <- yaml.load_file(config)
  pg_cnf <- cnf[['postgres']]
  conn <- dbConnect(
    Postgres(),
    dbname = "nycflights23",
    host = pg_cnf[["host"]],
    port = as.integer(pg_cnf[["port"]]),
    user = pg_cnf[["user"]],
    password = pg_cnf[["password"]]
  )
  return(conn)
}

# Establish connection
config_file <- "C:\\Users\\Admin\\Documents\\R_software\\R session\\database_connection\\config.yaml"
conn <- db_connection(config_file)

# Function to write data to database
write_to_db <- function(conn, table_name, data) {
  dbSendQuery(conn, paste0("DROP TABLE IF EXISTS ", table_name))
  dbWriteTable(conn, table_name, data, row.names = FALSE, overwrite = TRUE)
  print(paste("Data inserted into", table_name))
}

# Add multiple datasets
datasets <- list(
  planes = nycflights23::planes,
  flights = nycflights23::flights,
  weather = nycflights23::weather,
  airlines = nycflights23::airlines,
  airports = nycflights23::airports
)

for (name in names(datasets)) {
  write_to_db(conn, name, datasets[[name]])
}

# Query and print a sample of the data
for (name in names(datasets)) {
  result <- dbGetQuery(conn, paste0("SELECT * FROM ", name, " LIMIT 10"))
  print(paste("Sample data from", name))
  print(result)
}

# Close connection
dbDisconnect(conn)
print("Database connection closed.")


#create a repository and clone it using R.
