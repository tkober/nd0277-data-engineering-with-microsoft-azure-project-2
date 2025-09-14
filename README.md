#### ND0277 - Data Engineering with Microsoft Azure

# Project 2: Cloud Data Warehouse

As a first step I am going to transform the structure of the provided Divvy Dataset (see screenshot below) into a star schema. The entity `Account` is not provided in the dataset files for this project so it will not be covered in the DWH schema.

![alt text](images/divvy_db.png)

## Star Schema
In the following I will to describe the star schema with respect to given business requirements.

![alt text](images/star_schema_diagram.png)

**Time spent based on date/time factors:**
For this the `Fact_Trip` table can be combined with the dimensions `Dim_Date` and `Dim_Time`.

**Time spent based on start/end station:**
For this the `Fact_Trip` table can be combined with the dimension `Dim_Station`.

**Time spent based on riders age:**
This can be done by only using the `Fact_Trip` table as it holds the age of the rider at the trip time in an indexed column. Transforming this into its own dimension would be overhead as the foreign key would need an index anyways.

**Time spent based on membership status of the rider:**
For this the `Fact_Trip` table can be combined with the dimension `Dim_Rider` which holds a boolean flag for this.

**Money spent per month/quarter/year:**
For this the `Fact_Payment` table can be combined with the dimension `Dim_Date`.

**Money spent based on rider signup age:**
For this the `Fact_Payment` table can be combined with the dimension `Dim_Rider`. The age at signup is implicitly given by `birthday` and `account_start_date`.

**Money spent per member based on avg. rides/minutes per month**
Here it is possible to join the member riders from `Dim_Rider` with the `Fact_Trip` and aggregate on the `duration` or count and group by the month and filtered for a given threshold. Afterwards this can be joined with the `Fact_Payment` table and summed up by rider.