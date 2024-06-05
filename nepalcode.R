install.packages("timechange")
install.packages("carData")
install.packages("zoo")

library(tidyverse)
library(gapminder)
library(ggeffects)
library(modelsummary)
library(car)
library(zoo)
library(lmtest)
library(ggplot2)


nepaldata <- read.csv("completedata.csv")

# linear regression model
model = lm(maovote ~ maodeath + govtdeath + turnout + onesided, data = nepaldata)
model2 = lm(maovote ~ civdeath_mao + civdeath_gov + turnout + statebased, data = nepaldata)

summary(model)
summary(model2)

#models 1 and 2 show heteroscedasticity
bptest(model)
bptest(model2)

# weighted regression model
weight <- 1 / lm(abs(model$residuals) ~ model$fitted.values)$fitted.values^2
weight2 <- 1 / lm(abs(model2$residuals) ~ model2$fitted.values)$fitted.values^2

weightedmodel <- lm(maovote ~ maodeath + govtdeath + turnout + onesided, data = nepaldata, weights=weight)
weightedmodel2 <- lm(maovote ~ civdeath_mao + civdeath_gov + turnout + statebased, data = nepaldata, weights=weight2)

summary(weightedmodel)
summary(weightedmodel2)

#weighted model resolves heteroscedasticity
bptest(weightedmodel)
bptest(weightedmodel2)

#test for multicollinearity
vif(weightedmodel)
vif(weightedmodel2)


# predicted outcomes for model 1
preds = ggpredict(weightedmodel, terms = c("maodeath [0,120]"))|> 
  as_tibble()

preds1 = ggpredict(weightedmodel, terms = c("govtdeath [0,120]"))|> 
  as_tibble()

# predicted outcomes for model 2
preds2 = ggpredict(weightedmodel2, terms = c("civdeath_mao [0,120]"))|> 
  as_tibble()

preds3 = ggpredict(weightedmodel2, terms = c("civdeath_gov [0,120]"))|> 
  as_tibble()


# predicted outcome plots
ggplot(preds, aes(x = x, y = predicted, 
                  ymin = conf.low,
                  ymax = conf.high)) + 
  geom_line() + 
  geom_ribbon(alpha = .4) + 
  labs(x = "Rate of Maoist Deaths per 100,000 Eligible Voters", y = "Predicted Maoist Vote Share") +
  theme_minimal() + 
  theme(axis.text=element_text(size=10)) 


ggplot(preds1, aes(x = x, y = predicted, 
                   ymin = conf.low,
                   ymax = conf.high)) + 
  geom_line() + 
  geom_ribbon(alpha = .4) + 
  labs(x = "Rate of Government Deaths per 100,000 Eligible Voters", y = "Predicted Maoist Vote Share") +
  theme_minimal()

ggplot(preds2, aes(x = x, y = predicted, 
                   ymin = conf.low,
                   ymax = conf.high)) + 
  geom_line() + 
  geom_ribbon(alpha = .4) + 
  labs(x = "Rate of Civilian Deaths Perpetrated by Maoists per 100,000 Eligible Voters" , y = "Predicted Maoist Vote Share") +
  theme_minimal()

ggplot(preds3, aes(x = x, y = predicted, 
                   ymin = conf.low,
                   ymax = conf.high)) + 
  geom_line() + 
  geom_ribbon(alpha = .4) + 
  labs(x = "Rate of Civilian Deaths Perpetrated by Government Forces", y = "Predicted Maoist Vote Share") +
  theme_minimal()


# table showing the one-sided and state-based violence models
modelsummary(models = list("Model 1 (State-based Violence" = weightedmodel,
                           "Model 2 (One-sided Violence" = weightedmodel2), 
             gof_map = c("nobs", "r.squared"), output = "markdown")
