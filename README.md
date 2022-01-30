# COVID-19 Testing Application Database Implementation
### Relational	Model:
1. **Category** (<ins>categoryName</ins>,	priority)

2. **Person** (<ins>healthInsuranceNo</ins>,	personName,	doBirth,	gender,	phoneNo,	streetAddress, postalCode,	city,	registrationDate,	categoryName)<br/>
*categoryName* foreign key references relation **Category**

3. **VaccinationLocation** (<ins>locationName</ins>,	streetAddress,	postalCode,	city)

4. **Hospital** (<ins>locationName</ins>)<br/>
*locationName* foreign key references relation **VaccinationLocation**

5. **Nurse** (<ins>licenseNo</ins>,	nurseName,	locationName)<br/>
*locationName*	foreign	key	references	relation	**Hospital**

6. **AdministratedDate** (<ins>slotDate,	locationName</ins>)<br/>
*locationName*	foreign	key	references	relation	**VaccinationLocation**

7. **Vaccine** (<ins>vaccineName</ins>,	totalDosesNeeded,	timeBetweenDoses)

8. **Batch** (<ins>vaccineName,	batchNo</ins>,	expiryDate,	manufactureDate, count, locationName)<br/>
*vaccineName*	foreign	key	references	relation	**Vaccine**<br/>
*locationName*	foreign	key	references	relation	**VaccinationLocation**

9. **Vial** (<ins>vaccineName,	batchNo,	vialNo</ins>)<br/>
*(vaccineName,	batchNo)*	foreign	key	references	relation	**Batch**

10. **Deputed** (<ins>licenseNo, slotDate, locationName</ins>)<br/>
*(slotDate,	locationName)* foreign	key	references	relation	**AdministratedDate**<br/>
*licenseNo*	foreign	key	references	relation	**Nurse**

11. **Slot** (<ins>slotID</ins>,	slotDate, locationName,	slotTime,	allocationDate,	allocationTime,	
healthInsuranceNo,	(vaccineName,	batchNo,	vialNo),	licenseNo)<br/>
*(slotDate,	locationName)* foreign	key	references	relation	**AdministratedDate**<br/>
*healthInsuranceNo*	foreign	key	references	relation	**Person**<br/>
*(vaccineName,	batchNo,	vialNo)*	foreign	key	references	relation	**Vial**<br/>
*licenseNo*	foreign	key	references	relation	**Nurse**<br/>

### ER Diagram:
![image](https://github.com/beyza-yildirim/COVID-19-Database-Implementation/blob/main/ER_Diagram.jpg)

### Database Creation:
For this project, IBM DB2 was used. The database tables can be [created](createtbl.sql), [dropped](droptable.sql) and [populated](loaddata.sql) with the given SQL files.

### JDBC Program:
[JDBC Program](VaccineApp.java)

Demonstration of the JDBC Program on Command Line

![image](https://github.com/beyza-yildirim/COVID-19-Database-Implementation/blob/main/demo_img/option_1_demo.png)

![image](https://github.com/beyza-yildirim/COVID-19-Database-Implementation/blob/main/demo_img/option_2_3_demo.png)

![image](https://github.com/beyza-yildirim/COVID-19-Database-Implementation/blob/main/demo_img/data_analytics.png)
