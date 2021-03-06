
# Project Proposal

## Problem Statement
The San Fransisco team would like to be able to discover new places to eat. They are particulary fond of food trucks. We would like to build a application that helps our San Fransisco team find alternative food truck options no matter where they are in the city.

## Proposed Solution
To allow our users to be able to discover new food truck from where ever they are in the city, we will build a food truck delivery application that is user friendly. The application will use a map and a table to allow users to browse and search for alternatives food truck near their desired area.

The following diagram illustrate how to approach such project when facing external customers.
![Demo Map](image/projectstep.png)

### Data
We will use the open data from [The San Fransisco local government](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data) as our primary source.
A copy of this CSV data and its [Data Dictionary](https://data.sfgov.org/api/views/rqzj-sfat/files/8g2f5RV4PEk0_b24iJEtgEet9gnh_eA27GlqoOjjK4k?download=true&filename=DPW_DataDictionary_Mobile-Food-Facility-Permit.pdf) are used for this application.

### Demo Tools
We will do rapid prototyping using the R language and Shiny package to demo the functionality. 

### Implementation Steps 
The following illustrates the steps for this project. We express each step with a user story. To read full user story please refer to the backlog section.

* __Story 01. Raw Data Cleanup.__
The original raw data from SFData requires clean up for several reasons, such as to remove incomplete data or columns that are not useful.
In addition to this we will change the title of the column so that it is easier for users to read. As a follow up might want to add a few columns that can help enrich the user experience, for example a summary of the food truck as description and food category. For more on this please see *05. Data Enrichment user story*.
The clean up job is a separate activity that can be executed regularly whenever the data needs to be updated. To do a clean up, we run the *datacleanup.R* file. The result of the data is stored at *Mobile_Food_Facility_Permit_Clean.csv*.

* __Story 02. View All Food Truck in Table.__
The first visualization is the table. Once the data has been prepared, we can show the data as a simple table. For a better user experience, we hide columns that are not relevant to the users for example Latitude and Longitude data. In this demo we use the Shiny package. 
The demo code for this is kept under *server.R* file.

* __Story 03. Simple search on Table.__
The table view will allow the users to search based on specific interest, for example searching based in zip code area, search based on food type, or search based on address where they are. To demonstrate the feature, we use the same Shiny package for the simple search and pagination feature. The demo code for this is kept under *server.R* file.

* __Story 04. View All Food Truck in Map.__
The second visualization is with a map. Search for food truck with a map will help users give spatial awareness on nearby food trucks. The user can decide for themselves the level of radius that is acceptable as distance. Using the latitude and longitude data, every food truck is placed in a map. To help focus, the map is centered at the center of the city and the whole city is visible as default.
The demo code for this is kept under *server.R* file.

## Next Steps
The rapid prototype will show the first iteration (MVP) of what the application could look like. Further validation is needed to see if this application is helping the users (San Francisco team) discover the food trucks that they like.
Therefore as a next step, we would release this application to a small set of beta users and conduct user interviews to validate our assumptions and check if there are missing key features that we needed to add to our backlog.

Based on the user feedback, we can expore other means to enhance the application. For example by connecting with other dataset.
One possible use case is to allow users to read reviews of other customers before making a decision. To achieve this, we could combine the original data with review and ratings data from [Yelp.com](https://www.yelp.com/). Please see *Story 06* for more information.

Another possible next steps is automate the the data update. [The DataSF site](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data) has specified that the data changes every week. Therefore to avoid obsolete data, the application need to refresh its dataset on a weekly bases. The maintenance of this data should be done automatically in the future. The scope of this work includes: automatically fetch new data from SFData website, run data clean up process and loading the application with the latest dataset.
Please see *Story 07* for more information.

## Appendix

### Backlog (User Stories)

---

#### Story 01. Raw Data Cleanup
As a user, I would like to view only relevant information in the app, so that I do not waste my time to go to addresses to find out the food truck is not available.

*Acceptance Criteria*
- Review and remove columns that will not be used, e.g. Supervisor.Districts, Schedule, NOISent, Permit number
- Remove row entry for food truck that has no permit. i.e. expired, inactive or suspend.

*Acceptance Test*

- *Given* the output file "Mobile_Food_Facility_Permit_Clean.csv"
 *When* we search for any food truck with status "expired"" or "inactive" or "suspend""
 *then* no food truck item with this status can be found.

- *Given* the output file "Mobile_Food_Facility_Permit_Clean.csv"
 *When* we search for "Schedule" or "Supervisor.Districts" or "NOISent" column title
 *then* no column with this title can be found.


---

#### Story 02. View All Food Truck in Table
As a user, I would like to see all of available Food Truck in a table, so that I can scan through all my options.

*Acceptance Criteria*
- All eligible food trucks will be presented as a table
- Assign user friendly names to the columns, for example, Name, Location, Food, Availability and Zip codes

*Acceptance Test*
- *Given* the application is launched successfully
 *When* we click on the Table tab
 *then* there will be a table containing food truck data with 8 columns (Name, FacilityType, Location, Status, Food, Availability, Zip.Codes, FoodType).


---

#### Story 03. Able to search or filter on the Table
As a user, I would like to be able to filter on the table to find the Food that meets my criteria.

*Acceptance Criteria*
- Allow users to filter result based on string match for every column, for example searching on all food tucks in one street.
- Allow general search for a match across the whole columns

*Acceptance Test*
- *Given* the Table tab has the data from the output file "Mobile_Food_Facility_Permit_Clean.csv"
 *When* I do a search on *Howard st* in the location field search
 *then* I will see 5 food trucks option, all having *Howard st* match in the location column.
 
- *Given* the Table tab shows the data from the output file "Mobile_Food_Facility_Permit_Clean.csv"
 *When* I specify *noodles* in the *food* field search
 *then* I will see 4 food trucks option, all offering noodles from the same company. 

---

#### Story 04. View All Food Truck in Map
As a user, I would like to see all available Food Truck in a map, so that I can see all avaliable options near where I am.

*Acceptance Criteria*
- The map shall focus on San Fransisco city as starting viewpoint.
- The map shall display all elegible food truck from the clean data.csv file in a form of a point.
- Upon clicking each point additional basic information shall be shown, e.g. name of food truck, the type of food offered, availablity hours and location.
- The user shall be able to zoom in and out and pan the map to explore nearby food truck.

*Acceptance Test*

*Given* the Map tab shows the data from the output file "Mobile_Food_Facility_Permit_Clean.csv"
*When* I navigate myself towards Channel Street near the harbor.
*then* I can see at least there are 3 food trucks near me: "Got Snacks", "Wonder Philly", and "Kabob Trolley"

*Given* the Map tab shows the data from the output file "Mobile_Food_Facility_Permit_Clean.csv"
*When* I navigate myself towards any point in SF city.
*then* I can see see and click any food truck and click the blue button to see more information.



---

#### Story 05. Data Enrichment with food category and display in Map and Table
As a user I would like to be able to search and filter food truck based on the food category

*Acceptance Criteria*
- Add information about Food Category for each food truck entry. For each entry, determine whether it is Asian food, Mexican food, Western food, or Other.
- Add a description on each point in a map. Upon request, e.g. by clicking, show the name, address, and what type of food to they serve.
* Add color and legend to the map so that users can easily see what types of food truck is available near him/her
- Show food types in the table so that the user can filter based on this category.
 
---

#### Story 06. Data Enrichment with Yelp customer reviews
As a user I would like to be able to make a selection based on Yelp review link

*Acceptance Criteria*
- Enrich the data for every food truck with Yelp link
- Add the link to every food truck description popup in the map
- Add the link for every food truck in a column on the table

---

#### Story 07. Automatic data fetching and update
As a user I would like to get updated food truck information so that I do not pick a food truck that no longer exist.

*Acceptance Criteria*
- Get new data from SFData every week.
- Execute the data clean up program every week.
- Refresh dataset for the app every week.

---

#### Story 08. Data Enrichment with Timeout recommendation
As a user I would like to be able to make a selection based on Timeout review

*Acceptance Criteria*
- Enrich the data for every food truck with Timeout link
- Add the link to every food truck description popup in the map
- Add the link for every food truck in a column on the table

---

### Screenshot of Demo
#### Table View
![Demo Table](image/table.png)
#### Map View
![Demo Map](image/map.png)
