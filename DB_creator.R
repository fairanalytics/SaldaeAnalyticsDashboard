# Create an ephemeral in-memory RSQLite database
saldae_con <- DBI::dbConnect(RSQLite::SQLite(), "user_management2.db")


saldae_con <-  DBI::dbConnect(RSQLite::SQLite(),user= "karim", password= c("iekkel"))
  
user_names <- c("ali_la_pointe","said_ulamarea","ikkel_akka","Farid","Assirem")
user_passwords <- rep("ruh_at_wellit",length(user_names))
user_emails <- rep("contact@saldaeanalytics.com",length(user_names))
saldae_user_management_db <- data.frame(user_names,user_passwords,user_emails)

# DBI::dbListTables(con)

DBI::dbWriteTable(saldae_con, "users_info", saldae_user_management_db, overwrite = TRUE)
DBI::dbListTables(saldae_con)
DBI::dbDisconnect(saldae_con)
