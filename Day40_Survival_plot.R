# plot survival curve
library(survival)
library(survminer)

data(cancer, package="survival")
View(cancer)
lung<- cancer


fit <- survfit(Surv(time, status) ~ sex, data = lung)
print(fit)
# Summary of survival curves
summary(fit)
# Access to the sort summary table
summary(fit)$table

#Create a data frame
d <- data.frame(time = fit$time,
                n.risk = fit$n.risk,
                n.event = fit$n.event,
                n.censor = fit$n.censor,
                surv = fit$surv,
                upper = fit$upper,
                lower = fit$lower
)
head(d)

#Visualize the survival curves

# Change color, linetype by strata, risk.table color by strata
ggsurvplot(fit,
           pval = TRUE, conf.int = TRUE,
           risk.table = TRUE, # Add risk table
           risk.table.col = "strata", # Change risk table color by groups
           linetype = "strata", # Change line type by groups
           surv.median.line = "hv", # Specify median survival
           ggtheme = theme_bw(), # Change ggplot2 theme
           palette = c("#E7B800", "#2E9FDF"))
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')

### use this webbsite for more info
##http://www.sthda.com/english/wiki/survival-analysis-basics


