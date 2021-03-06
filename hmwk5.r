#Exercise 05
#Feb 16 2022
#RCS

#-----------Question 1----------#
n_dims <- runif(1,3,10)
n_dims <- as.integer(n_dims)
n_dims2 <- seq(1:(n_dims^2))
sample(n_dims2) #sample vector
n_dims2_matrix <- matrix(n_dims2, ncol = n_dims, byrow = TRUE) #create matrix
n_dims2_matrix #print matrix
t(n_dims2_matrix) #transpose matrix
sum(n_dims2_matrix[,1]) #sum of first row
sum(n_dims2_matrix[,n_dims]) #sum of last row
mean(n_dims2_matrix[,1]) #mean of first row
mean(n_dims2_matrix[,n_dims]) #mean of last row

eigen(n_dims2_matrix)
typeof(n_dims2_matrix) #integer

#--------Question 2------------#
my_matrix <- matrix(data = runif(16), nrow = 4, byrow =TRUE)
my_logical <- runif(100)
my_logical <- my_logical <= 0.5
my_logical
my_letters <- sample(letters[1:26])
my_list <- list(my_matrix,my_logical,my_letters)
my_list
new_list <- list(my_matrix[2,2], my_logical[2], my_letters[2])
new_list

typeof(my_matrix)
typeof(my_logical)
typeof(my_letters)

unlisted <- unlist(new_list)
unlisted
new_list
unlisted2 <- c(new_list[[1]],new_list[[2]],new_list[[3]])
unlisted2
typeof(unlisted2)

#----------Question 3------------#
my_unis <- runif(26,0,10)
my_letters <- sample(toupper(letters[1:26]))
df <- data.frame(my_unis,my_letters)
df
df[sample(length(df$my_unis), replace = FALSE, size = 4),1] = NA
df
typeof(df)
which(is.na(df))
df[order(df$my_letters, decreasing = FALSE),]
df
mean(df$my_unis, na.rm = TRUE)
