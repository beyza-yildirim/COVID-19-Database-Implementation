import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Scanner;

class VaccineApp {

    public static void display_main_menu() {
        System.out.println("VaccineApp Main Menu");
        System.out.println("\t1. Add a Person");
        System.out.println("\t2. Assign a slot to a Person");
        System.out.println("\t3. Enter Vaccination information");
        System.out.println("\t4. Exit Application");
        System.out.print("Please Enter Your Option: ");
    }

    public static void display_gender_menu() {
        System.out.print("Enter gender: ");
        System.out.print("\n\t1. Female \n\t2. Male \n\t3. Other\n");
        System.out.print("Enter your gender option: ");
    }

    public static void display_category_menu(){
        System.out.print("Category name options: \n\t1. Healthcare Worker \n\t2. Elderly \n\t3. Immunologically Compromised \n\t4. Teacher \n\t5. Children below 10 \n" +
                "\t6. Physical proximity to first priority \n\t7. Essential Service Worker \n" +
                "\t8. Physical proximity to second priority \n\t9. Other \n");
        System.out.print("Enter your category name option: ");
    }

    public static void main ( String [ ] args ) throws SQLException {

        try { DriverManager.registerDriver (new com.ibm.db2.jcc.DB2Driver()) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        String url = "jdbc:db2://winter2021-comp421.cs.mcgill.ca:50000/cs421";

        String userid = "byildi";
        String password = "null";

        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        if(userid == null && (userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }

        if(password == null && (password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }

        Connection con = DriverManager.getConnection (url, userid, password);
        Statement statement = con.createStatement();

        /* String dropPersonTable = "DROP TABLE Person";
        statement.executeUpdate(dropPersonTable);

        String createPersonTable = "CREATE TABLE Person\n" +
                "(\n" +
                "    healthInsuranceNo VARCHAR(12) NOT NULL\n" +
                "    ,personName VARCHAR(50) NOT NULL\n" +
                "    ,doBirth DATE NOT NULL CHECK (doBirth>='1900-01-01')\n" +
                "    ,gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other'))\n" +
                "    ,phoneNo VARCHAR(10) NOT NULL\n" +
                "    ,streetAddress VARCHAR(100) NOT NULL\n" +
                "    ,postalCode VARCHAR(6) NOT NULL\n" +
                "    ,city VARCHAR(30) NOT NULL\n" +
                "    ,registrationDate DATE NOT NULL\n" +
                "    ,categoryName VARCHAR(50) NOT NULL\n" +
                "    ,PRIMARY KEY (healthInsuranceNo)\n" +
                "    ,FOREIGN KEY(categoryName) REFERENCES Category(categoryName)\n" +
                ")";

        System.out.println(createPersonTable);
        statement.executeUpdate(createPersonTable) ;
        System.out.println("Person table created successfully");

       String dropSlotTable = "DROP TABLE Slot";
        statement.executeUpdate(dropSlotTable);

        String createSlotTable = "CREATE TABLE Slot\n" +
                "(\n" +
                "    slotID VARCHAR(50) NOT NULL\n" +
                "    ,slotDate DATE NOT NULL\n" +
                "    ,slotTime TIME NOT NULL\n" +
                "    ,allocationDate DATE\n" +
                "    ,allocationTime TIME\n" +
                "    ,locationName VARCHAR(50) NOT NULL\n" +
                "    ,licenseNo VARCHAR(15)\n" +
                "    ,vaccineName VARCHAR(50)\n" +
                "    ,batchNo VARCHAR(20)\n" +
                "    ,vialNo INT\n" +
                "    ,healthInsuranceNo VARCHAR(12)\n" +
                "    ,PRIMARY KEY (slotID)\n" +
                "    ,FOREIGN KEY (slotDate, locationName) REFERENCES AdministratedDate(slotDate, locationName)\n" +
                "    ,FOREIGN KEY (licenseNo) REFERENCES Nurse(licenseNo)\n" +
                "    ,FOREIGN KEY (vaccineName, batchNo,vialNo) REFERENCES Vial(vaccineName, batchNo,vialNo)\n" +
                "    ,FOREIGN KEY (healthInsuranceNo) REFERENCES Person(healthInsuranceNo)\n" +
                "    ,CHECK (allocationDate<=slotDate)\n" +
                ")";

        statement.executeUpdate (createSlotTable) ;
        System.out.println ("Slot table created successfully");*/

        Scanner sc= new Scanner(System.in);

        int option=0;

        while(option!=4) {
            display_main_menu();
            option = sc.nextInt();

            if(option == 1) {
                System.out.println("Adding person details");
                sc.nextLine();

                System.out.print("Enter 12-digit health insurance number: ");
                String healthInsuranceNo = sc.nextLine();

                PreparedStatement person_exists = con.prepareStatement("SELECT healthInsuranceNo FROM Person WHERE healthInsuranceNo = ?");
                person_exists.setString (1, healthInsuranceNo);
                ResultSet rs = person_exists.executeQuery();

                Boolean exitPerson = false;
                Boolean updatePerson = false;

                if (rs.next()) {
                    System.out.println("A person with the associated health insurance number already exists in the database.");
                    System.out.println("Do you want to update the entries associated with this person? Enter Y for yes, N for no: ");

                    switch (sc.nextLine()) {
                        case "Y":
                            System.out.println("Please update the information: ");
                            updatePerson = true;
                            break;

                        case "N":
                            exitPerson = true;
                            break;

                        default:
                            System.err.println("Unrecognized option");
                            break;
                    }
                }
                if (!exitPerson) {

                    System.out.print("Enter name: ");
                    String personName = sc.nextLine();

                    System.out.print("Enter date of birth as YYYY-MM-DD: ");
                    String doBirth = sc.nextLine();

                    String gender = "null";
                    display_gender_menu();

                    switch (sc.nextInt()) {
                        case 1:
                            gender = "Female";
                            break;
                        case 2:
                            gender = "Male";
                            break;
                        case 3:
                            gender = "Other";
                            break;
                        default:
                            System.err.println("Chosen option not valid, please choose between 1-3");
                            break;
                    }
                    sc.nextLine();

                    System.out.print("Enter phone number: ");
                    String phoneNo = sc.nextLine();

                    System.out.print("Enter street address: ");
                    String streetAddress = sc.nextLine();

                    System.out.print("Enter postal code: ");
                    String postalCode = sc.nextLine();

                    System.out.print("Enter city: ");
                    String city = sc.nextLine();

                    String categoryName = "null";
                    display_category_menu();

                    switch (sc.nextInt()) {
                        case 1:
                            categoryName = "Healthcare Worker";
                            break;
                        case 2:
                            categoryName = "Elderly";
                            break;
                        case 3:
                            categoryName = "Immunologically Compromised";
                            break;
                        case 4:
                            categoryName = "Teacher";
                            break;
                        case 5:
                            categoryName = "Children below 10";
                            break;
                        case 6:
                            categoryName = "Physical proximity to first priority";
                            break;
                        case 7:
                            categoryName = "Essential Service Worker";
                            break;
                        case 8:
                            categoryName = "Physical proximity to second priority";
                            break;
                        case 9:
                            categoryName = "Other";
                            break;
                        default:
                            System.err.println("Chosen option not valid, please choose between 1-9");
                            break;
                    }
                    sc.nextLine();

                    LocalDate registrationDate = LocalDate.now();

                    try {
                        String sqlquery = ("INSERT INTO Person VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");

                        if (updatePerson) {
                            sqlquery = ("UPDATE Person SET healthInsuranceNo = ?, personName = ?, doBirth = ?, gender = ?, phoneNo = ?, streetAddress = ?, postalCode = ?, city = ?, registrationDate = ?, categoryName = ? WHERE healthInsuranceNo = ?");
                        }

                        PreparedStatement insertSQL = con.prepareStatement(sqlquery);
                        insertSQL.setString(1, healthInsuranceNo);
                        insertSQL.setString(2, personName);
                        insertSQL.setString(3, doBirth);
                        insertSQL.setString(4, gender);
                        insertSQL.setString(5, phoneNo);
                        insertSQL.setString(6, streetAddress);
                        insertSQL.setString(7, postalCode);
                        insertSQL.setString(8, city);
                        insertSQL.setString(9, registrationDate.toString());
                        insertSQL.setString(10, categoryName);
                        if (updatePerson) {
                            insertSQL.setString(11, healthInsuranceNo);
                        }
                        insertSQL.executeUpdate();
                        //System.out.println(insertSQL.toString());

                        if (updatePerson) {
                            System.out.println("Person record updated successfully!");
                        }
                        else {
                            System.out.println("Person record added successfully!");
                        }

                    }
                    catch (SQLException e) {
                        sqlCode = e.getErrorCode(); // Get SQLCODE
                        sqlState = e.getSQLState(); // Get SQLSTATE

                        System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                        System.out.println(e);
                    }
                }
            }

            else if(option == 2) {
                System.out.println("Assigning slot to a person");
                sc.nextLine();

                System.out.print("Enter 12-digit health insurance number: ");
                String healthInsuranceNo = sc.nextLine();

                try {
                    PreparedStatement person_vaccinated = con.prepareStatement("SELECT COUNT(healthInsuranceNo) FROM Slot WHERE healthInsuranceNo = ? AND vialNo IS NOT NULL");
                    person_vaccinated.setString(1, healthInsuranceNo);
                    ResultSet rs1 = person_vaccinated.executeQuery();

                    PreparedStatement required_doses = con.prepareStatement("SELECT V.totalDosesNeeded FROM Vaccine V, Slot S\n" +
                            "WHERE S.healthInsuranceNo = ? AND S.vialNo IS NOT NULL AND V.vaccineName=S.vaccineName");
                    required_doses.setString(1, healthInsuranceNo);
                    ResultSet rs2 = required_doses.executeQuery();

                    int no_doses = 0;
                    int no_req_doses = 0;

                    if (rs1.next()) {
                        no_doses = rs1.getInt(1);
                    }

                    if (rs2.next()) {
                        no_req_doses = rs2.getInt(1);
                    }

                    System.out.println("\tDoses received: " + no_doses);
                    if (no_doses != 0) {
                        System.out.println("\tDoses needed: " + no_req_doses);
                    }

                    Boolean done_vacc = false;

                    if (no_doses >= no_req_doses && no_doses != 0) {
                        System.out.println("The person has already received the required amount of doses!");
                        done_vacc = true;
                    }

                    if (done_vacc == false) {
                        LocalDate registrationDate = LocalDate.now();

                        PreparedStatement available_slots = con.prepareStatement("SELECT slotID, slotDate, slotTime, locationName\n" +
                                "FROM Slot\n" +
                                "WHERE slotDate > ? AND healthInsuranceNo IS NULL");
                        available_slots.setString(1, registrationDate.toString());
                        ResultSet rs_available_slots = available_slots.executeQuery();

                        ResultSetMetaData rsmd = rs_available_slots.getMetaData();
                        int columnsNumber = rsmd.getColumnCount();

                        ArrayList<String> available_slotlist = new ArrayList<String>();

                        System.out.println("List of available slots: ");
                        while (rs_available_slots.next()) {
                            for (int i = 1; i <= columnsNumber; i++) {
                                if (i > 1) System.out.print(",  ");
                                String columnValue = rs_available_slots.getString(i);
                                available_slotlist.add(columnValue);
                                System.out.print(rsmd.getColumnName(i) + ": " + columnValue);
                            }
                            System.out.println("");
                        }
                        System.out.println("Enter the slot ID for preferred slot assigning: ");
                        String slotID = sc.nextLine();

                        Boolean assigned_slot = false;

                    /*for (int i = 0; i < available_slotlist.size();i++)
                    {
                        System.out.println(available_slotlist.get(i));
                    }*/

                        if (!available_slotlist.contains(slotID)) {
                            System.out.println("The slot ID entered has already been assigned!");
                            assigned_slot = true;
                        }

                        if (assigned_slot == false) {
                            PreparedStatement slot_assign = con.prepareStatement("UPDATE Slot\n" +
                                    "SET allocationDate = ?, allocationTime = ?, healthInsuranceNo = ?\n" +
                                    "WHERE slotID = ?");
                            slot_assign.setString(1, LocalDate.now().toString());
                            slot_assign.setString(2, LocalTime.now().truncatedTo(ChronoUnit.SECONDS).toString().replace(":", "."));
                            slot_assign.setString(3, healthInsuranceNo);
                            slot_assign.setString(4, slotID);
                            slot_assign.executeUpdate();

                            //System.out.println(slot_assign.toString());
                            System.out.println("Slot assigned successfully!");
                        }
                    }
                }
                catch (SQLException e) {
                    sqlCode = e.getErrorCode(); // Get SQLCODE
                    sqlState = e.getSQLState(); // Get SQLSTATE

                    System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                    System.out.println(e);
                }
            }

            else if(option == 3) {
                System.out.println("Entering vaccination information");
                sc.nextLine();

                System.out.print("Enter 12-digit health insurance number: ");
                String healthInsuranceNo = sc.nextLine();

                System.out.print("Enter vaccine name: ");
                String vaccineName = sc.nextLine();

                Boolean vacc_match = true;

                try{
                    PreparedStatement person_vaccinated = con.prepareStatement("SELECT vaccineName FROM Slot WHERE healthInsuranceNo = ? AND vialNo IS NOT NULL");
                    person_vaccinated.setString(1, healthInsuranceNo);
                    ResultSet rs_person_vaccinated = person_vaccinated.executeQuery();

                    while(rs_person_vaccinated.next()){
                        String prev_vacc = rs_person_vaccinated.getString (1);
                        if(!prev_vacc.equals(vaccineName)){
                            System.out.println("The vaccine brand entered does not match that of the previous dosage! Entry Stopped.");
                            vacc_match=false;
                            break;
                        }
                    }
                }
                catch (SQLException e) {
                    sqlCode = e.getErrorCode(); // Get SQLCODE
                    sqlState = e.getSQLState(); // Get SQLSTATE

                    System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                    System.out.println(e);
                }

                if(vacc_match) {

                    System.out.print("Enter batch number: ");
                    String batchNo = sc.nextLine();

                    System.out.print("Enter vial number: ");
                    String vialNo = sc.nextLine();

                    System.out.print("Enter nurse license number: ");
                    String licenseNo = sc.nextLine();

                    try {
                        PreparedStatement enter_vaccination = con.prepareStatement("UPDATE Slot\n" +
                                "SET licenseNo = ?, vaccineName = ?, batchNo = ?, vialNo = ? \n" +
                                "WHERE healthInsuranceNo = ? AND vialNo IS NULL");
                        enter_vaccination.setString(1, licenseNo);
                        enter_vaccination.setString(2, vaccineName);
                        enter_vaccination.setString(3, batchNo);
                        enter_vaccination.setString(4, vialNo);
                        enter_vaccination.setString(5, healthInsuranceNo);
                        enter_vaccination.executeUpdate();

                        System.out.println(enter_vaccination.toString());
                        System.out.println("Vaccination information for person with id " + healthInsuranceNo + " entered successfully!");

                    } catch (SQLException e) {
                        sqlCode = e.getErrorCode(); // Get SQLCODE
                        sqlState = e.getSQLState(); // Get SQLSTATE

                        System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                        System.out.println(e);
                    }
                }
            }

            else if(option==4) {
                System.out.println("Exiting the program");
                statement.close() ;
                con.close() ;
                System.exit(0);
            }
        }

        statement.close() ;
        con.close() ;
    }
}
