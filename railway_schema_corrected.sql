-- Railway Reservation System - Corrected Schema
-- Created with proper foreign key relationships and fixed syntax errors

-- ============================================================================
-- STATIONS - Independent table (must exist before routes)
-- ============================================================================
CREATE TABLE STATIONS (
    Station_ID INT PRIMARY KEY AUTO_INCREMENT,
    Station_Name VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    UNIQUE (Station_Name, City, State)
);


-- ============================================================================
-- ROUTES - Connects two stations
-- ============================================================================
CREATE TABLE ROUTES (
    Route_ID INT PRIMARY KEY AUTO_INCREMENT,
    Route_Name VARCHAR(100) NOT NULL UNIQUE,
    Source_station_ID INT NOT NULL,
    Destination_station_ID INT NOT NULL,
    Travel_time TIME NOT NULL,
    Distance DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT fk_route_source_station
        FOREIGN KEY (Source_station_ID) REFERENCES STATIONS(Station_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    CONSTRAINT fk_route_destination_station
        FOREIGN KEY (Destination_station_ID) REFERENCES STATIONS(Station_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    CHECK (Source_station_ID <> Destination_station_ID),
    CHECK (Distance > 0)
);


-- ============================================================================
-- TRAINS - Runs on specific routes
-- ============================================================================
CREATE TABLE TRAINS (
    Train_ID INT PRIMARY KEY AUTO_INCREMENT,
    Train_Name VARCHAR(100) NOT NULL UNIQUE,
    Train_type VARCHAR(50) NOT NULL,
    Route_ID INT NOT NULL,
    
    CONSTRAINT fk_train_route
        FOREIGN KEY (Route_ID) REFERENCES ROUTES(Route_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    CHECK (Train_type IN ('Express', 'Passenger', 'Superfast', 'Local'))
);


-- ============================================================================
-- PASSENGERS - Passenger information (independent)
-- ============================================================================
CREATE TABLE PASSENGERS (
    Passenger_ID INT PRIMARY KEY AUTO_INCREMENT,
    Phone_no VARCHAR(15) NOT NULL UNIQUE,
    Address VARCHAR(255) NOT NULL,
    Date_of_birth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    ID_proof VARCHAR(50) NOT NULL,
    
    CHECK (Gender IN ('Male', 'Female', 'Other'))
);


-- ============================================================================
-- RESERVATIONS - Links passengers to trains
-- ============================================================================
CREATE TABLE RESERVATIONS (
    Reservation_ID INT PRIMARY KEY AUTO_INCREMENT,
    Passenger_ID INT NOT NULL,
    Train_ID INT NOT NULL,
    Booking_Date DATE NOT NULL DEFAULT (CURRENT_DATE),
    Journey_Date DATE NOT NULL,
    Departure_Time TIME NOT NULL,
    Arrival_Time TIME NOT NULL,
    Total_Amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    Reservation_status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    Payment_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    
    CONSTRAINT fk_reservation_passenger
        FOREIGN KEY (Passenger_ID) REFERENCES PASSENGERS(Passenger_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    CONSTRAINT fk_reservation_train
        FOREIGN KEY (Train_ID) REFERENCES TRAINS(Train_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    CHECK (Journey_Date >= Booking_Date),
    CHECK (Total_Amount >= 0),
    CHECK (Departure_Time <> Arrival_Time),
    CHECK (Reservation_status IN ('Confirmed', 'Cancelled', 'Pending')),
    CHECK (Payment_status IN ('Paid', 'Pending', 'Failed', 'Refunded'))
);


-- ============================================================================
-- TICKETS - Individual tickets from reservations
-- ============================================================================
CREATE TABLE TICKETS (
    Ticket_ID INT PRIMARY KEY AUTO_INCREMENT,
    Reservation_ID INT NOT NULL,
    Train_ID INT NOT NULL,
    Ticket_Date DATE NOT NULL DEFAULT (CURRENT_DATE),
    Class VARCHAR(20) NOT NULL DEFAULT 'General',
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',
    Seat_number VARCHAR(10) NOT NULL,
    
    CONSTRAINT fk_ticket_reservation
        FOREIGN KEY (Reservation_ID) REFERENCES RESERVATIONS(Reservation_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    CONSTRAINT fk_ticket_train
        FOREIGN KEY (Train_ID) REFERENCES TRAINS(Train_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    CONSTRAINT uq_train_seat
        UNIQUE (Train_ID, Seat_number),
    
    CHECK (Class IN ('General', 'Sleeper', 'AC', 'First Class')),
    CHECK (Status IN ('Active', 'Cancelled', 'Used'))
);
