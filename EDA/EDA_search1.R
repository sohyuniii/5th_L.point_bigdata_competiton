setwd("C:/Users/wjssm/Desktop/lpoint/EDA")
library(readr); library(dplyr); library(ggplot2)
search1 <- read_csv("C:/Users/wjssm/Desktop/lpoint/data/02.Search1.csv")
#상품을 구매한 방문자가 검색창에 입력한 검색어에 대한 데이터

##########variable description########
### KWD_NM	검색키워드명 : 검색창에 입력한 검색 키워드
# 동일고객이라도 여러 개의 클라이언트ID를 보유할 수 있음
### SEARCH_CNT 검색건수 : 세션 내 해당 검색어 검색량
######################################

#1.NA - x
sum(!complete.cases(search1))

#2.
####CLNT_ID
table(search1$CLNT_ID) %>% length() #511477 clients ID
####SESS_ID
table(search1$SESS_ID) %>% length() #1160589 clients ID
####SEARCH_CNT
search1 %>% group_by(CLNT_ID) %>% summarise(count_mean = mean(SEARCH_CNT)) %>% 
  summary(count_mean)
search1 %>% group_by(SESS_ID) %>% summarise(count_mean = mean(SEARCH_CNT)) %>% 
  summary(count_mean)
