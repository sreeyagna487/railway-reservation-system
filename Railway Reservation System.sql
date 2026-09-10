Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 19
Server version: 8.0.46 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE rail_db;
Query OK, 1 row affected (0.01 sec)

mysql> USE rail_db;
Database changed
mysql> CREATE TABLE PASSENGERS (
    ->     Passenger_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Phone_no VARCHAR(15) NOT NULL UNIQUE,
    ->     Address VARCHAR(255) NOT NULL,
    ->     Date_of_birth DATE NOT NULL,
    ->     Gender VARCHAR(10) NOT NULL,
    ->     ID_proof VARCHAR(50) NOT NULL UNIQUE
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> DESC PASSENGERS;
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| Passenger_ID  | int          | NO   | PRI | NULL    | auto_increment |
| Phone_no      | varchar(15)  | NO   | UNI | NULL    |                |
| Address       | varchar(255) | NO   |     | NULL    |                |
| Date_of_birth | date         | NO   |     | NULL    |                |
| Gender        | varchar(10)  | NO   |     | NULL    |                |
| ID_proof      | varchar(50)  | NO   | UNI | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)

mysql> INSERT INTO PASSENGERS
    -> (Passenger_ID, Phone_no, Address, Date_of_birth, Gender, ID_proof)
    -> VALUES
    -> (1, '9876543210', 'Hyderabad', '2002-05-14', 'Female', 'IDP001'),
    -> (2, '9876543211', 'Vijayawada', '2001-08-22', 'Male', 'IDP002'),
    -> (3, '9876543212', 'Chennai', '2003-01-10', 'Female', 'IDP003'),
    -> (4, '9876543213', 'Bengaluru', '2000-11-05', 'Male', 'IDP004'),
    -> (5, '9876543214', 'Visakhapatnam', '2002-07-18', 'Female', 'IDP005');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM PASSENGERS;
+--------------+------------+---------------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address       | Date_of_birth | Gender | ID_proof |
+--------------+------------+---------------+---------------+--------+----------+
|            1 | 9876543210 | Hyderabad     | 2002-05-14    | Female | IDP001   |
|            2 | 9876543211 | Vijayawada    | 2001-08-22    | Male   | IDP002   |
|            3 | 9876543212 | Chennai       | 2003-01-10    | Female | IDP003   |
|            4 | 9876543213 | Bengaluru     | 2000-11-05    | Male   | IDP004   |
|            5 | 9876543214 | Visakhapatnam | 2002-07-18    | Female | IDP005   |
+--------------+------------+---------------+---------------+--------+----------+
5 rows in set (0.00 sec)

mysql> CREATE TABLE STATIONS (
    ->     Station_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Station_Name VARCHAR(100) NOT NULL UNIQUE,
    ->     City VARCHAR(100) NOT NULL,
    ->     State VARCHAR(100) NOT NULL,
    ->     Route_ID INT
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> DESC STATIONS;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| Station_ID   | int          | NO   | PRI | NULL    | auto_increment |
| Station_Name | varchar(100) | NO   | UNI | NULL    |                |
| City         | varchar(100) | NO   |     | NULL    |                |
| State        | varchar(100) | NO   |     | NULL    |                |
| Route_ID     | int          | YES  |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO STATIONS
    -> (Station_ID, Station_Name, City, State, Route_ID)
    -> VALUES
    -> (1, 'Secunderabad Junction', 'Hyderabad', 'Telangana', 1),
    -> (2, 'Vijayawada Junction', 'Vijayawada', 'Andhra Pradesh', 2),
    -> (3, 'Chennai Central', 'Chennai', 'Tamil Nadu', 3),
    -> (4, 'Bengaluru City Junction', 'Bengaluru', 'Karnataka', 4),
    -> (5, 'Visakhapatnam Junction', 'Visakhapatnam', 'Andhra Pradesh', 5);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM STATIONS;
+------------+-------------------------+---------------+----------------+----------+
| Station_ID | Station_Name            | City          | State          | Route_ID |
+------------+-------------------------+---------------+----------------+----------+
|          1 | Secunderabad Junction   | Hyderabad     | Telangana      |        1 |
|          2 | Vijayawada Junction     | Vijayawada    | Andhra Pradesh |        2 |
|          3 | Chennai Central         | Chennai       | Tamil Nadu     |        3 |
|          4 | Bengaluru City Junction | Bengaluru     | Karnataka      |        4 |
|          5 | Visakhapatnam Junction  | Visakhapatnam | Andhra Pradesh |        5 |
+------------+-------------------------+---------------+----------------+----------+
5 rows in set (0.01 sec)

mysql> CREATE TABLE TRAINS (
    ->     Train_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Train_Name VARCHAR(100) NOT NULL UNIQUE,
    ->     Train_type VARCHAR(50) NOT NULL,
    ->     Source_station_ID INT NOT NULL,
    ->     Destination_station_ID INT NOT NULL,
    ->
    ->     CONSTRAINT fk_train_source
    ->         FOREIGN KEY (Source_station_ID)
    ->         REFERENCES STATIONS(Station_ID),
    ->
    ->     CONSTRAINT fk_train_destination
    ->         FOREIGN KEY (Destination_station_ID)
    ->         REFERENCES STATIONS(Station_ID),
    ->
    ->     CHECK (Source_station_ID <> Destination_station_ID)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> DESC TRINS;
ERROR 1146 (42S02): Table 'rail_db.trins' doesn't exist
mysql> DESC TRAINS;
+------------------------+--------------+------+-----+---------+----------------+
| Field                  | Type         | Null | Key | Default | Extra          |
+------------------------+--------------+------+-----+---------+----------------+
| Train_ID               | int          | NO   | PRI | NULL    | auto_increment |
| Train_Name             | varchar(100) | NO   | UNI | NULL    |                |
| Train_type             | varchar(50)  | NO   |     | NULL    |                |
| Source_station_ID      | int          | NO   | MUL | NULL    |                |
| Destination_station_ID | int          | NO   | MUL | NULL    |                |
+------------------------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO TRAINS
    -> (Train_ID, Train_Name, Train_type, Source_station_ID, Destination_station_ID)
    -> VALUES
    -> (1, 'Godavari Express', 'Express', 1, 2),
    -> (2, 'Krishna Express', 'Express', 2, 3),
    -> (3, 'Charminar Express', 'Superfast', 3, 4),
    -> (4, 'Vande Bharat', 'Semi High Speed', 4, 5),
    -> (5, 'East Coast Express', 'Express', 5, 1);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM TRAINS;
+----------+--------------------+-----------------+-------------------+------------------------+
| Train_ID | Train_Name         | Train_type      | Source_station_ID | Destination_station_ID |
+----------+--------------------+-----------------+-------------------+------------------------+
|        1 | Godavari Express   | Express         |                 1 |                      2 |
|        2 | Krishna Express    | Express         |                 2 |                      3 |
|        3 | Charminar Express  | Superfast       |                 3 |                      4 |
|        4 | Vande Bharat       | Semi High Speed |                 4 |                      5 |
|        5 | East Coast Express | Express         |                 5 |                      1 |
+----------+--------------------+-----------------+-------------------+------------------------+
5 rows in set (0.00 sec)

mysql> CREATE TABLE ROUTES (
    ->     Route_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Route_Name VARCHAR(100) NOT NULL UNIQUE,
    ->     Train_ID INT NOT NULL,
    ->     Travel_time TIME NOT NULL,
    ->     Distance DECIMAL(10,2) NOT NULL,
    ->
    ->     CONSTRAINT fk_route_train
    ->         FOREIGN KEY (Train_ID)
    ->         REFERENCES TRAINS(Train_ID),
    ->
    ->     CHECK (Distance > 0)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> DESC ROUTES;
+-------------+---------------+------+-----+---------+----------------+
| Field       | Type          | Null | Key | Default | Extra          |
+-------------+---------------+------+-----+---------+----------------+
| Route_ID    | int           | NO   | PRI | NULL    | auto_increment |
| Route_Name  | varchar(100)  | NO   | UNI | NULL    |                |
| Train_ID    | int           | NO   | MUL | NULL    |                |
| Travel_time | time          | NO   |     | NULL    |                |
| Distance    | decimal(10,2) | NO   |     | NULL    |                |
+-------------+---------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO ROUTES
    -> (Route_ID, Route_Name, Train_ID, Travel_time, Distance)
    -> VALUES
    -> (1, 'Hyderabad-Vijayawada', 1, '05:30:00', 275.00),
    -> (2, 'Vijayawada-Chennai', 2, '06:00:00', 430.00),
    -> (3, 'Chennai-Bengaluru', 3, '05:00:00', 350.00),
    -> (4, 'Bengaluru-Visakhapatnam', 4, '10:30:00', 760.00),
    -> (5, 'Visakhapatnam-Hyderabad', 5, '12:00:00', 620.00);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM ROUTES;
+----------+-------------------------+----------+-------------+----------+
| Route_ID | Route_Name              | Train_ID | Travel_time | Distance |
+----------+-------------------------+----------+-------------+----------+
|        1 | Hyderabad-Vijayawada    |        1 | 05:30:00    |   275.00 |
|        2 | Vijayawada-Chennai      |        2 | 06:00:00    |   430.00 |
|        3 | Chennai-Bengaluru       |        3 | 05:00:00    |   350.00 |
|        4 | Bengaluru-Visakhapatnam |        4 | 10:30:00    |   760.00 |
|        5 | Visakhapatnam-Hyderabad |        5 | 12:00:00    |   620.00 |
+----------+-------------------------+----------+-------------+----------+
5 rows in set (0.00 sec)

mysql> CREATE TABLE RESERVATIONS (
    ->     Reservation_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Passenger_ID INT NOT NULL,
    ->     Train_ID INT NOT NULL,
    ->     Departure_Time TIME NOT NULL,
    ->     Booking_Date DATE NOT NULL DEFAULT (CURRENT_DATE),
    ->     Journey_Date DATE NOT NULL,
    ->     Arrival_Time TIME NOT NULL,
    ->     Total_Amount DECIMAL(10,2) NOT NULL,
    ->     Reservation_status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    ->     Payment_status VARCHAR(20) NOT NULL DEFAULT 'Paid',
    ->
    ->     CONSTRAINT fk_reservation_passenger
    ->         FOREIGN KEY (Passenger_ID)
    ->         REFERENCES PASSENGERS(Passenger_ID),
    ->
    ->     CONSTRAINT fk_reservation_train
    ->         FOREIGN KEY (Train_ID)
    ->         REFERENCES TRAINS(Train_ID),
    ->
    ->     CHECK (Total_Amount > 0),
    ->     CHECK (Journey_Date >= Booking_Date),
    ->     CHECK (Reservation_status IN ('Confirmed', 'Cancelled', 'Pending')),
    ->     CHECK (Payment_status IN ('Paid', 'Unpaid', 'Refunded'))
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> DESC RESERVATIONS;
+--------------------+---------------+------+-----+-----------+-------------------+
| Field              | Type          | Null | Key | Default   | Extra             |
+--------------------+---------------+------+-----+-----------+-------------------+
| Reservation_ID     | int           | NO   | PRI | NULL      | auto_increment    |
| Passenger_ID       | int           | NO   | MUL | NULL      |                   |
| Train_ID           | int           | NO   | MUL | NULL      |                   |
| Departure_Time     | time          | NO   |     | NULL      |                   |
| Booking_Date       | date          | NO   |     | curdate() | DEFAULT_GENERATED |
| Journey_Date       | date          | NO   |     | NULL      |                   |
| Arrival_Time       | time          | NO   |     | NULL      |                   |
| Total_Amount       | decimal(10,2) | NO   |     | NULL      |                   |
| Reservation_status | varchar(20)   | NO   |     | Confirmed |                   |
| Payment_status     | varchar(20)   | NO   |     | Paid      |                   |
+--------------------+---------------+------+-----+-----------+-------------------+
10 rows in set (0.00 sec)

mysql> INSERT INTO RESERVATIONS
    -> (Reservation_ID, Passenger_ID, Train_ID, Departure_Time, Booking_Date, Journey_Date, Arrival_Time, Total_Amount, Reservation_status, Payment_status)
    -> VALUES
    -> (1, 1, 1, '06:00:00', '2026-09-01', '2026-09-10', '11:30:00', 850.00, 'Confirmed', 'Paid'),
    -> (2, 2, 2, '07:00:00', '2026-09-02', '2026-09-12', '13:00:00', 950.00, 'Confirmed', 'Paid'),
    -> (3, 3, 3, '08:30:00', '2026-09-03', '2026-09-15', '13:30:00', 1100.00, 'Pending', 'Unpaid'),
    -> (4, 4, 4, '09:00:00', '2026-09-03', '2026-09-18', '19:30:00', 1500.00, 'Confirmed', 'Paid'),
    -> (5, 5, 5, '10:00:00', '2026-09-04', '2026-09-20', '22:00:00', 1250.00, 'Cancelled', 'Refunded');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM RESERVATION;
ERROR 1146 (42S02): Table 'rail_db.reservation' doesn't exist
mysql> SELECT * FROM RESERVATIONS;
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
| Reservation_ID | Passenger_ID | Train_ID | Departure_Time | Booking_Date | Journey_Date | Arrival_Time | Total_Amount | Reservation_status | Payment_status |
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
|              1 |            1 |        1 | 06:00:00       | 2026-09-01   | 2026-09-10   | 11:30:00     |       850.00 | Confirmed          | Paid           |
|              2 |            2 |        2 | 07:00:00       | 2026-09-02   | 2026-09-12   | 13:00:00     |       950.00 | Confirmed          | Paid           |
|              3 |            3 |        3 | 08:30:00       | 2026-09-03   | 2026-09-15   | 13:30:00     |      1100.00 | Pending            | Unpaid         |
|              4 |            4 |        4 | 09:00:00       | 2026-09-03   | 2026-09-18   | 19:30:00     |      1500.00 | Confirmed          | Paid           |
|              5 |            5 |        5 | 10:00:00       | 2026-09-04   | 2026-09-20   | 22:00:00     |      1250.00 | Cancelled          | Refunded       |
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
5 rows in set (0.00 sec)

mysql> CREATE TABLE TICKETS (
    ->     Ticket_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Reservation_ID INT NOT NULL,
    ->     Train_ID INT NOT NULL,
    ->     Ticket_Date DATE NOT NULL,
    ->     Class VARCHAR(20) NOT NULL,
    ->     Status VARCHAR(20) NOT NULL DEFAULT 'Booked',
    ->     Seat_number VARCHAR(10) NOT NULL UNIQUE,
    ->
    ->     CONSTRAINT fk_ticket_reservation
    ->         FOREIGN KEY (Reservation_ID)
    ->         REFERENCES RESERVATIONS(Reservation_ID),
    ->
    ->     CONSTRAINT fk_ticket_train
    ->         FOREIGN KEY (Train_ID)
    ->         REFERENCES TRAINS(Train_ID),
    ->
    ->     CHECK (Class IN ('Sleeper', 'AC', 'First Class', 'Second Sitting')),
    ->     CHECK (Status IN ('Booked', 'Cancelled', 'Confirmed'))
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> DESC TICKETS;
+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| Ticket_ID      | int         | NO   | PRI | NULL    | auto_increment |
| Reservation_ID | int         | NO   | MUL | NULL    |                |
| Train_ID       | int         | NO   | MUL | NULL    |                |
| Ticket_Date    | date        | NO   |     | NULL    |                |
| Class          | varchar(20) | NO   |     | NULL    |                |
| Status         | varchar(20) | NO   |     | Booked  |                |
| Seat_number    | varchar(10) | NO   | UNI | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)

mysql> INSERT INTO TICKETS
    -> (Ticket_ID, Reservation_ID, Train_ID, Ticket_Date, Class, Status, Seat_number)
    -> VALUES
    -> (1, 1, 1, '2026-09-01', 'AC', 'Confirmed', 'A1-01'),
    -> (2, 2, 2, '2026-09-02', 'Sleeper', 'Booked', 'S1-12'),
    -> (3, 3, 3, '2026-09-03', 'First Class', 'Booked', 'F1-05'),
    -> (4, 4, 4, '2026-09-03', 'AC', 'Confirmed', 'A2-10'),
    -> (5, 5, 5, '2026-09-04', 'Second Sitting', 'Cancelled', 'D2-25');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM TICKETS;
+-----------+----------------+----------+-------------+----------------+-----------+-------------+
| Ticket_ID | Reservation_ID | Train_ID | Ticket_Date | Class          | Status    | Seat_number |
+-----------+----------------+----------+-------------+----------------+-----------+-------------+
|         1 |              1 |        1 | 2026-09-01  | AC             | Confirmed | A1-01       |
|         2 |              2 |        2 | 2026-09-02  | Sleeper        | Booked    | S1-12       |
|         3 |              3 |        3 | 2026-09-03  | First Class    | Booked    | F1-05       |
|         4 |              4 |        4 | 2026-09-03  | AC             | Confirmed | A2-10       |
|         5 |              5 |        5 | 2026-09-04  | Second Sitting | Cancelled | D2-25       |
+-----------+----------------+----------+-------------+----------------+-----------+-------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO PASSENGERS
    -> (Passenger_ID, Phone_no, Address, Date_of_birth, Gender, ID_proof)
    -> VALUES
    -> (6, '9876543215', 'Guntur', '2001-03-25', 'Male', 'IDP006');
Query OK, 1 row affected (0.01 sec)

mysql> DESC PASSENDERS;
ERROR 1146 (42S02): Table 'rail_db.passenders' doesn't exist
mysql> DESC PASSENGERS;
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| Passenger_ID  | int          | NO   | PRI | NULL    | auto_increment |
| Phone_no      | varchar(15)  | NO   | UNI | NULL    |                |
| Address       | varchar(255) | NO   |     | NULL    |                |
| Date_of_birth | date         | NO   |     | NULL    |                |
| Gender        | varchar(10)  | NO   |     | NULL    |                |
| ID_proof      | varchar(50)  | NO   | UNI | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM PASSENGERS;
+--------------+------------+---------------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address       | Date_of_birth | Gender | ID_proof |
+--------------+------------+---------------+---------------+--------+----------+
|            1 | 9876543210 | Hyderabad     | 2002-05-14    | Female | IDP001   |
|            2 | 9876543211 | Vijayawada    | 2001-08-22    | Male   | IDP002   |
|            3 | 9876543212 | Chennai       | 2003-01-10    | Female | IDP003   |
|            4 | 9876543213 | Bengaluru     | 2000-11-05    | Male   | IDP004   |
|            5 | 9876543214 | Visakhapatnam | 2002-07-18    | Female | IDP005   |
|            6 | 9876543215 | Guntur        | 2001-03-25    | Male   | IDP006   |
+--------------+------------+---------------+---------------+--------+----------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM PASSENGERS
    -> WHERE Passenger_ID = 1;
+--------------+------------+-----------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address   | Date_of_birth | Gender | ID_proof |
+--------------+------------+-----------+---------------+--------+----------+
|            1 | 9876543210 | Hyderabad | 2002-05-14    | Female | IDP001   |
+--------------+------------+-----------+---------------+--------+----------+
1 row in set (0.00 sec)

mysql> UPDATE PASSENGERS
    -> SET Address = 'Warangal'
    -> WHERE Passenger_ID = 1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM PASSENGERS;
+--------------+------------+---------------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address       | Date_of_birth | Gender | ID_proof |
+--------------+------------+---------------+---------------+--------+----------+
|            1 | 9876543210 | Warangal      | 2002-05-14    | Female | IDP001   |
|            2 | 9876543211 | Vijayawada    | 2001-08-22    | Male   | IDP002   |
|            3 | 9876543212 | Chennai       | 2003-01-10    | Female | IDP003   |
|            4 | 9876543213 | Bengaluru     | 2000-11-05    | Male   | IDP004   |
|            5 | 9876543214 | Visakhapatnam | 2002-07-18    | Female | IDP005   |
|            6 | 9876543215 | Guntur        | 2001-03-25    | Male   | IDP006   |
+--------------+------------+---------------+---------------+--------+----------+
6 rows in set (0.00 sec)

mysql> DELETE FROM PASSENGERS
    -> WHERE Passenger_ID = 6;
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM PASSENGERS;
+--------------+------------+---------------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address       | Date_of_birth | Gender | ID_proof |
+--------------+------------+---------------+---------------+--------+----------+
|            1 | 9876543210 | Warangal      | 2002-05-14    | Female | IDP001   |
|            2 | 9876543211 | Vijayawada    | 2001-08-22    | Male   | IDP002   |
|            3 | 9876543212 | Chennai       | 2003-01-10    | Female | IDP003   |
|            4 | 9876543213 | Bengaluru     | 2000-11-05    | Male   | IDP004   |
|            5 | 9876543214 | Visakhapatnam | 2002-07-18    | Female | IDP005   |
+--------------+------------+---------------+---------------+--------+----------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     P.Passenger_ID,
    ->     P.Phone_no,
    ->     P.Address,
    ->     R.Reservation_ID,
    ->     R.Train_ID,
    ->     R.Journey_Date,
    ->     R.Total_Amount,
    ->     R.Reservation_status
    -> FROM PASSENGERS P
    -> INNER JOIN RESERVATIONS R
    -> ON P.Passenger_ID = R.Passenger_ID;
+--------------+------------+---------------+----------------+----------+--------------+--------------+--------------------+
| Passenger_ID | Phone_no   | Address       | Reservation_ID | Train_ID | Journey_Date | Total_Amount | Reservation_status |
+--------------+------------+---------------+----------------+----------+--------------+--------------+--------------------+
|            1 | 9876543210 | Warangal      |              1 |        1 | 2026-09-10   |       850.00 | Confirmed          |
|            2 | 9876543211 | Vijayawada    |              2 |        2 | 2026-09-12   |       950.00 | Confirmed          |
|            3 | 9876543212 | Chennai       |              3 |        3 | 2026-09-15   |      1100.00 | Pending            |
|            4 | 9876543213 | Bengaluru     |              4 |        4 | 2026-09-18   |      1500.00 | Confirmed          |
|            5 | 9876543214 | Visakhapatnam |              5 |        5 | 2026-09-20   |      1250.00 | Cancelled          |
+--------------+------------+---------------+----------------+----------+--------------+--------------+--------------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     T.Train_ID,
    ->     T.Train_Name,
    ->     T.Train_type,
    ->     R.Reservation_ID,
    ->     R.Passenger_ID,
    ->     R.Journey_Date,
    ->     R.Total_Amount,
    ->     R.Reservation_status
    -> FROM TRAINS T
    -> INNER JOIN RESERVATIONS R
    -> ON T.Train_ID = R.Train_ID;
+----------+--------------------+-----------------+----------------+--------------+--------------+--------------+--------------------+
| Train_ID | Train_Name         | Train_type      | Reservation_ID | Passenger_ID | Journey_Date | Total_Amount | Reservation_status |
+----------+--------------------+-----------------+----------------+--------------+--------------+--------------+--------------------+
|        1 | Godavari Express   | Express         |              1 |            1 | 2026-09-10   |       850.00 | Confirmed          |
|        2 | Krishna Express    | Express         |              2 |            2 | 2026-09-12   |       950.00 | Confirmed          |
|        3 | Charminar Express  | Superfast       |              3 |            3 | 2026-09-15   |      1100.00 | Pending            |
|        4 | Vande Bharat       | Semi High Speed |              4 |            4 | 2026-09-18   |      1500.00 | Confirmed          |
|        5 | East Coast Express | Express         |              5 |            5 | 2026-09-20   |      1250.00 | Cancelled          |
+----------+--------------------+-----------------+----------------+--------------+--------------+--------------+--------------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     P.Passenger_ID,
    ->     P.Phone_no,
    ->     R.Reservation_ID,
    ->     T.Train_ID,
    ->     T.Train_Name,
    ->     R.Journey_Date,
    ->     R.Total_Amount,
    ->     R.Reservation_status
    -> FROM PASSENGERS P
    -> INNER JOIN RESERVATIONS R
    ->     ON P.Passenger_ID = R.Passenger_ID
    -> INNER JOIN TRAINS T
    ->     ON R.Train_ID = T.Train_ID;
+--------------+------------+----------------+----------+--------------------+--------------+--------------+--------------------+
| Passenger_ID | Phone_no   | Reservation_ID | Train_ID | Train_Name         | Journey_Date | Total_Amount | Reservation_status |
+--------------+------------+----------------+----------+--------------------+--------------+--------------+--------------------+
|            1 | 9876543210 |              1 |        1 | Godavari Express   | 2026-09-10   |       850.00 | Confirmed          |
|            2 | 9876543211 |              2 |        2 | Krishna Express    | 2026-09-12   |       950.00 | Confirmed          |
|            3 | 9876543212 |              3 |        3 | Charminar Express  | 2026-09-15   |      1100.00 | Pending            |
|            4 | 9876543213 |              4 |        4 | Vande Bharat       | 2026-09-18   |      1500.00 | Confirmed          |
|            5 | 9876543214 |              5 |        5 | East Coast Express | 2026-09-20   |      1250.00 | Cancelled          |
+--------------+------------+----------------+----------+--------------------+--------------+--------------+--------------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     P.Passenger_ID,
    ->     P.Phone_no,
    ->     T.Train_Name,
    ->     R.Journey_Date,
    ->     R.Total_Amount,
    ->     R.Reservation_status
    -> FROM PASSENGERS P
    -> INNER JOIN RESERVATIONS R
    ->     ON P.Passenger_ID = R.Passenger_ID
    -> INNER JOIN TRAINS T
    ->     ON R.Train_ID = T.Train_ID
    -> WHERE R.Reservation_status = 'Confirmed';
+--------------+------------+------------------+--------------+--------------+--------------------+
| Passenger_ID | Phone_no   | Train_Name       | Journey_Date | Total_Amount | Reservation_status |
+--------------+------------+------------------+--------------+--------------+--------------------+
|            1 | 9876543210 | Godavari Express | 2026-09-10   |       850.00 | Confirmed          |
|            2 | 9876543211 | Krishna Express  | 2026-09-12   |       950.00 | Confirmed          |
|            4 | 9876543213 | Vande Bharat     | 2026-09-18   |      1500.00 | Confirmed          |
+--------------+------------+------------------+--------------+--------------+--------------------+
3 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM PASSENGERS
    -> WHERE Passenger_ID IN (
    ->     SELECT Passenger_ID
    ->     FROM RESERVATIONS
    -> );
+--------------+------------+---------------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address       | Date_of_birth | Gender | ID_proof |
+--------------+------------+---------------+---------------+--------+----------+
|            1 | 9876543210 | Warangal      | 2002-05-14    | Female | IDP001   |
|            2 | 9876543211 | Vijayawada    | 2001-08-22    | Male   | IDP002   |
|            3 | 9876543212 | Chennai       | 2003-01-10    | Female | IDP003   |
|            4 | 9876543213 | Bengaluru     | 2000-11-05    | Male   | IDP004   |
|            5 | 9876543214 | Visakhapatnam | 2002-07-18    | Female | IDP005   |
+--------------+------------+---------------+---------------+--------+----------+
5 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM RESERVATIONS
    -> WHERE Total_Amount > (
    ->     SELECT AVG(Total_Amount)
    ->     FROM RESERVATIONS
    -> );
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
| Reservation_ID | Passenger_ID | Train_ID | Departure_Time | Booking_Date | Journey_Date | Arrival_Time | Total_Amount | Reservation_status | Payment_status |
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
|              4 |            4 |        4 | 09:00:00       | 2026-09-03   | 2026-09-18   | 19:30:00     |      1500.00 | Confirmed          | Paid           |
|              5 |            5 |        5 | 10:00:00       | 2026-09-04   | 2026-09-20   | 22:00:00     |      1250.00 | Cancelled          | Refunded       |
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
2 rows in set (0.01 sec)

mysql> SELECT *
    -> FROM RESERVATIONS
    -> WHERE Total_Amount = (
    ->     SELECT MAX(Total_Amount)
    ->     FROM RESERVATIONS
    -> );
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
| Reservation_ID | Passenger_ID | Train_ID | Departure_Time | Booking_Date | Journey_Date | Arrival_Time | Total_Amount | Reservation_status | Payment_status |
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
|              4 |            4 |        4 | 09:00:00       | 2026-09-03   | 2026-09-18   | 19:30:00     |      1500.00 | Confirmed          | Paid           |
+----------------+--------------+----------+----------------+--------------+--------------+--------------+--------------+--------------------+----------------+
1 row in set (0.00 sec)

mysql> SELECT *
    -> FROM PASSENGERS
    -> WHERE Passenger_ID IN (
    ->     SELECT Passenger_ID
    ->     FROM RESERVATIONS
    ->     WHERE Reservation_status = 'Confirmed'
    -> );
+--------------+------------+------------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address    | Date_of_birth | Gender | ID_proof |
+--------------+------------+------------+---------------+--------+----------+
|            1 | 9876543210 | Warangal   | 2002-05-14    | Female | IDP001   |
|            2 | 9876543211 | Vijayawada | 2001-08-22    | Male   | IDP002   |
|            4 | 9876543213 | Bengaluru  | 2000-11-05    | Male   | IDP004   |
+--------------+------------+------------+---------------+--------+----------+
3 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM ROUTES
    -> WHERE Distance = (
    ->     SELECT MAX(Distance)
    ->     FROM ROUTES
    -> );
+----------+-------------------------+----------+-------------+----------+
| Route_ID | Route_Name              | Train_ID | Travel_time | Distance |
+----------+-------------------------+----------+-------------+----------+
|        4 | Bengaluru-Visakhapatnam |        4 | 10:30:00    |   760.00 |
+----------+-------------------------+----------+-------------+----------+
1 row in set (0.00 sec)

mysql> CREATE VIEW Passenger_Reservation_View AS
    -> SELECT
    ->     P.Passenger_ID,
    ->     P.Phone_no,
    ->     R.Reservation_ID,
    ->     R.Train_ID,
    ->     R.Journey_Date,
    ->     R.Total_Amount,
    ->     R.Reservation_status
    -> FROM PASSENGERS P
    -> INNER JOIN RESERVATIONS R
    ->     ON P.Passenger_ID = R.Passenger_ID;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM Passenger_Reservation_View;
+--------------+------------+----------------+----------+--------------+--------------+--------------------+
| Passenger_ID | Phone_no   | Reservation_ID | Train_ID | Journey_Date | Total_Amount | Reservation_status |
+--------------+------------+----------------+----------+--------------+--------------+--------------------+
|            1 | 9876543210 |              1 |        1 | 2026-09-10   |       850.00 | Confirmed          |
|            2 | 9876543211 |              2 |        2 | 2026-09-12   |       950.00 | Confirmed          |
|            3 | 9876543212 |              3 |        3 | 2026-09-15   |      1100.00 | Pending            |
|            4 | 9876543213 |              4 |        4 | 2026-09-18   |      1500.00 | Confirmed          |
|            5 | 9876543214 |              5 |        5 | 2026-09-20   |      1250.00 | Cancelled          |
+--------------+------------+----------------+----------+--------------+--------------+--------------------+
5 rows in set (0.00 sec)

mysql> CREATE VIEW Train_Reservation_View AS
    -> SELECT
    ->     T.Train_ID,
    ->     T.Train_Name,
    ->     T.Train_type,
    ->     R.Reservation_ID,
    ->     R.Passenger_ID,
    ->     R.Journey_Date,
    ->     R.Total_Amount,
    ->     R.Reservation_status
    -> FROM TRAINS T
    -> INNER JOIN RESERVATIONS R
    ->     ON T.Train_ID = R.Train_ID;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM Train_Reservation_View;
+----------+--------------------+-----------------+----------------+--------------+--------------+--------------+--------------------+
| Train_ID | Train_Name         | Train_type      | Reservation_ID | Passenger_ID | Journey_Date | Total_Amount | Reservation_status |
+----------+--------------------+-----------------+----------------+--------------+--------------+--------------+--------------------+
|        1 | Godavari Express   | Express         |              1 |            1 | 2026-09-10   |       850.00 | Confirmed          |
|        2 | Krishna Express    | Express         |              2 |            2 | 2026-09-12   |       950.00 | Confirmed          |
|        3 | Charminar Express  | Superfast       |              3 |            3 | 2026-09-15   |      1100.00 | Pending            |
|        4 | Vande Bharat       | Semi High Speed |              4 |            4 | 2026-09-18   |      1500.00 | Confirmed          |
|        5 | East Coast Express | Express         |              5 |            5 | 2026-09-20   |      1250.00 | Cancelled          |
+----------+--------------------+-----------------+----------------+--------------+--------------+--------------+--------------------+
5 rows in set (0.00 sec)

mysql> CREATE VIEW Route_Train_View AS
    -> SELECT
    ->     R.Route_ID,
    ->     R.Route_Name,
    ->     R.Train_ID,
    ->     T.Train_Name,
    ->     T.Train_type,
    ->     R.Travel_time,
    ->     R.Distance
    -> FROM ROUTES R
    -> INNER JOIN TRAINS T
    ->     ON R.Train_ID = T.Train_ID;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> SELECT * FROM Route_Train_View;
+----------+-------------------------+----------+--------------------+-----------------+-------------+----------+
| Route_ID | Route_Name              | Train_ID | Train_Name         | Train_type      | Travel_time | Distance |
+----------+-------------------------+----------+--------------------+-----------------+-------------+----------+
|        1 | Hyderabad-Vijayawada    |        1 | Godavari Express   | Express         | 05:30:00    |   275.00 |
|        2 | Vijayawada-Chennai      |        2 | Krishna Express    | Express         | 06:00:00    |   430.00 |
|        3 | Chennai-Bengaluru       |        3 | Charminar Express  | Superfast       | 05:00:00    |   350.00 |
|        4 | Bengaluru-Visakhapatnam |        4 | Vande Bharat       | Semi High Speed | 10:30:00    |   760.00 |
|        5 | Visakhapatnam-Hyderabad |        5 | East Coast Express | Express         | 12:00:00    |   620.00 |
+----------+-------------------------+----------+--------------------+-----------------+-------------+----------+
5 rows in set (0.00 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE Get_Passenger_By_ID(IN p_id INT)
    -> BEGIN
    ->     SELECT *
    ->     FROM PASSENGERS
    ->     WHERE Passenger_ID = p_id;
    -> END //
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL Get_Passenger_By_ID(1);
+--------------+------------+----------+---------------+--------+----------+
| Passenger_ID | Phone_no   | Address  | Date_of_birth | Gender | ID_proof |
+--------------+------------+----------+---------------+--------+----------+
|            1 | 9876543210 | Warangal | 2002-05-14    | Female | IDP001   |
+--------------+------------+----------+---------------+--------+----------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE Get_Confirmed_Reservations()
    -> BEGIN
    ->     SELECT
    ->         Reservation_ID,
    ->         Passenger_ID,
    ->         Train_ID,
    ->         Journey_Date,
    ->         Total_Amount,
    ->         Reservation_status,
    ->         Payment_status
    ->     FROM RESERVATIONS
    ->     WHERE Reservation_status = 'Confirmed';
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL Get_Confirmed_Reservations();
+----------------+--------------+----------+--------------+--------------+--------------------+----------------+
| Reservation_ID | Passenger_ID | Train_ID | Journey_Date | Total_Amount | Reservation_status | Payment_status |
+----------------+--------------+----------+--------------+--------------+--------------------+----------------+
|              1 |            1 |        1 | 2026-09-10   |       850.00 | Confirmed          | Paid           |
|              2 |            2 |        2 | 2026-09-12   |       950.00 | Confirmed          | Paid           |
|              4 |            4 |        4 | 2026-09-18   |      1500.00 | Confirmed          | Paid           |
+----------------+--------------+----------+--------------+--------------+--------------------+----------------+
3 rows in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> DELIMITER //
mysql>
mysql> CREATE PROCEDURE Get_Train_Reservations(IN t_id INT)
    -> BEGIN
    ->     SELECT
    ->         R.Reservation_ID,
    ->         R.Passenger_ID,
    ->         R.Train_ID,
    ->         R.Journey_Date,
    ->         R.Total_Amount,
    ->         R.Reservation_status,
    ->         R.Payment_status
    ->     FROM RESERVATIONS R
    ->     WHERE R.Train_ID = t_id;
    -> END //
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql> CALL Get_Train_Reservations(1);
+----------------+--------------+----------+--------------+--------------+--------------------+----------------+
| Reservation_ID | Passenger_ID | Train_ID | Journey_Date | Total_Amount | Reservation_status | Payment_status |
+----------------+--------------+----------+--------------+--------------+--------------------+----------------+
|              1 |            1 |        1 | 2026-09-10   |       850.00 | Confirmed          | Paid           |
+----------------+--------------+----------+--------------+--------------+--------------------+----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

mysql>
mysql>
