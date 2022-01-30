-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.
CREATE TABLE Category
(
    categoryName VARCHAR(50) NOT NULL
    ,priority INT NOT NULL
    ,PRIMARY KEY (categoryName)
);

CREATE TABLE Person
(
    healthInsuranceNo VARCHAR(12) NOT NULL
    ,personName VARCHAR(50) NOT NULL
    ,doBirth DATE NOT NULL CHECK (doBirth>='1900-01-01')
    ,gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other'))
    ,phoneNo VARCHAR(10) NOT NULL
    ,streetAddress VARCHAR(100) NOT NULL
    ,postalCode VARCHAR(6) NOT NULL
    ,city VARCHAR(30) NOT NULL
    ,registrationDate DATE NOT NULL
    ,categoryName VARCHAR(50) NOT NULL
    ,PRIMARY KEY (healthInsuranceNo)
    ,FOREIGN KEY(categoryName) REFERENCES Category(categoryName)
);

CREATE TABLE VaccinationLocation
(
    locationName VARCHAR(50) NOT NULL
    ,streetAddress VARCHAR(100) NOT NULL
    ,postalCode VARCHAR(6) NOT NULL
    ,city VARCHAR(30) NOT NULL
    ,PRIMARY KEY (locationName)
);

CREATE TABLE Hospital
(
    locationName VARCHAR(50) NOT NULL
    ,PRIMARY KEY (locationName)
    ,FOREIGN KEY(locationName) REFERENCES VaccinationLocation(locationName)

);

CREATE TABLE Nurse
(
    licenseNo VARCHAR(15) NOT NULL
    ,nurseName VARCHAR(50) NOT NULL
    ,locationName VARCHAR(50) NOT NULL
    ,PRIMARY KEY (licenseNo)
    ,FOREIGN KEY(locationName) REFERENCES Hospital(locationName)
);

CREATE TABLE Vaccine
(
    vaccineName VARCHAR(50) NOT NULL
    ,totalDosesNeeded INT NOT NULL
    ,timeBetweenDoses VARCHAR(20) NOT NULL
    ,PRIMARY KEY (vaccineName)
    ,CHECK(totalDosesNeeded>=0)
);

CREATE TABLE Batch
(
    vaccineName VARCHAR(50) NOT NULL
    ,batchNo VARCHAR(20) NOT NULL
    ,expiryDate DATE NOT NULL
    ,manufactureDate DATE NOT NULL
    ,count INT NOT NULL
    ,locationName VARCHAR(50) NOT NULL
    ,PRIMARY KEY (vaccineName, batchNo)
    ,FOREIGN KEY(vaccineName) REFERENCES Vaccine(vaccineName)
    ,FOREIGN KEY(locationName) REFERENCES VaccinationLocation(locationName)
    ,CHECK (count>=0)
    --,CHECK (expiryDate>manufactureDate) this was asked in Q6 hence commented out
);

CREATE TABLE Vial
(
    vaccineName VARCHAR(50) NOT NULL
    ,batchNo VARCHAR(20) NOT NULL
    ,vialNo INT NOT NULL
    ,PRIMARY KEY (vaccineName, batchNo, vialNo)
    ,FOREIGN KEY (vaccineName, batchNo) REFERENCES Batch(vaccineName, batchNo)
    ,CHECK (vialNo>=1)

);

CREATE TABLE AdministratedDate
(
    slotDate DATE NOT NULL
    ,locationName VARCHAR(50) NOT NULL
    ,PRIMARY KEY (slotDate, locationName)
    ,FOREIGN KEY (locationName) REFERENCES VaccinationLocation(locationName)
);

CREATE TABLE Deputed
(
    licenseNo VARCHAR(15) NOT NULL
    ,locationName VARCHAR(50) NOT NULL
    ,slotDate DATE NOT NULL
    ,PRIMARY KEY (licenseNo, slotDate, locationName)
    ,FOREIGN KEY (licenseNo) REFERENCES Nurse(licenseNo)
    ,FOREIGN KEY (slotDate, locationName) REFERENCES AdministratedDate(slotDate, locationName)
);

CREATE TABLE Slot
(
    slotID VARCHAR(50) NOT NULL
    ,slotDate DATE NOT NULL
    ,slotTime TIME NOT NULL
    ,allocationDate DATE
    ,allocationTime TIME
    ,locationName VARCHAR(50) NOT NULL
    ,licenseNo VARCHAR(15)
    ,vaccineName VARCHAR(50)
    ,batchNo VARCHAR(20)
    ,vialNo INT
    ,healthInsuranceNo VARCHAR(12)
    ,PRIMARY KEY (slotID)
    ,FOREIGN KEY (slotDate, locationName) REFERENCES AdministratedDate(slotDate, locationName)
    ,FOREIGN KEY (licenseNo) REFERENCES Nurse(licenseNo)
    ,FOREIGN KEY (vaccineName, batchNo,vialNo) REFERENCES Vial(vaccineName, batchNo,vialNo)
    ,FOREIGN KEY (healthInsuranceNo) REFERENCES Person(healthInsuranceNo)
    ,CHECK (allocationDate<=slotDate)
);