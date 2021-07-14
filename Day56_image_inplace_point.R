library("ggplot2")
library("ggimage")

# create a df

set.seed(2017-02-21)
d <- data.frame(x = rnorm(20),
                y = rnorm(20),
                image = sample(c("https://www.r-project.org/logo/Rlogo.png",
                                 "https://scontent.fdac24-1.fna.fbcdn.net/v/t1.6435-9/207929075_10223151770897022_655440490513558986_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=174925&_nc_ohc=5HcnA7Vx9eAAX8Eq-B3&tn=DeP3VFy7pTyUPJGu&_nc_ht=scontent.fdac24-1.fna&oh=1873c8aa96a49388666f23e9b2b7f0d3&oe=60F476C4",
                                 "https://scontent.fdac24-1.fna.fbcdn.net/v/t31.18172-8/13653403_10205714866745549_1681279285681604469_o.jpg?_nc_cat=111&ccb=1-3&_nc_sid=174925&_nc_ohc=aitQiW488psAX8esB8_&_nc_ht=scontent.fdac24-1.fna&oh=97475aa3d05f48f3f77beb972c8b4e89&oe=60F36044"),
                               size=20, replace = TRUE)
)
# plot2
ggplot(d, aes(x, y)) + geom_image(aes(image=image), size=.05)
