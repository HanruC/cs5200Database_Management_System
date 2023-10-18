CREATE DATABASE nationalPark;
USE nationalPark;

CREATE TABLE global_location (
	latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    locationID INT PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE political_territory (
	territory_name VARCHAR(64) NOT NULL PRIMARY KEY,
    territory_type ENUM('US STATE', 'official US territory') NOT NULL,
    locationID INT,
    FOREIGN KEY (locationID) REFERENCES global_location(locationID) ON DELETE RESTRICT ON UPDATE RESTRICT);
    
CREATE TABLE adjacent_territory (
	territory_name1 VARCHAR(64),
	territory_name2 VARCHAR(64),
    PRIMARY KEY(territory_name1, territory_name2),
    FOREIGN KEY (territory_name1) 
		REFERENCES political_territory(territory_name) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (territory_name2) 
		REFERENCES political_territory(territory_name) ON DELETE RESTRICT ON UPDATE RESTRICT);
    
    
CREATE TABLE national_park (
	park_name VARCHAR(64) PRIMARY KEY,
    photo_collection TEXT,
    direction TEXT,
    description TEXT,
    locationID INT,
    FOREIGN KEY (locationID) 
		REFERENCES global_location(locationID) ON DELETE RESTRICT ON UPDATE RESTRICT);
        
CREATE TABLE nationalParkANDterritory (
	park_name VARCHAR(64),
    territory_name VARCHAR(64),
    PRIMARY KEY(park_name, territory_name),
    FOREIGN KEY (park_name) REFERENCES national_park(park_name) 
		ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (territory_name) REFERENCES political_territory(territory_name) 
		ON DELETE RESTRICT ON UPDATE RESTRICT);
    
CREATE TABLE site (
	site_name VARCHAR(64) PRIMARY KEY,
    textual_description TEXT,
    photo_collection TEXT,
    driving_direction TEXT,
    park_name VARCHAR(64),
    locationID INT,
    FOREIGN KEY (locationID) REFERENCES global_location(locationID) 
		ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (park_name) REFERENCES national_park(park_name) 
		ON DELETE RESTRICT ON UPDATE RESTRICT); 
    
CREATE TABLE accommodation (
	type ENUM('Campsite', 'Hotel'),
    accommodationID INT PRIMARY KEY,
    accommodation_name VARCHAR(64),
    destination_direction TEXT,
    cost_per_night FLOAT,
    phone VARCHAR(16) UNIQUE,
    locationID INT,
    park_name VARCHAR(64),
    FOREIGN KEY (locationID) REFERENCES global_location(locationID) 
		ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (park_name) REFERENCES national_park(park_name) 
		ON DELETE RESTRICT ON UPDATE RESTRICT);
    