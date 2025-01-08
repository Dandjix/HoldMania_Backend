USE HoldMania;

DROP TABLE IF EXISTS ORDER_LINE;
DROP TABLE IF EXISTS `ORDER`;
DROP TABLE IF EXISTS HOLD;
DROP TABLE IF EXISTS HOLD_TYPE;
DROP TABLE IF EXISTS HOLD_COLOR;
DROP TABLE IF EXISTS CLIENT;
DROP TABLE IF EXISTS CLIENT_LEVEL;

CREATE TABLE HOLD_TYPE (
    idHoldType INT AUTO_INCREMENT PRIMARY KEY,
    holdTypeName VARCHAR(50) NOT NULL
);


CREATE TABLE HOLD_COLOR (
    idHoldColor INT AUTO_INCREMENT PRIMARY KEY,
    holdColorName VARCHAR(50) NOT NULL
);

CREATE TABLE CLIENT_LEVEL (
    idClientLevel INT AUTO_INCREMENT PRIMARY KEY,
    clientLevelName VARCHAR(50) NOT NULL
);

CREATE TABLE HOLD (
    idHold INT AUTO_INCREMENT PRIMARY KEY,
    holdName VARCHAR(31),
    idHoldType INT NOT NULL,
    idHoldColor INT NOT NULL,
    idClientLevel INT,
	price DECIMAL(10, 2),
    weight DECIMAL(10, 2),
    sizeMeters DECIMAL(10, 2),
    imageURL VARCHAR(255),
    FOREIGN KEY (idHoldType) REFERENCES HOLD_TYPE(idHoldType),
    FOREIGN KEY (idHoldColor) REFERENCES HOLD_COLOR(idHoldColor),
    FOREIGN KEY (idClientLevel) REFERENCES CLIENT_LEVEL(idClientLevel)
);

CREATE TABLE CLIENT (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    dateOfBirth DATE NOT NULL,
    phoneNumber VARCHAR(10) UNIQUE,
    profilePictureURL VARCHAR(100),
    idClientLevel INT NOT NULL,
    FOREIGN KEY (idClientLevel) REFERENCES CLIENT_LEVEL(idClientLevel)
);


CREATE TABLE `ORDER` (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    dateOrder DATE NOT NULL,
    isSent BOOLEAN DEFAULT false,
    idUser INT NOT NULL,
    FOREIGN KEY (idUser) REFERENCES CLIENT(idClient)
);


CREATE TABLE ORDER_LINE (
    idOrder INT NOT NULL,
    idHold INT NOT NULL,
    quantity INT DEFAULT 1 CHECK(quantity >=1),
    PRIMARY KEY (idOrder, idHold),
    FOREIGN KEY (idOrder) REFERENCES `ORDER`(idOrder),
    FOREIGN KEY (idHold) REFERENCES HOLD(idHold)
);

-- Inserts

INSERT INTO CLIENT_LEVEL (clientLevelName) VALUES 
('Débutant'),
('Amateur'),
('Professionnel');

-- Insert data into CLIENT
INSERT INTO CLIENT (firstName, lastName, email, dateOfBirth,phoneNumber,profilePictureURL, idClientLevel) VALUES 
('John', 'Doe', 'john.doe@orange.fr', '1990-01-15','0769241429','john.png', 1),
('Jane', 'Smith', 'jane.smith@outlook.com','1985-06-20','0752915211','invalid.png',  2),
('Alice', 'Brown', 'alicebrown12@gmail.com','2000-09-05','0613131313','alice.png',  3);

-- Insert data into HOLD_TYPE
INSERT INTO HOLD_TYPE (holdTypeName) VALUES 
('Sloper'),
('Jug'),
('Crimp'),
('Pinch'),
('Pocket');

-- Insert data into HOLD_COLOR
INSERT INTO HOLD_COLOR (holdColorName) VALUES 
('Rouge'),
('Bleue'),
('Verte'),
('Jaune'),
('Noire');

-- Insert data into HOLD
INSERT INTO HOLD (holdName, idHoldType, idHoldColor, idClientLevel,price, weight, sizeMeters, imageURL) VALUES 
("La prise du dragon",1, 1, 1,12, 1.5, 0.3, 'dragon'),
("Prise GAMING",2, 2, 2,11.5, 2.0, 0.5, 'galactique'),
("Prise infernale",3, 3, 3,13.99, 0.8, 0.2, 'impossible'),
("Lezard-o-max",4, 4, 1,9.7, 1.2, 0.4, 'lezard'),
("Slopper glissant af",5, 5, 2,11, 1.7, 0.6, 'lune'),
("Griffon Talon", 1, 1, 1, 12.5, 1.3, 0.4, 'griffon'),
("Obsidian Fang", 2, 3, 2, 15.0, 1.8, 0.5, 'obsidian'),
("Crystal Spire", 3, 5, 3, 10.0, 0.9, 0.3, 'crystal'),
("Meteorite Edge", 4, 2, 1, 13.2, 1.4, 0.6, 'meteorite'),
("Thunder Grip", 5, 4, 2, 14.7, 1.9, 0.7, 'thunder'),
("Aqua Ridge", 1, 2, 3, 9.8, 1.1, 0.2, 'aqua'),
("Scarlet Razor", 2, 1, 1, 12.0, 0.7, 0.3, 'scarlet'),
("Shadow Hold", 3, 5, 2, 11.6, 1.0, 0.4, 'shadow'),
("Phantom Grip", 4, 3, 3, 13.5, 1.2, 0.5, 'phantom'),
("Firestorm", 5, 4, 1, 14.9, 1.6, 0.6, 'firestorm'),
("Golden Claw", 1, 2, 2, 12.4, 1.5, 0.3, 'golden_claw'),
("Lunar Edge", 2, 4, 3, 10.5, 1.3, 0.4, 'lunar'),
("Tidal Grip", 3, 1, 1, 11.2, 1.4, 0.5, 'tidal'),
("Verdant Spire", 4, 3, 2, 9.9, 0.8, 0.2, 'verdant'),
("Pyroclastic", 5, 5, 3, 13.8, 1.6, 0.6, 'pyroclastic'),
("Blazing Hook", 1, 4, 1, 15.0, 1.9, 0.7, 'blazing_hook'),
("Icy Grip", 2, 2, 2, 12.3, 1.7, 0.5, 'icy'),
("Storm Clasp", 3, 1, 3, 10.1, 1.0, 0.3, 'storm'),
("Iron Clutch", 4, 3, 1, 14.2, 1.8, 0.6, 'iron'),
("Dragon Scale", 5, 5, 2, 9.6, 1.2, 0.4, 'dragon_scale'),
("Molten Crest", 1, 4, 3, 13.1, 1.3, 0.2, 'molten'),
("Nimbus Touch", 2, 2, 1, 11.9, 1.5, 0.4, 'nimbus'),
("Oblivion Grip", 3, 5, 2, 14.8, 1.7, 0.5, 'oblivion'),
("Aurora Clasp", 4, 3, 3, 12.2, 0.9, 0.3, 'aurora'),
("Glacial Fang", 5, 1, 1, 10.4, 1.2, 0.6, 'glacial'),
("Solar Spine", 1, 2, 2, 9.5, 1.8, 0.7, 'solar_spine'),
("Dusk Edge", 2, 4, 3, 14.6, 1.4, 0.3, 'dusk'),
("Inferno Grip", 3, 5, 1, 15.2, 1.6, 0.4, 'inferno'),
("Cobalt Hook", 4, 3, 2, 12.7, 1.1, 0.5, 'cobalt'),
("Venom Fang", 5, 4, 3, 13.4, 1.3, 0.6, 'venom'),
("Twilight Talon", 1, 2, 1, 10.8, 1.9, 0.7, 'twilight'),
("Mystic Hold", 2, 1, 2, 11.3, 1.5, 0.2, 'mystic'),
("Shimmer Fang", 3, 5, 3, 14.0, 1.0, 0.3, 'shimmer'),
("Arcane Spire", 4, 3, 1, 9.7, 1.6, 0.4, 'arcane'),
("Celestial Grip", 5, 2, 2, 15.1, 1.8, 0.5, 'celestial');

-- Insert data into ORDER
INSERT INTO `ORDER` (dateOrder, idUser) VALUES 
('2024-12-01', 1),
('2024-12-02', 2),
('2024-12-03', 3);

-- Insert data into ORDER_LINE
INSERT INTO ORDER_LINE (idOrder, idHold, quantity) VALUES 
(1, 1,1),
(1, 2,2),
(2, 3,3),
(2, 4,4),
(3, 5,5);


-- selects

SELECT idHold,

HOLD_COLOR.holdColorName,
HOLD_TYPE.holdTypeName,
CLIENT_LEVEL.clientLevelName,

holdName,
price,
weight,
sizeMeters,
imageURL 

FROM HOLD
LEFT JOIN HOLD_COLOR ON HOLD.idHoldColor = HOLD_COLOR.idHoldColor
LEFT JOIN HOLD_TYPE ON HOLD.idHoldType = HOLD_TYPE.idHoldType
LEFT JOIN CLIENT_LEVEL ON HOLD.idClientLevel = CLIENT_LEVEL.idClientLevel
;

SELECT 
    O.idOrder,
    O.dateOrder,
    SUM(H.price * OL.quantity) AS totalOrderPrice,
    SUM(OL.quantity) AS totalNumberOfHolds
FROM `ORDER` O
JOIN ORDER_LINE OL ON O.idOrder = OL.idOrder
JOIN HOLD H ON OL.idHold = H.idHold
WHERE O.idUser = 1
GROUP BY O.idOrder, O.dateOrder;

SELECT quantity, holdName, imageURL, price AS unitPrice,price*quantity AS totalPrice  FROM ORDER_LINE
LEFT JOIN HOLD ON ORDER_LINE.idHold = HOLD.idHold
WHERE idOrder = 3
;

UPDATE ORDER_LINE
SET quantity=32
WHERE idOrder = 1 AND idHold =1
;


DELETE FROM ORDER_LINE WHERE idOrder= 1 AND idHold = 2;

SELECT * FROM ORDER_LINE;

SELECT * FROM `ORDER`;

SELECT COUNT(idOrder) FROM `ORDER` WHERE idUser=1 AND isSent=False;

UPDATE `ORDER` SET isSent = true WHERE idOrder = 1;

SELECT isSent FROM `ORDER` WHERE idOrder = 1;

SELECT idClient,firstName,lastName,email,dateOfBirth,phoneNumber, clientLevelName
FROM CLIENT 
LEFT JOIN CLIENT_LEVEL ON  CLIENT.idClientLevel = CLIENT_LEVEL.idClientLevel
WHERE idClient = 1;


SELECT * FROM `ORDER`;

SELECT * FROM HOLD;

SELECT * FROM HOLD
WHERE HOLD.holdName LIKE '%dragon%'
;

SELECT * FROM CLIENT;