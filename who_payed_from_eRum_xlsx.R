library(magrittr)
library(openxlsx)
library(stringi)
read.xlsx('data/eRum.xlsx', rows = 11:605) -> eRum

eRum[c((1:148)*4-1), ] -> eRum


eRum[!grepl("OPŁ.BANK.|ZLECONE|ODSETKI", eRum) ] %>%
  gsub(pattern = "[0-9,-]|/EUR/|WB|ERUM|EUR|eRUM|eRum|WORKSHOP", "", .) %>%
  stri_extract_all_words() %>%
  lapply(paste, collapse = " ") %>%
  unlist -> kto


eRum[!grepl("OPŁ.BANK.|ZLECONE|ODSETKI", eRum) ] %>%
  gsub(pattern = "699,58USD", "", .) %>%
  stri_extract_all_regex("([.0-9]+,[0-9]+)") %>%
  unlist -> ile

library(dplyr)
data.frame(kto, ile) %>%
  arrange(kto) %>%
  write.table(file = "data/who_payed.txt", 
              quote = FALSE, 
              row.names = FALSE, 
              col.names = FALSE)
