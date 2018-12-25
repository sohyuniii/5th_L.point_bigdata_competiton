setwd("C:/Users/wjssm/Desktop/lpoint/eda")
library(readr)
product <- read_csv("C:/Users/wjssm/Desktop/lpoint/data/01.Product.csv")

library(ggplot2); library(dplyr)
##########variable description########
### CLNT_ID	클라이언트ID : 방문자에 랜덤으로 부여된 고유 ID 
# 동일고객이라도 여러 개의 클라이언트ID를 보유할 수 있음

### SESS_ID	세션ID : Web/App에 접속 후 세션이 시작될 때 부여된 고유 ID
#나의 클라이언트ID에 여러 개의 세션ID가 발급될 수 있음

### HITS_SEQ	히트일련번호 : Web/App에서 방문자의 행위에 대해 순서대로 배열된 일련번호
# 세션 내에서 발생되며, 첫번째 행위에 대해서는 1로 설정됨

### PD_C	상품코드 : 구매한 상품의 코드(최소단위)

### PD_ADD_NM	상품추가정보

### PD_BRA_NM	상품브랜드

### PD_BUY_AM	단일상품금액 : 구매한 상품 1개의 금액

### PD_BUY_CT	구매건수 : 구매한 상품의 수량
#####################################


#1.#NA
product[!complete.cases(product),] #CLNT_ID 3007548, 5387167
View(product[(product$CLNT_ID==3007548)|(product$CLNT_ID==5387167), ])
#I can fill!
product[!complete.cases(product),'PD_BUY_CT']<-c(1440,1387)

dim(product) #5024906 * 8

#2.preprocessing
####CLNT_ID
table(product$CLNT_ID) %>% length() #922737 clients ID
####SESS_ID
table(product$SESS_ID) %>% length() #2425886 session ID
####HITS_SEQ
product %>% group_by(CLNT_ID) %>% summarise(max_hits = max(HITS_SEQ))
#hits가 많다는 건 고민이 많다..? 이것 저것 눌러본다...?
####PD_BRA_NM 통일 delete []
product$PD_BRA_NM<- gsub("\\[|\\]", "", product$PD_BRA_NM)
table(product$PD_BRA_NM) %>% length() #13745 brands
####PD_BUY_AM
ggplot(product)+geom_boxplot(aes(1, PD_BUY_AM))
summary(product$PD_BUY_AM)
