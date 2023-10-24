{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"source":"<a href=\"https://www.kaggle.com/code/amirmotefaker/exploratory-data-analysis-using-r?scriptVersionId=147859138\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown"},{"cell_type":"markdown","source":"# Prerequisites","metadata":{}},{"cell_type":"code","source":"library(tidyverse)","metadata":{"_uuid":"8f2839f25d086af736a60e9eeb907d3b93b6e0e5","_cell_guid":"b1076dfc-b9ad-4769-8c92-a6c4dae69d19","execution":{"iopub.status.busy":"2023-10-15T09:19:03.605262Z","iopub.execute_input":"2023-10-15T09:19:03.607525Z","iopub.status.idle":"2023-10-15T09:19:05.200709Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Variation\n- Variation is the tendency of the values of a variable to change from measurement to measurement. You can see variation easily in real life; if you measure any continuous variable twice, you will get two different results. This is true even if you measure quantities that are constant, like the speed of light. Each of your measurements will include a small amount of error that varies from measurement to measurement. Categorical variables can also vary if you measure across different subjects (e.g. the eye colors of different people), or at different times (e.g. the energy levels of an electron at different moments). Every variable has its own pattern of variation, which can reveal interesting information. The best way to understand that pattern is to visualize the distribution of the variable’s values.","metadata":{}},{"cell_type":"markdown","source":"##  Visualising distributions\n- How you visualize the distribution of a variable will depend on whether the variable is categorical or continuous. A variable is categorical if it can only take one of a small set of values. In R, categorical variables are usually saved as factors or character vectors. To examine the distribution of a categorical variable, use a bar chart.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds) +\n  geom_bar(mapping = aes(x = cut))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:05.204381Z","iopub.execute_input":"2023-10-15T09:19:05.23866Z","iopub.status.idle":"2023-10-15T09:19:05.909919Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- The height of the bars displays how many observations occurred with each x value. You can compute these values manually with dplyr::count():","metadata":{}},{"cell_type":"code","source":"# How many observations occurred with each x value\ndiamonds %>% \n  count(cut)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:05.913721Z","iopub.execute_input":"2023-10-15T09:19:05.91567Z","iopub.status.idle":"2023-10-15T09:19:05.996268Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- A variable is continuous if it can take any of an infinite set of ordered values. Numbers and date-times are two examples of continuous variables. To examine the distribution of a continuous variable, use a histogram:","metadata":{}},{"cell_type":"code","source":"# To examine the distribution of a continuous variable, use a histogram\nggplot(data = diamonds) +\n  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:06.000491Z","iopub.execute_input":"2023-10-15T09:19:06.002396Z","iopub.status.idle":"2023-10-15T09:19:06.308531Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- You can compute this by hand by combining dplyr::count() and ggplot2::cut_width():","metadata":{}},{"cell_type":"code","source":"diamonds %>% \n  count(cut_width(carat, 0.5))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:06.312244Z","iopub.execute_input":"2023-10-15T09:19:06.313911Z","iopub.status.idle":"2023-10-15T09:19:06.356543Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- A histogram divides the x-axis into equally spaced bins and then uses the height of a bar to display the number of observations that fall in each bin. In the graph above, the tallest bar shows that almost 30,000 observations have a carat value between 0.25 and 0.75, which are the left and right edges of the bar.\n\n- You can set the width of the intervals in a histogram with the binwidth argument, which is measured in the units of the x variable. You should always explore a variety of binwidths when working with histograms, as different binwidths can reveal different patterns. For example, here is how the graph above looks when we zoom into just the diamonds with a size of fewer than three carats and choose a smaller binwidth.","metadata":{}},{"cell_type":"code","source":"# You can set the width of the intervals in a histogram with the binwidth argument, \n# which is measured in the units of the x variable.\nsmaller <- diamonds %>% \n  filter(carat < 3)\n  \nggplot(data = smaller, mapping = aes(x = carat)) +\n  geom_histogram(binwidth = 0.1)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:06.360121Z","iopub.execute_input":"2023-10-15T09:19:06.361841Z","iopub.status.idle":"2023-10-15T09:19:06.669815Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- If you wish to overlay multiple histograms in the same plot, I recommend using geom_freqpoly() instead of geom_histogram(). geom_freqpoly() performs the same calculation as geom_histogram(), but instead of displaying the counts with bars, uses lines instead. It’s much easier to understand overlapping lines than bars.","metadata":{}},{"cell_type":"code","source":"# multiple histograms in the same plot\nggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +\n  geom_freqpoly(binwidth = 0.1)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:06.673625Z","iopub.execute_input":"2023-10-15T09:19:06.675295Z","iopub.status.idle":"2023-10-15T09:19:08.307492Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Typical values","metadata":{}},{"cell_type":"markdown","source":"- In both bar charts and histograms, tall bars show the common values of a variable, and shorter bars show less-common values. Places that do not have bars reveal values that were not seen in your data. To turn this information into useful questions, look for anything unexpected:\n\n    - Which values are the most common? Why?\n\n    - Which values are rare? Why? Does that match your expectations?\n\n    - Can you see any unusual patterns? What might explain them?\n    \n- As an example, the histogram below suggests several interesting questions:\n\n    - Why are there more diamonds at whole carats and common fractions of carats?\n\n    - Why are there more diamonds slightly to the right of each peak than there are slightly to the left of each peak?\n\n    - Why are there no diamonds bigger than 3 carats?","metadata":{}},{"cell_type":"code","source":"# Why are there more diamonds at whole carats and common fractions of carats?\n# Why are there more diamonds slightly to the right of each peak than there are slightly to the left of each peak?\n# Why are there no diamonds bigger than 3 carats?\nggplot(data = smaller, mapping = aes(x = carat)) +\n  geom_histogram(binwidth = 0.01)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:08.311487Z","iopub.execute_input":"2023-10-15T09:19:08.314226Z","iopub.status.idle":"2023-10-15T09:19:08.879133Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# How are the observations within each cluster similar to each other?\n# How are the observations in separate clusters different from each other?\n# How can you explain or describe the clusters?\n# Why might the appearance of clusters be misleading?\nggplot(data = faithful, mapping = aes(x = eruptions)) + \n  geom_histogram(binwidth = 0.25)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:08.883138Z","iopub.execute_input":"2023-10-15T09:19:08.885684Z","iopub.status.idle":"2023-10-15T09:19:09.393542Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Unusual values","metadata":{}},{"cell_type":"markdown","source":"- Outliers are observations that are unusual; data points that don’t seem to fit the pattern. \n- Take the distribution of the y variable from the diamonds dataset. The only evidence of outliers is the unusually wide limits on the x-axis.","metadata":{}},{"cell_type":"code","source":"ggplot(diamonds) + \n  geom_histogram(mapping = aes(x = y), binwidth = 0.5)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:09.397598Z","iopub.execute_input":"2023-10-15T09:19:09.40019Z","iopub.status.idle":"2023-10-15T09:19:10.211643Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- There are so many observations in the common bins that the rare bins are so short that you can’t see them (although maybe if you stare intently at 0 you’ll spot something). To make it easy to see the unusual values, we need to zoom to small values of the y-axis with coord_cartesian():","metadata":{}},{"cell_type":"code","source":"ggplot(diamonds) + \n  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +\n  coord_cartesian(ylim = c(0, 50))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:10.218573Z","iopub.execute_input":"2023-10-15T09:19:10.224071Z","iopub.status.idle":"2023-10-15T09:19:10.726609Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"unusual <- diamonds %>% \n  filter(y < 3 | y > 20) %>% \n  select(price, x, y, z) %>%\n  arrange(y)\nunusual","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:10.733075Z","iopub.execute_input":"2023-10-15T09:19:10.738111Z","iopub.status.idle":"2023-10-15T09:19:10.828635Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Missing values","metadata":{}},{"cell_type":"code","source":"# Drop the entire row with the strange values\ndiamonds2 <- diamonds %>% \n  filter(between(y, 3, 20))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:10.833307Z","iopub.execute_input":"2023-10-15T09:19:10.835827Z","iopub.status.idle":"2023-10-15T09:19:10.866018Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Replacing the unusual values with missing values\ndiamonds2 <- diamonds %>% \n  mutate(y = ifelse(y < 3 | y > 20, NA, y))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:10.87001Z","iopub.execute_input":"2023-10-15T09:19:10.872549Z","iopub.status.idle":"2023-10-15T09:19:10.903665Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# ggplot2 subscribes to the philosophy that missing values should never silently go missing. \n# It’s not obvious where you should plot missing values, so ggplot2 doesn’t include them in the plot, \n# but it does warn that they’ve been removed.\nggplot(data = diamonds2, mapping = aes(x = x, y = y)) + \n  geom_point()","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:10.909226Z","iopub.execute_input":"2023-10-15T09:19:10.912538Z","iopub.status.idle":"2023-10-15T09:19:15.428068Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# to suppress that warning, set na.rm = TRUE\nggplot(data = diamonds2, mapping = aes(x = x, y = y)) + \n  geom_point(na.rm = TRUE)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:15.432059Z","iopub.execute_input":"2023-10-15T09:19:15.434013Z","iopub.status.idle":"2023-10-15T09:19:18.718443Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# understand what makes observations with missing values different to observations with recorded values\nnycflights13::flights %>% \n  mutate(\n    cancelled = is.na(dep_time),\n    sched_hour = sched_dep_time %/% 100,\n    sched_min = sched_dep_time %% 100,\n    sched_dep_time = sched_hour + sched_min / 60\n  ) %>% \n  ggplot(mapping = aes(sched_dep_time)) + \n    geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:18.72273Z","iopub.execute_input":"2023-10-15T09:19:18.724851Z","iopub.status.idle":"2023-10-15T09:19:22.242849Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Covariation","metadata":{}},{"cell_type":"markdown","source":"## A categorical and continuous variable","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds, mapping = aes(x = price)) + \n  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:22.245225Z","iopub.execute_input":"2023-10-15T09:19:22.246642Z","iopub.status.idle":"2023-10-15T09:19:22.708352Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### hard to see the difference in distribution because the overall counts differ so much:","metadata":{}},{"cell_type":"code","source":"ggplot(diamonds) + \n  geom_bar(mapping = aes(x = cut))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:22.710704Z","iopub.execute_input":"2023-10-15T09:19:22.712201Z","iopub.status.idle":"2023-10-15T09:19:23.007001Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- To make the comparison easier we need to swap what is displayed on the y-axis. Instead of displaying count, we’ll display density, which is the count standardised so that the area under each frequency polygon is one.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + \n  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:23.009718Z","iopub.execute_input":"2023-10-15T09:19:23.011227Z","iopub.status.idle":"2023-10-15T09:19:23.520725Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"#  take a look at the distribution of price by cut using geom_boxplot():\nggplot(data = diamonds, mapping = aes(x = cut, y = price)) +\n  geom_boxplot()","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:23.522935Z","iopub.execute_input":"2023-10-15T09:19:23.524256Z","iopub.status.idle":"2023-10-15T09:19:24.079273Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# take the class variable in the mpg dataset. You might be interested to know how highway mileage varies across classes:\nggplot(data = mpg, mapping = aes(x = class, y = hwy)) +\n  geom_boxplot()","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:24.08157Z","iopub.execute_input":"2023-10-15T09:19:24.083002Z","iopub.status.idle":"2023-10-15T09:19:24.391382Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# To make the trend easier to see, we can reorder class based on the median value of hwy:\nggplot(data = mpg) +\n  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:24.393686Z","iopub.execute_input":"2023-10-15T09:19:24.395073Z","iopub.status.idle":"2023-10-15T09:19:24.709396Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# If you have long variable names, geom_boxplot() will work better if you flip it 90°. You can do that with coord_flip().\nggplot(data = mpg) +\n  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +\n  coord_flip()","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:24.711601Z","iopub.execute_input":"2023-10-15T09:19:24.712903Z","iopub.status.idle":"2023-10-15T09:19:25.034937Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Two categorical variables","metadata":{}},{"cell_type":"code","source":"# To visualise the covariation between categorical variables, you’ll need to count the number of observations for each combination. \n# One way to do that is to rely on the built-in geom_count():\nggplot(data = diamonds) +\n  geom_count(mapping = aes(x = cut, y = color))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:25.037061Z","iopub.execute_input":"2023-10-15T09:19:25.03832Z","iopub.status.idle":"2023-10-15T09:19:25.537233Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# The size of each circle in the plot displays how many observations occurred at each combination of values. \n# Covariation will appear as a strong correlation between specific x values and specific y values.\ndiamonds %>% \n  count(color, cut)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:25.539523Z","iopub.execute_input":"2023-10-15T09:19:25.540946Z","iopub.status.idle":"2023-10-15T09:19:25.588081Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# visualise with geom_tile() and the fill aesthetic:\ndiamonds %>% \n  count(color, cut) %>%  \n  ggplot(mapping = aes(x = color, y = cut)) +\n    geom_tile(mapping = aes(fill = n))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:25.590528Z","iopub.execute_input":"2023-10-15T09:19:25.591904Z","iopub.status.idle":"2023-10-15T09:19:25.889487Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Two continuous variables","metadata":{}},{"cell_type":"code","source":"# draw a scatterplot with geom_point(). You can see covariation as a pattern in the points.\nggplot(data = diamonds) +\n  geom_point(mapping = aes(x = carat, y = price))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:25.891972Z","iopub.execute_input":"2023-10-15T09:19:25.893365Z","iopub.status.idle":"2023-10-15T09:19:28.571747Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Scatterplots become less useful as the size of your dataset grows, because points begin to overplot,\n# and pile up into areas of uniform black (as above). You’ve already seen one way to fix the problem: \n# using the alpha aesthetic to add transparency.\nggplot(data = diamonds) + \n  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:28.573948Z","iopub.execute_input":"2023-10-15T09:19:28.575262Z","iopub.status.idle":"2023-10-15T09:19:31.387092Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# geom_bin2d() and geom_hex() divide the coordinate plane into 2d bins and then use a fill color to display \n# how many points fall into each bin. geom_bin2d() creates rectangular bins.\nggplot(data = smaller) +\n  geom_bin2d(mapping = aes(x = carat, y = price))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:31.391274Z","iopub.execute_input":"2023-10-15T09:19:31.39397Z","iopub.status.idle":"2023-10-15T09:19:31.725286Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# install.packages(\"hexbin\")","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:31.729084Z","iopub.execute_input":"2023-10-15T09:19:31.730666Z","iopub.status.idle":"2023-10-15T09:19:31.741544Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"ggplot(data = smaller) +\n  geom_hex(mapping = aes(x = carat, y = price))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:31.743769Z","iopub.execute_input":"2023-10-15T09:19:31.74513Z","iopub.status.idle":"2023-10-15T09:19:32.194303Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Another option is to bin one continuous variable so it acts like a categorical variable. \n# Then you can use one of the techniques for visualising the combination of a categorical and a continuous variable\nggplot(data = smaller, mapping = aes(x = carat, y = price)) + \n  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:32.196838Z","iopub.execute_input":"2023-10-15T09:19:32.198251Z","iopub.status.idle":"2023-10-15T09:19:32.811477Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Another approach is to display approximately the same number of points in each bin. That’s the job of cut_number():\nggplot(data = smaller, mapping = aes(x = carat, y = price)) + \n  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:32.815375Z","iopub.execute_input":"2023-10-15T09:19:32.817455Z","iopub.status.idle":"2023-10-15T09:19:33.371635Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- Two dimensional plots reveal outliers that are not visible in one dimensional plots. For example, some points in the plot below have an unusual combination of x and y values, which makes the points outliers even though their x and y values appear normal when examined separately.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds) +\n  geom_point(mapping = aes(x = x, y = y)) +\n  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:33.374048Z","iopub.execute_input":"2023-10-15T09:19:33.375419Z","iopub.status.idle":"2023-10-15T09:19:36.213657Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Patterns and models","metadata":{}},{"cell_type":"code","source":"# A scatterplot of Old Faithful eruption lengths versus the wait time between eruptions shows a pattern: \n# longer wait times are associated with longer eruptions. \n# The scatterplot also displays the two clusters that we noticed above.\nggplot(data = faithful) + \n  geom_point(mapping = aes(x = eruptions, y = waiting))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:36.217517Z","iopub.execute_input":"2023-10-15T09:19:36.21931Z","iopub.status.idle":"2023-10-15T09:19:36.464597Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- Models are a tool for extracting patterns out of data. For example, consider the diamonds data. It’s hard to understand the relationship between cut and price, because cut and carat, and carat and price are tightly related. It’s possible to use a model to remove the very strong relationship between price and carat so we can explore the subtleties that remain. The following code fits a model that predicts price from carat and then computes the residuals (the difference between the predicted value and the actual value). The residuals give us a view of the price of the diamond, once the effect of carat has been removed.","metadata":{}},{"cell_type":"code","source":"library(modelr)\n\nmod <- lm(log(price) ~ log(carat), data = diamonds)\n\ndiamonds2 <- diamonds %>% \n  add_residuals(mod) %>% \n  mutate(resid = exp(resid))\n\nggplot(data = diamonds2) + \n  geom_point(mapping = aes(x = carat, y = resid))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:36.468345Z","iopub.execute_input":"2023-10-15T09:19:36.470577Z","iopub.status.idle":"2023-10-15T09:19:39.461075Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"- Once you’ve removed the strong relationship between carat and price, you can see what you expect in the relationship between cut and price: relative to their size, better quality diamonds are more expensive.","metadata":{}},{"cell_type":"code","source":"ggplot(data = diamonds2) + \n  geom_boxplot(mapping = aes(x = cut, y = resid))","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:39.464655Z","iopub.execute_input":"2023-10-15T09:19:39.46673Z","iopub.status.idle":"2023-10-15T09:19:39.894194Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# ggplot2 calls","metadata":{}},{"cell_type":"code","source":"ggplot(data = faithful, mapping = aes(x = eruptions)) + \n  geom_freqpoly(binwidth = 0.25)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:39.898475Z","iopub.execute_input":"2023-10-15T09:19:39.900287Z","iopub.status.idle":"2023-10-15T09:19:40.138224Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"ggplot(faithful, aes(eruptions)) + \n  geom_freqpoly(binwidth = 0.25)","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:40.142858Z","iopub.execute_input":"2023-10-15T09:19:40.145077Z","iopub.status.idle":"2023-10-15T09:19:40.379903Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Sometimes we’ll turn the end of a pipeline of data transformation into a plot. \n# Watch for the transition from %>% to +. I wish this transition wasn’t necessary \n# but unfortunately ggplot2 was created before the pipe was discovered.\ndiamonds %>% \n  count(cut, clarity) %>% \n  ggplot(aes(clarity, cut, fill = n)) + \n    geom_tile()","metadata":{"execution":{"iopub.status.busy":"2023-10-15T09:19:40.383998Z","iopub.execute_input":"2023-10-15T09:19:40.386404Z","iopub.status.idle":"2023-10-15T09:19:40.702449Z"},"trusted":true},"execution_count":null,"outputs":[]}]}