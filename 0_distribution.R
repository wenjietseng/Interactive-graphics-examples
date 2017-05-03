# static plots
par(mfcol = c(3, 2))
# 1
curve(dnorm(x, mean = -2, sd = 1),
      xlim = c(-5, 5), ylim = c(0, 0.5),
      xlab = "X", ylab = "P(X)")
abline(v = -2, lty = 2)
text(3.5, 0.45, expression(paste(mu,"=-2, ",sigma,"=1")))

# 2
curve(dnorm(x, mean = -1, sd = 1),
      xlim = c(-5, 5), ylim = c(0, 0.5),
      xlab = "X", ylab = "P(X)")
abline(v = -1, lty = 2)
text(3.5, 0.45, expression(paste(mu,"=-1, ",sigma,"=1")))

# 3
curve(dnorm(x, mean = 0, sd = 1),
      xlim = c(-5, 5), ylim = c(0, 0.5),
      xlab = "X", ylab = "P(X)")
abline(v = 0, lty = 2)
text(3.5, 0.45, expression(paste(mu,"=0, ",sigma,"=1")))

# 4
curve(dnorm(x, mean = 0, sd = 1),
      xlim = c(-5, 5), ylim = c(0, 0.5),
      xlab = "X", ylab = "P(X)")
abline(v = 0, lty = 2)
text(3.5, 0.45, expression(paste(mu,"=0, ",sigma,"=1")))

# 5
curve(dnorm(x, mean = 0, sd = 2),
      xlim = c(-5, 5), ylim = c(0, 0.5),
      xlab = "X", ylab = "P(X)")
abline(v = 0, lty = 2)
text(3.5, 0.45, expression(paste(mu,"=0, ",sigma,"=2")))

# 6
curve(dnorm(x, mean = 0, sd = 3),
      xlim = c(-5, 5), ylim = c(0, 0.5),
      xlab = "X", ylab = "P(X)")
abline(v = 0, lty = 2)
text(3.5, 0.45, expression(paste(mu,"=0, ",sigma,"=3")))

#####
# **Animation: normal distribution**
#```{r N_dist, echo = FALSE, fig.show = 'animate', #out.width = '4in'}
library(animation)
oopt <- ani.options(nmax = 255)
mu <- c(seq(from = -2, to = 0, by = 0.04),
        seq(from = 0, to = 2, by = 0.04),
        seq(from = 2, to = 0, by = -0.04),
        rep(0, 51),
        rep(0, 51))
sd <- c(rep(1, 51),
        rep(1, 51),
        rep(1, 51),
        seq(from = 1, to = 3, by = 0.04),
        seq(from = 3, to = 1, by = -0.04))

for(i in 1:ani.options("nmax")) {
  curve(dnorm(x, mean = mu[i], sd = sd[i]),
        xlim = c(-5, 5), ylim = c(0, 0.5),
        xlab = "X", ylab = "P(X)")
  abline(v = mu[i], lty = 2)
}