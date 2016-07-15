library(magrittr)
library(openxlsx)
library(stringi)
read.xlsx('data/eRum.xlsx', rows = 13:69) -> eRum

eRum[!grepl("OPŁ.BANK.|ZLECONE", eRum[, 1]), ] %>%
  gsub(pattern = "[0-9,-]|/EUR/|WB|ERUM|EUR|eRUM|eRum|WORKSHOP", "", .) %>%
  stri_extract_all_words() %>%
  lapply(paste, collapse = " ") %>%
  unlist %>%
  unique %>%
  write.table(file = "data/who_payed.txt", 
              quote = FALSE, 
              row.names = FALSE, 
              col.names = FALSE)
