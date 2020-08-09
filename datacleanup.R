library(stringr)

# This file does cleanup on the raw SFData

datapath = "C:/Users/Plato/Dropbox/1work/job_interviews/microsoft/FoodTruck/"
ft_data <- read.csv(file.path(datapath, "Mobile_Food_Facility_Permit.csv"), sep=",",header=TRUE)
ft_data <- data.frame(ft_data)
ft_data=filter(ft_data, Latitude != "NA") # removing NA values
ft_data=filter(ft_data, Longitude != "NA") # removing NA values

# Remove unneccessary columns 
# These columns should be reviewed again afterwards 
ft_data = subset(ft_data, select = -c(Supervisor.Districts, Fire.Prevention.Districts, Police.Districts,NOISent,Schedule,ExpirationDate,X,Y, Location, PriorPermit, permit, Approved, Address, locationid, cnn, lot, Received, blocklot, block, Received, Neighborhoods..old.) )


# create the popup style for every datapoint
ft_data <- mutate(ft_data, description=paste0('<strong>Name: </strong>',Applicant,
                                              '<br><strong>Food:</strong> ', FoodItems,
                                              '<br><strong>Address:</strong> ', LocationDescription,
                                              '<br><strong>Type:</strong> ', FacilityType,                                          
                                              '<br><strong>Availability:</strong> ',dayshours)) 

# simple enrich data
ft_data["ft_tacos"] = ""
ft_data["ft_sandwiches"] = ""
ft_data["ft_noodles"] = ""
ft_data["ft_hotdogs"] = ""
ft_data["ft_salads"] = ""

ft_data$FoodItems <- tolower(ft_data$FoodItems) 
ft_data$ft_tacos <- ifelse(grepl("tacos", ft_data$FoodItems), "yes", "no")
ft_data$ft_sandwiches <- ifelse(grepl("sandwiches", ft_data$FoodItems), "yes", "no")
ft_data$ft_noodles <- ifelse(grepl("noodles", ft_data$FoodItems), "yes", "no")
ft_data$ft_hotdogs <- ifelse(grepl("hotdogs", ft_data$FoodItems), "yes", "no")
ft_data$ft_salads <- ifelse(grepl("salads", ft_data$FoodItems), "yes", "no")

# Write clean data
write.csv(ft_data,file.path(datapath, "Mobile_Food_Facility_Permit_Clean.csv"))

