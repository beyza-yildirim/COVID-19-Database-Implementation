-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
-- A more complex syntax that saves you typing effort.
INSERT INTO Category (categoryName, priority) VALUES
 ('Healthcare Worker', 1)
,('Elderly', 1)
,('Immunologically Compromised', 1)
,('Teacher', 2)
,('Children below 10', 2)
,('Physical proximity to first priority', 2)
,('Essential Service Worker', 3)
,('Physical proximity to second priority', 3)
,('Other', 4)
;

INSERT INTO Person (healthInsuranceNo, personName, doBirth ,gender, phoneNo, streetAddress, postalCode, city, registrationDate, categoryName) VALUES
('OTHE14011912', 'Maya Adams', '1999-02-14', 'Female', '4387286760', '250 Rene Levesque', 'H2Z0B5', 'Montreal', '2021-02-01', 'Other')
,('IMMU94011912', 'Evan Smith', '1938-02-14', 'Male', '4387286760', '250 Rue de Bullion', 'H2Z0B5', 'Montreal', '2021-01-02', 'Immunologically Compromised')
,('HEAL14011912', 'Jane Doe', '1969-08-14', 'Female', '4387286760', '250 Rue University', 'H2Z0B5', 'Montreal', '2021-01-01', 'Healthcare Worker')
,('CHIL94011912', 'John Rock', '2015-05-14', 'Male', '4387286760', '250 Rue de Mar', 'H2Z0B5', 'Quebec', '2021-02-01', 'Children below 10')
,('OTHE24011912', 'Henry Maine', '2000-09-01', 'Male', '4387286760', '250 Rogers', 'H2Z0B5', 'Trois de Rivieres', '2021-02-01', 'Other')
,('OTHE34011912', 'Henry Louvre', '1996-09-01', 'Male', '4387286760', '250 Rogers', 'H2Z0B5', 'Montreal', '2021-01-01', 'Other')
,('HEAL24011912', 'Donald Trump', '1949-08-14', 'Male', '4387286760', '250 Rue University', 'H2Z0B5', 'Montreal', '2021-01-01', 'Healthcare Worker')
,('HEAL34011912', 'Boris Johnson', '1959-08-14', 'Male', '4387286760', '250 Rue University', 'H2Z0B5', 'Montreal', '2021-01-01', 'Healthcare Worker')
,('HEAL44011912', 'Justin Trudeau', '1979-08-14', 'Male', '5517586360', '250 Rue University', 'H2Z0B5', 'Montreal', '2021-01-01', 'Healthcare Worker')
,('ESSE14011912', 'Bernard Brown', '1939-08-14', 'Male', '4387286760', '250 Rue University', 'H2Z0B5', 'Montreal', '2021-01-01', 'Essential Service Worker')
;

INSERT INTO VaccinationLocation (locationName, streetAddress, postalCode, city) VALUES
('Jewish General Hospital', '100 Rue de Hospital', 'H3T1E2', 'Montreal')
,('St. Marys Hospital', '200 Rue de Hospital', 'HXA1E2', 'Montreal')
,('Notre Dame Hospital', '300 Rue de Hospital', 'H2A1E2', 'Montreal')
,('Royal Victoria Hospital', '400 Rue de Hospital', 'Q2A1E2', 'Quebec')
,('Jean Talon Hospital', '500 Rue de Hospital', 'TTA1E2', 'Trois de Rivieres')
,('Pharmaprix Parc', '500 Avenue du Parc', 'HXA1E2', 'Montreal')
,('Jean Coutu Sherbrooke', '500 Avenue Sherbrooke', 'HXA1A2', 'Montreal')
,('Pharmaprix Collineuse', '400 Rue de Quebec', 'Q2A2E2', 'Quebec')
;

INSERT INTO Hospital (locationName) VALUES
 ('Jewish General Hospital')
,('St. Marys Hospital')
,('Notre Dame Hospital')
,('Royal Victoria Hospital')
,('Jean Talon Hospital')
;

INSERT INTO Nurse (licenseNo, nurseName, locationName) VALUES
('JMTL1412BB2A', 'Will Smith', 'Jewish General Hospital')
,('JMTL2412BB2A', 'Blake Lively', 'Jewish General Hospital')
,('STMTL412BB2A', 'Tom Cruise', 'St. Marys Hospital')
,('NDMTLND2BB2A', 'Angelina Jolie', 'Notre Dame Hospital')
,('RVCMTLN2BB2A', 'Timothee Chalamet', 'Royal Victoria Hospital')
,('JTTR1412BB2A', 'Simon Pegg', 'Jean Talon Hospital')
;

--limited by the actual possible data values, approved by TA
INSERT INTO Vaccine (vaccineName, totalDosesNeeded, timeBetweenDoses) VALUES
('Pfizer-BioNTech', 2, '2 weeks')
,('Moderna', 2, '2 weeks')
;

INSERT INTO Batch (vaccineName, batchNo, expiryDate, manufactureDate, count, locationName) VALUES
('Pfizer-BioNTech', 'A1M2B4D55X10A', '2021-03-15', '2020-12-19', 5, 'Jewish General Hospital')
,('Pfizer-BioNTech', 'B1M2B4D55X10A', '2021-02-15', '2020-11-19', 5, 'St. Marys Hospital')
,('Pfizer-BioNTech', 'C1M2B4D55X10A', '2025-03-15', '2020-12-01', 5, 'Jewish General Hospital')
,('Moderna', 'D1M2B4D55X10A', '2023-03-15', '2020-12-01', 5, 'Royal Victoria Hospital')
,('Moderna', 'E1M2B4D55X10A', '2025-03-15', '2020-12-01', 5, 'Jean Talon Hospital')
;

INSERT INTO Vial (vaccineName,batchNo,vialNo) VALUES
 ('Pfizer-BioNTech', 'A1M2B4D55X10A', 1)
,('Pfizer-BioNTech', 'A1M2B4D55X10A', 2)
,('Pfizer-BioNTech', 'A1M2B4D55X10A', 3)
,('Pfizer-BioNTech', 'A1M2B4D55X10A', 4)
,('Pfizer-BioNTech', 'A1M2B4D55X10A', 5)
,('Pfizer-BioNTech', 'B1M2B4D55X10A', 1)
,('Pfizer-BioNTech', 'B1M2B4D55X10A', 2)
,('Pfizer-BioNTech', 'B1M2B4D55X10A', 3)
,('Pfizer-BioNTech', 'B1M2B4D55X10A', 4)
,('Pfizer-BioNTech', 'B1M2B4D55X10A', 5)
,('Pfizer-BioNTech', 'C1M2B4D55X10A', 1)
,('Pfizer-BioNTech', 'C1M2B4D55X10A', 2)
,('Pfizer-BioNTech', 'C1M2B4D55X10A', 3)
,('Pfizer-BioNTech', 'C1M2B4D55X10A', 4)
,('Pfizer-BioNTech', 'C1M2B4D55X10A', 5)
,('Moderna', 'D1M2B4D55X10A', 1)
,('Moderna', 'D1M2B4D55X10A', 2)
,('Moderna', 'D1M2B4D55X10A', 3)
,('Moderna', 'D1M2B4D55X10A', 4)
,('Moderna', 'D1M2B4D55X10A', 5)
,('Moderna', 'E1M2B4D55X10A', 1)
,('Moderna', 'E1M2B4D55X10A', 2)
,('Moderna', 'E1M2B4D55X10A', 3)
,('Moderna', 'E1M2B4D55X10A', 4)
,('Moderna', 'E1M2B4D55X10A', 5)
;

------------------------------------------------------------------------

INSERT INTO AdministratedDate(slotDate,locationName) VALUES
 ('2021-03-20','Jewish General Hospital')
,('2021-01-15','Jewish General Hospital')
,('2021-01-21','Royal Victoria Hospital')
,('2021-02-06', 'St. Marys Hospital')
,('2021-03-20', 'Notre Dame Hospital')
,('2021-02-06', 'Royal Victoria Hospital')
,('2021-01-06', 'Jean Talon Hospital')
,('2021-01-21', 'Jean Talon Hospital')
,('2021-02-06', 'Jean Talon Hospital')
;

INSERT INTO Deputed(licenseNo,locationName,slotDate) VALUES
 ('JMTL1412BB2A', 'Jewish General Hospital', '2021-03-20')
,('JMTL1412BB2A', 'Jewish General Hospital', '2021-01-15')
,('JMTL2412BB2A', 'Royal Victoria Hospital', '2021-01-21')
,('NDMTLND2BB2A', 'St. Marys Hospital', '2021-02-06')
,('STMTL412BB2A', 'Notre Dame Hospital', '2021-03-20')
,('RVCMTLN2BB2A', 'Royal Victoria Hospital', '2021-02-06')
,('JTTR1412BB2A', 'Jean Talon Hospital', '2021-01-06')
,('JTTR1412BB2A', 'Jean Talon Hospital', '2021-02-06')
,('JTTR1412BB2A', 'Jean Talon Hospital', '2021-01-21')
;

INSERT INTO Slot (slotID,slotDate,slotTime,allocationDate,allocationTime,locationName,licenseNo,vaccineName,batchNo,vialNo,healthInsuranceNo) VALUES
 ('2021-03-20-1000-JCS5', '2021-03-20', '10.00.00', '2021-02-01', '13.00.00', 'Jewish General Hospital', 'JMTL1412BB2A', 'Moderna', 'D1M2B4D55X10A', 1, 'OTHE14011912')
,('2021-03-20-1100-XHZ5', '2021-03-20', '11.00.00', NULL, NULL, 'Jewish General Hospital', NULL, NULL, NULL, NULL, NULL)
,('2021-03-20-1200-JBE5', '2021-03-20', '12.00.00', '2021-02-01', '13.00.00', 'Jewish General Hospital', 'JMTL1412BB2A', 'Moderna', 'D1M2B4D55X10A', 2, 'OTHE34011912')
,('2021-03-20-1300-SDC5', '2021-03-20', '13.00.00', NULL, NULL, 'Jewish General Hospital', NULL, NULL, NULL, NULL, NULL)
,('2021-03-20-1400-GHF5', '2021-03-20', '14.00.00', NULL, NULL, 'Jewish General Hospital', NULL, NULL, NULL, NULL, NULL)
------------------------------------------------------------------------------------------------------------------------------
,('2021-02-06-1000-JTD2', '2021-02-06', '10.00.00', '2021-01-01', '13.00.00', 'Jean Talon Hospital', 'JTTR1412BB2A', 'Pfizer-BioNTech', 'B1M2B4D55X10A', 1, 'HEAL14011912')
------------------------------------------------------------------------------------------------------------------------------
,('2021-03-20-1000-SMD5', '2021-02-06', '10.00.00', '2021-02-01', '13.00.00', 'St. Marys Hospital', 'NDMTLND2BB2A', 'Pfizer-BioNTech', 'B1M2B4D55X10A', 2, 'IMMU94011912')
,('2021-01-06-1100-SMD1', '2021-02-06', '11.00.00', '2021-01-01', '13.00.00', 'St. Marys Hospital', 'NDMTLND2BB2A', 'Pfizer-BioNTech', 'B1M2B4D55X10A', 3, 'CHIL94011912')
,('2021-01-06-1100-JTD1', '2021-02-06', '11.00.00', '2021-01-01', '13.00.00', 'Jean Talon Hospital', 'JTTR1412BB2A', 'Pfizer-BioNTech', 'C1M2B4D55X10A', 3, 'OTHE24011912')
-------------------------------------------------------------------------------------------------------------------------------
,('2021-01-15-1000-JTB1', '2021-01-15', '10.00.00', '2021-01-01', '10.00.00', 'Jewish General Hospital', 'JMTL1412BB2A', 'Pfizer-BioNTech', 'A1M2B4D55X10A', 1, 'HEAL24011912')
,('2021-01-15-1100-JTB2', '2021-01-15', '11.00.00', '2021-01-01', '10.00.00', 'Jewish General Hospital', 'JMTL1412BB2A', 'Pfizer-BioNTech', 'A1M2B4D55X10A', 2, 'HEAL34011912')
,('2021-01-15-1200-JTB2', '2021-01-15', '12.00.00', '2021-01-01', '10.00.00', 'Jewish General Hospital', 'JMTL1412BB2A', 'Pfizer-BioNTech', 'A1M2B4D55X10A', 3, 'HEAL44011912')
,('2021-01-21-1000-JTD2', '2021-01-21', '10.00.00', '2021-01-06', '13.00.00', 'Jean Talon Hospital', 'JTTR1412BB2A', 'Pfizer-BioNTech', 'C1M2B4D55X10A', 4, 'HEAL24011912')
-------------------------------------------------------------------------------------------------------------------------------
;