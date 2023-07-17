install.packages("readr")
install.packages("psycho")
library(readr)
library(psycho)
library(writexl)
library(magicfor)

magic_for(silent = TRUE)

#===================AO_data======================================================
myfiles_ao<- list.files(#path = "./Desktop/Shakhlo_AV_task/data/", #change this directory to where you saved your .csv files
                     pattern="^[0123456789]{1,3}[A-Z]{3}_AO.*csv$")

# columns = c('subject', 'ao')
# output_df_ao = data.frame(matrix(nrow = 0, ncol = length(columns)))
# colnames(output_df_ao) = columns

for (subject in myfiles_ao) {
  
  
df_ao <- read_csv(subject) #change this directory to where you saved your .csv files
print(subject)

ao_hit<-nrow(subset(df_ao, (df_ao$corrAns==1&df_ao$key_resp.keys!="None")))
ao_fa<-nrow(subset(df_ao, (df_ao$corrAns!=1&df_ao$key_resp.keys!="None")))
ao_miss<-nrow(subset(df_ao, (df_ao$corrAns==1&df_ao$key_resp.keys=="None")))
ao_cr<-nrow(subset(df_ao, (df_ao$corrAns!=1&df_ao$key_resp.keys=="None")))
           
          indices_ao<-dprime(ao_hit, ao_fa, ao_miss, ao_cr)
          ao <- indices_ao$dprime
          put(ao)
}
df = magic_result_as_dataframe()

write_xlsx(df, "./ao_data.xlsx")

#========================AV+_data=======================================================
myfiles_avfull<- list.files(pattern="^[0123456789]{1,3}[A-Z]{3}_AV\\+.*csv$")


for (subject in myfiles_avfull) {

df_avfull <- read_csv(subject)
print(subject)

av_hit<-nrow(subset(df_avfull, (df_avfull$corrAns==1&df_avfull$key_resp_3.keys!="None")))
av_fa<-nrow(subset(df_avfull, (df_avfull$corrAns!=1&df_avfull$key_resp_3.keys!="None")))
av_miss<-nrow(subset(df_avfull, (df_avfull$corrAns==1&df_avfull$key_resp_3.keys=="None")))
av_cr<-nrow(subset(df_avfull, (df_avfull$corrAns!=1&df_avfull$key_resp_3.keys=="None")))
           
          indices_avfull<-dprime(av_hit, av_fa, av_miss, av_cr)
          avfull <- indices_avfull$dprime
          put(avfull)
}
df_avfull = magic_result_as_dataframe()

write_xlsx(df_avfull, "./av+_data.xlsx")


#========================AV-_data=============================================================
myfiles_avtemp<- list.files(pattern="^[0123456789]{1,3}[A-Z]{3}_AV\\-.*csv$")

for (subject in myfiles_avtemp) {
df_avtemp <- read_csv(subject)
print(subject)
           
n_hit<-nrow(subset(df_avtemp, (df_avtemp$corrAns==1&df_avtemp$key_resp_4.keys!="None")))
n_fa<-nrow(subset(df_avtemp, (df_avtemp$corrAns!=1&df_avtemp$key_resp_4.keys!="None")))
n_miss<-nrow(subset(df_avtemp, (df_avtemp$corrAns==1&df_avtemp$key_resp_4.keys=="None")))
n_cr<-nrow(subset(df_avtemp, (df_avtemp$corrAns!=1&df_avtemp$key_resp_4.keys=="None")))
           
           indices_avtemp<-dprime(n_hit, n_fa, n_miss, n_cr)
           avtemp <- indices_avtemp$dprime
           put(avtemp)
}
df_avtemp = magic_result_as_dataframe()

write_xlsx(df_avtemp, "./av-_data.xlsx")

