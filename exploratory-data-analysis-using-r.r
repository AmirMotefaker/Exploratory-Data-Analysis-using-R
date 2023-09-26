{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"source":"<a href=\"https://www.kaggle.com/code/amirmotefaker/exploratory-data-analysis-using-r?scriptVersionId=144306981\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown"},{"cell_type":"markdown","source":"# Prerequisites","metadata":{}},{"cell_type":"code","source":"library(tidyverse)","metadata":{"_uuid":"8f2839f25d086af736a60e9eeb907d3b93b6e0e5","_cell_guid":"b1076dfc-b9ad-4769-8c92-a6c4dae69d19","execution":{"iopub.status.busy":"2023-09-26T10:30:40.118133Z","iopub.execute_input":"2023-09-26T10:30:40.120083Z","iopub.status.idle":"2023-09-26T10:30:41.507218Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Variation\n- Variation is the tendency of the values of a variable to change from measurement to measurement. You can see variation easily in real life; if you measure any continuous variable twice, you will get two different results. This is true even if you measure quantities that are constant, like the speed of light. Each of your measurements will include a small amount of error that varies from measurement to measurement. Categorical variables can also vary if you measure across different subjects (e.g. the eye colors of different people), or at different times (e.g. the energy levels of an electron at different moments). Every variable has its own pattern of variation, which can reveal interesting information. The best way to understand that pattern is to visualize the distribution of the variable’s values.","metadata":{}},{"cell_type":"markdown","source":"##  Visualising distributions\n- How you visualize the distribution of a variable will depend on whether the variable is categorical or continuous. A variable is categorical if it can only take one of a small set of values. In R, categorical variables are usually saved as factors or character vectors. To examine the distribution of a categorical variable, use a bar chart.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds) +\n  geom_bar(mapping = aes(x = cut))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:41.509328Z","iopub.execute_input":"2023-09-26T10:30:41.535687Z","iopub.status.idle":"2023-09-26T10:30:42.16592Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- The height of the bars displays how many observations occurred with each x value. You can compute these values manually with dplyr::count():","metadata":{}},{"cell_type":"code","source":"# How many observations occurred with each x value\ndiamonds %>% \n  count(cut)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:42.167982Z","iopub.execute_input":"2023-09-26T10:30:42.169098Z","iopub.status.idle":"2023-09-26T10:30:42.245766Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- A variable is continuous if it can take any of an infinite set of ordered values. Numbers and date-times are two examples of continuous variables. To examine the distribution of a continuous variable, use a histogram:","metadata":{}},{"cell_type":"code","source":"# To examine the distribution of a continuous variable, use a histogram\nggplot(data = diamonds) +\n  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:42.247463Z","iopub.execute_input":"2023-09-26T10:30:42.248494Z","iopub.status.idle":"2023-09-26T10:30:42.510776Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- You can compute this by hand by combining dplyr::count() and ggplot2::cut_width():","metadata":{}},{"cell_type":"code","source":"diamonds %>% \n  count(cut_width(carat, 0.5))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:42.512595Z","iopub.execute_input":"2023-09-26T10:30:42.513708Z","iopub.status.idle":"2023-09-26T10:30:42.548553Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- A histogram divides the x-axis into equally spaced bins and then uses the height of a bar to display the number of observations that fall in each bin. In the graph above, the tallest bar shows that almost 30,000 observations have a carat value between 0.25 and 0.75, which are the left and right edges of the bar.\n\n- You can set the width of the intervals in a histogram with the binwidth argument, which is measured in the units of the x variable. You should always explore a variety of binwidths when working with histograms, as different binwidths can reveal different patterns. For example, here is how the graph above looks when we zoom into just the diamonds with a size of fewer than three carats and choose a smaller binwidth.","metadata":{}},{"cell_type":"code","source":"# You can set the width of the intervals in a histogram with the binwidth argument, \n# which is measured in the units of the x variable.\nsmaller <- diamonds %>% \n  filter(carat < 3)\n  \nggplot(data = smaller, mapping = aes(x = carat)) +\n  geom_histogram(binwidth = 0.1)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:42.550362Z","iopub.execute_input":"2023-09-26T10:30:42.551465Z","iopub.status.idle":"2023-09-26T10:30:42.770186Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- If you wish to overlay multiple histograms in the same plot, I recommend using geom_freqpoly() instead of geom_histogram(). geom_freqpoly() performs the same calculation as geom_histogram(), but instead of displaying the counts with bars, uses lines instead. It’s much easier to understand overlapping lines than bars.","metadata":{}},{"cell_type":"code","source":"# multiple histograms in the same plot\nggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +\n  geom_freqpoly(binwidth = 0.1)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:42.771952Z","iopub.execute_input":"2023-09-26T10:30:42.772972Z","iopub.status.idle":"2023-09-26T10:30:43.195733Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Typical values","metadata":{}},{"cell_type":"markdown","source":"- In both bar charts and histograms, tall bars show the common values of a variable, and shorter bars show less-common values. Places that do not have bars reveal values that were not seen in your data. To turn this information into useful questions, look for anything unexpected:\n\n    - Which values are the most common? Why?\n\n    - Which values are rare? Why? Does that match your expectations?\n\n    - Can you see any unusual patterns? What might explain them?\n    \n- As an example, the histogram below suggests several interesting questions:\n\n    - Why are there more diamonds at whole carats and common fractions of carats?\n\n    - Why are there more diamonds slightly to the right of each peak than there are slightly to the left of each peak?\n\n    - Why are there no diamonds bigger than 3 carats?","metadata":{}},{"cell_type":"code","source":"# Why are there more diamonds at whole carats and common fractions of carats?\n# Why are there more diamonds slightly to the right of each peak than there are slightly to the left of each peak?\n# Why are there no diamonds bigger than 3 carats?\nggplot(data = smaller, mapping = aes(x = carat)) +\n  geom_histogram(binwidth = 0.01)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:43.198958Z","iopub.execute_input":"2023-09-26T10:30:43.200735Z","iopub.status.idle":"2023-09-26T10:30:43.437963Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# How are the observations within each cluster similar to each other?\n# How are the observations in separate clusters different from each other?\n# How can you explain or describe the clusters?\n# Why might the appearance of clusters be misleading?\nggplot(data = faithful, mapping = aes(x = eruptions)) + \n  geom_histogram(binwidth = 0.25)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:43.44095Z","iopub.execute_input":"2023-09-26T10:30:43.442263Z","iopub.status.idle":"2023-09-26T10:30:43.650817Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Unusual values","metadata":{}},{"cell_type":"markdown","source":"- Outliers are observations that are unusual; data points that don’t seem to fit the pattern. \n- Take the distribution of the y variable from the diamonds dataset. The only evidence of outliers is the unusually wide limits on the x-axis.","metadata":{}},{"cell_type":"code","source":"ggplot(diamonds) + \n  geom_histogram(mapping = aes(x = y), binwidth = 0.5)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:43.652819Z","iopub.execute_input":"2023-09-26T10:30:43.653952Z","iopub.status.idle":"2023-09-26T10:30:43.870385Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- There are so many observations in the common bins that the rare bins are so short that you can’t see them (although maybe if you stare intently at 0 you’ll spot something). To make it easy to see the unusual values, we need to zoom to small values of the y-axis with coord_cartesian():","metadata":{}},{"cell_type":"code","source":"ggplot(diamonds) + \n  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +\n  coord_cartesian(ylim = c(0, 50))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:43.873229Z","iopub.execute_input":"2023-09-26T10:30:43.874565Z","iopub.status.idle":"2023-09-26T10:30:44.095408Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"unusual <- diamonds %>% \n  filter(y < 3 | y > 20) %>% \n  select(price, x, y, z) %>%\n  arrange(y)\nunusual","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:44.098785Z","iopub.execute_input":"2023-09-26T10:30:44.100522Z","iopub.status.idle":"2023-09-26T10:30:44.166871Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Missing values","metadata":{}},{"cell_type":"code","source":"# Drop the entire row with the strange values\ndiamonds2 <- diamonds %>% \n  filter(between(y, 3, 20))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:44.170099Z","iopub.execute_input":"2023-09-26T10:30:44.171809Z","iopub.status.idle":"2023-09-26T10:30:44.194531Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Replacing the unusual values with missing values\ndiamonds2 <- diamonds %>% \n  mutate(y = ifelse(y < 3 | y > 20, NA, y))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:44.19755Z","iopub.execute_input":"2023-09-26T10:30:44.198876Z","iopub.status.idle":"2023-09-26T10:30:44.214599Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# ggplot2 subscribes to the philosophy that missing values should never silently go missing. \n# It’s not obvious where you should plot missing values, so ggplot2 doesn’t include them in the plot, \n# but it does warn that they’ve been removed.\nggplot(data = diamonds2, mapping = aes(x = x, y = y)) + \n  geom_point()","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:44.218476Z","iopub.execute_input":"2023-09-26T10:30:44.220408Z","iopub.status.idle":"2023-09-26T10:30:47.973006Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# to suppress that warning, set na.rm = TRUE\nggplot(data = diamonds2, mapping = aes(x = x, y = y)) + \n  geom_point(na.rm = TRUE)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:47.976243Z","iopub.execute_input":"2023-09-26T10:30:47.979907Z","iopub.status.idle":"2023-09-26T10:30:50.64777Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# understand what makes observations with missing values different to observations with recorded values\nnycflights13::flights %>% \n  mutate(\n    cancelled = is.na(dep_time),\n    sched_hour = sched_dep_time %/% 100,\n    sched_min = sched_dep_time %% 100,\n    sched_dep_time = sched_hour + sched_min / 60\n  ) %>% \n  ggplot(mapping = aes(sched_dep_time)) + \n    geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:50.650373Z","iopub.execute_input":"2023-09-26T10:30:50.652124Z","iopub.status.idle":"2023-09-26T10:30:54.00427Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Covariation","metadata":{}},{"cell_type":"markdown","source":"## A categorical and continuous variable","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds, mapping = aes(x = price)) + \n  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:54.007109Z","iopub.execute_input":"2023-09-26T10:30:54.009018Z","iopub.status.idle":"2023-09-26T10:30:54.377408Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### hard to see the difference in distribution because the overall counts differ so much:","metadata":{}},{"cell_type":"code","source":"ggplot(diamonds) + \n  geom_bar(mapping = aes(x = cut))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:54.37918Z","iopub.execute_input":"2023-09-26T10:30:54.380178Z","iopub.status.idle":"2023-09-26T10:30:54.612203Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- To make the comparison easier we need to swap what is displayed on the y-axis. Instead of displaying count, we’ll display density, which is the count standardised so that the area under each frequency polygon is one.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + \n  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:54.614026Z","iopub.execute_input":"2023-09-26T10:30:54.615015Z","iopub.status.idle":"2023-09-26T10:30:55.023561Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"#  take a look at the distribution of price by cut using geom_boxplot():\nggplot(data = diamonds, mapping = aes(x = cut, y = price)) +\n  geom_boxplot()","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:55.025437Z","iopub.execute_input":"2023-09-26T10:30:55.026565Z","iopub.status.idle":"2023-09-26T10:30:55.468909Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# take the class variable in the mpg dataset. You might be interested to know how highway mileage varies across classes:\nggplot(data = mpg, mapping = aes(x = class, y = hwy)) +\n  geom_boxplot()","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:55.470859Z","iopub.execute_input":"2023-09-26T10:30:55.471977Z","iopub.status.idle":"2023-09-26T10:30:55.7296Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# To make the trend easier to see, we can reorder class based on the median value of hwy:\nggplot(data = mpg) +\n  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:55.732863Z","iopub.execute_input":"2023-09-26T10:30:55.734207Z","iopub.status.idle":"2023-09-26T10:30:55.998281Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# If you have long variable names, geom_boxplot() will work better if you flip it 90°. You can do that with coord_flip().\nggplot(data = mpg) +\n  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +\n  coord_flip()","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:56.001433Z","iopub.execute_input":"2023-09-26T10:30:56.002754Z","iopub.status.idle":"2023-09-26T10:30:56.268416Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Two categorical variables","metadata":{}},{"cell_type":"code","source":"# To visualise the covariation between categorical variables, you’ll need to count the number of observations for each combination. \n# One way to do that is to rely on the built-in geom_count():\nggplot(data = diamonds) +\n  geom_count(mapping = aes(x = cut, y = color))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:56.271167Z","iopub.execute_input":"2023-09-26T10:30:56.272747Z","iopub.status.idle":"2023-09-26T10:30:56.631395Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# The size of each circle in the plot displays how many observations occurred at each combination of values. \n# Covariation will appear as a strong correlation between specific x values and specific y values.\ndiamonds %>% \n  count(color, cut)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:56.634401Z","iopub.execute_input":"2023-09-26T10:30:56.635567Z","iopub.status.idle":"2023-09-26T10:30:56.674772Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# visualise with geom_tile() and the fill aesthetic:\ndiamonds %>% \n  count(color, cut) %>%  \n  ggplot(mapping = aes(x = color, y = cut)) +\n    geom_tile(mapping = aes(fill = n))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:56.678152Z","iopub.execute_input":"2023-09-26T10:30:56.679597Z","iopub.status.idle":"2023-09-26T10:30:56.950739Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Two continuous variables","metadata":{}},{"cell_type":"code","source":"# draw a scatterplot with geom_point(). You can see covariation as a pattern in the points.\nggplot(data = diamonds) +\n  geom_point(mapping = aes(x = carat, y = price))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:56.953421Z","iopub.execute_input":"2023-09-26T10:30:56.954584Z","iopub.status.idle":"2023-09-26T10:30:58.851122Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Scatterplots become less useful as the size of your dataset grows, because points begin to overplot,\n# and pile up into areas of uniform black (as above). You’ve already seen one way to fix the problem: \n# using the alpha aesthetic to add transparency.\nggplot(data = diamonds) + \n  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:30:58.854439Z","iopub.execute_input":"2023-09-26T10:30:58.857233Z","iopub.status.idle":"2023-09-26T10:31:00.828702Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# geom_bin2d() and geom_hex() divide the coordinate plane into 2d bins and then use a fill color to display \n# how many points fall into each bin. geom_bin2d() creates rectangular bins.\nggplot(data = smaller) +\n  geom_bin2d(mapping = aes(x = carat, y = price))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:00.831452Z","iopub.execute_input":"2023-09-26T10:31:00.833041Z","iopub.status.idle":"2023-09-26T10:31:01.143294Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# install.packages(\"hexbin\")","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:01.145329Z","iopub.execute_input":"2023-09-26T10:31:01.146538Z","iopub.status.idle":"2023-09-26T10:31:01.155678Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"ggplot(data = smaller) +\n  geom_hex(mapping = aes(x = carat, y = price))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:01.157589Z","iopub.execute_input":"2023-09-26T10:31:01.15884Z","iopub.status.idle":"2023-09-26T10:31:01.532156Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Another option is to bin one continuous variable so it acts like a categorical variable. \n# Then you can use one of the techniques for visualising the combination of a categorical and a continuous variable\nggplot(data = smaller, mapping = aes(x = carat, y = price)) + \n  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:01.541903Z","iopub.execute_input":"2023-09-26T10:31:01.543896Z","iopub.status.idle":"2023-09-26T10:31:02.05274Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Another approach is to display approximately the same number of points in each bin. That’s the job of cut_number():\nggplot(data = smaller, mapping = aes(x = carat, y = price)) + \n  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:02.05475Z","iopub.execute_input":"2023-09-26T10:31:02.055875Z","iopub.status.idle":"2023-09-26T10:31:02.509126Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- Two dimensional plots reveal outliers that are not visible in one dimensional plots. For example, some points in the plot below have an unusual combination of x and y values, which makes the points outliers even though their x and y values appear normal when examined separately.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds) +\n  geom_point(mapping = aes(x = x, y = y)) +\n  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:02.511507Z","iopub.execute_input":"2023-09-26T10:31:02.512803Z","iopub.status.idle":"2023-09-26T10:31:04.463493Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Patterns and models","metadata":{}},{"cell_type":"code","source":"# A scatterplot of Old Faithful eruption lengths versus the wait time between eruptions shows a pattern: \n# longer wait times are associated with longer eruptions. \n# The scatterplot also displays the two clusters that we noticed above.\nggplot(data = faithful) + \n  geom_point(mapping = aes(x = eruptions, y = waiting))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:04.46559Z","iopub.execute_input":"2023-09-26T10:31:04.466793Z","iopub.status.idle":"2023-09-26T10:31:04.68309Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- Models are a tool for extracting patterns out of data. For example, consider the diamonds data. It’s hard to understand the relationship between cut and price, because cut and carat, and carat and price are tightly related. It’s possible to use a model to remove the very strong relationship between price and carat so we can explore the subtleties that remain. The following code fits a model that predicts price from carat and then computes the residuals (the difference between the predicted value and the actual value). The residuals give us a view of the price of the diamond, once the effect of carat has been removed.","metadata":{}},{"cell_type":"code","source":"library(modelr)\n\nmod <- lm(log(price) ~ log(carat), data = diamonds)\n\ndiamonds2 <- diamonds %>% \n  add_residuals(mod) %>% \n  mutate(resid = exp(resid))\n\nggplot(data = diamonds2) + \n  geom_point(mapping = aes(x = carat, y = resid))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:04.684999Z","iopub.execute_input":"2023-09-26T10:31:04.686173Z","iopub.status.idle":"2023-09-26T10:31:06.651371Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- Once you’ve removed the strong relationship between carat and price, you can see what you expect in the relationship between cut and price: relative to their size, better quality diamonds are more expensive.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds2) + \n  geom_boxplot(mapping = aes(x = cut, y = resid))","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:06.653224Z","iopub.execute_input":"2023-09-26T10:31:06.654357Z","iopub.status.idle":"2023-09-26T10:31:07.018567Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# ggplot2 calls","metadata":{}},{"cell_type":"code","source":"ggplot(data = faithful, mapping = aes(x = eruptions)) + \n  geom_freqpoly(binwidth = 0.25)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:07.020535Z","iopub.execute_input":"2023-09-26T10:31:07.021675Z","iopub.status.idle":"2023-09-26T10:31:07.214981Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"ggplot(faithful, aes(eruptions)) + \n  geom_freqpoly(binwidth = 0.25)","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:07.216909Z","iopub.execute_input":"2023-09-26T10:31:07.218034Z","iopub.status.idle":"2023-09-26T10:31:07.415808Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Sometimes we’ll turn the end of a pipeline of data transformation into a plot. \n# Watch for the transition from %>% to +. I wish this transition wasn’t necessary \n# but unfortunately ggplot2 was created before the pipe was discovered.\ndiamonds %>% \n  count(cut, clarity) %>% \n  ggplot(aes(clarity, cut, fill = n)) + \n    geom_tile()","metadata":{"execution":{"iopub.status.busy":"2023-09-26T10:31:07.418821Z","iopub.execute_input":"2023-09-26T10:31:07.420074Z","iopub.status.idle":"2023-09-26T10:31:07.695619Z"},"trusted":true},"execution_count":null,"outputs":[]}]}