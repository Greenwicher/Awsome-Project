# ????????��չ??
library(ggplot2)
library(gpclib)
library(maptools)
# ??ȡ??????Ϣ????
setwd("E:/study/mcm/2013/B/code/数据可视化")
load("CHN_adm1.RData")
# ?˾?ˮ??Դ��
water <- c(1111,1111,2222,3524,1079,2935,3989,2790,4147,358,2046,434
           ,1652,2490,451,9999,1467,871,2145,182,1000,1227,448,377,
           182,1221,3135,152,4976,1000,5298,2005)
# ??????תΪ???ݿ?
gpclibPermit()
china.map <- fortify(gadm,region='ID_1')
vals <- data.frame(id =unique(china.map$id),val=water)
# ??ggplot??????ͼ
ggplot(vals, aes(map_id = id)) + 
  geom_map(aes(fill = val), map =china.map) +
  expand_limits(x = china.map$long, y = china.map$lat) +
  scale_fill_continuous(low = 'red2',high ='yellowgreen',
                        guide = "colorbar") + 
  labs(title='?й??˾???ˮ??Դӵ??��',
       axis.line=element_blank(),axis.text.x=element_blank(),
       axis.text.y=element_blank(),axis.ticks=element_blank(),
       axis.title.x=element_blank(),
       axis.title.y=element_blank()) +
  xlab("") + ylab("")