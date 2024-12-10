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
('Beginner'),
('Intermediate'),
('Advanced');

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
('Red'),
('Blue'),
('Green'),
('Yellow'),
('Black');

-- Insert data into HOLD
INSERT INTO HOLD (holdName, idHoldType, idHoldColor, idClientLevel,price, weight, sizeMeters, imageURL) VALUES 
("Hold1",1, 1, 1,12, 1.5, 0.3, 'http://example.com/hold1.jpg'),
("Hold2",2, 2, 2,11.5, 2.0, 0.5, 'http://example.com/hold2.jpg'),
("Hold3",3, 3, 3,13.99, 0.8, 0.2, 'http://example.com/hold3.jpg'),
("Hold4",4, 4, 1,9.7, 1.2, 0.4, 'http://example.com/hold4.jpg'),
("Hold5",5, 5, 2,11, 1.7, 0.6, 'http://example.com/hold5.jpg');

-- Insert data into ORDER
INSERT INTO `ORDER` (dateOrder, idUser) VALUES 
('2024-12-01', 1),
('2024-12-02', 2),
('2024-12-03', 3),
('2024-12-01', 3);

-- Insert data into ORDER_LINE
INSERT INTO ORDER_LINE (idOrder, idHold, quantity) VALUES 
(1, 1,1),
(1, 2,2),
(2, 3,3),
(2, 4,4),
(3, 5,5),
(4, 1,6);


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