library(stringr)

# This file does cleanup on the raw SFData
ft_data <- read.csv("Mobile_Food_Facility_Permit.csv", sep=",",header=TRUE)
ft_data <- data.frame(ft_data)


# Remove unneccessary columns 
# These columns should be reviewed again afterwards 
ft_data = subset(ft_data, select = -c(Supervisor.Districts, Fire.Prevention.Districts, Police.Districts,NOISent,Schedule,ExpirationDate,X,Y, Location, PriorPermit, permit, Approved, Address, locationid, cnn, lot, Received, blocklot, block, Received, Neighborhoods..old.) )

#Change the column to make it easier for users to understand
names(ft_data)[names(ft_data) == "Applicant"] <- "Name"
names(ft_data)[names(ft_data) == "FoodItems"] <- "Food"
names(ft_data)[names(ft_data) == "LocationDescription"] <- "Location"
names(ft_data)[names(ft_data) == "dayshours"] <- "Availability"


# Remove food truck with no permission and remove food truck with no coordinates
ft_data=filter(ft_data, Latitude != "NA") # removing NA values
ft_data=filter(ft_data, Longitude != "NA") # removing NA values

ft_data <- ft_data[!grepl("EXPIRED|SUSPEND|INACTIVE", ft_data$Status),]

# create the popup style for every datapoint
ft_data <- mutate(ft_data, description=paste0('<strong>Name: </strong>',Name,
                                              '<br><strong>Food:</strong> ', Food,
                                              '<br><strong>Location:</strong> ', Location,
                                              '<br><strong>Type:</strong> ', FacilityType,                                          
                                              '<br><strong>Availability:</strong> ', Availability)) 

# simple enrich data
ft_data["FoodType"] = ""


ft_data$Food <- tolower(ft_data$Food) 
#ft_data$FoodType <- ifelse(grepl("noodles", ft_data$Food), "yes", "no")
#ft_data$FoodType <- if(grepl("noodles", ft_data$Food)){return "Asian Food"}

# Write clean data
write.csv(ft_data,"Mobile_Food_Facility_Permit_Clean.csv",row.names=FALSE)

