## data frames
library(tidyverse)
example_df = tibble(
  vec_numeric = 1:4,
  vec_char = c('My', 'name', 'is', 'Zheyan'),
  vec_factor = factor(c('male','male','female','male')),
  define_name = 2:5
)
# draw some plots
plot_df = tibble(
  x = rnorm(1000, sd=0.5),
  y = 1 + 2 * x + rnorm(1000),
  y_quad = 1 + 2 * x + 3 * x^3 + rnorm(1000)
)
ggplot(plot_df,aes(x=x)) + geom_histogram(bins = 27)
ggplot(plot_df,aes(x=x,y=y)) + geom_point()
ggplot(plot_df,aes(x=x,y=y_quad)) + geom_point()

getwd()
ggsave('scatter_plot.pdf', height=4, width=4)

