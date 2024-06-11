CREATE DATABASE ChloroBase;

CREATE TABLE plants (
    name VARCHAR(20) PRIMARY KEY,
    lifespan VARCHAR(20) NOT NULL,
    description VARCHAR(117) NULL,
    type VARCHAR(20) NOT NULL,
    disease VARCHAR(50) NULL,
    symbolism VARCHAR(100) NULL,
    synonyms VARCHAR(200) NULL
);

ALTER TABLE plants
ADD images IMAGE NULL;

CREATE TABLE [Agriculture Expert] (
    Exp_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(20) NULL,
    experience VARCHAR(200)
);

CREATE TABLE Customers (
    Cust_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    address VARCHAR(50) NULL,
    email VARCHAR(50) NOT NULL,
    Expert_id INT NULL,
    FOREIGN KEY (Expert_id) REFERENCES [Agriculture Expert](Exp_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE browsing (
    Cust_id INT ,
    Plant_name VARCHAR(20),
    PRIMARY KEY(Cust_id, Plant_name),
    FOREIGN KEY (Plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Cust_id) REFERENCES Customers(Cust_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Items (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    It_name VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    item_type VARCHAR(20) CHECK (item_type IN ('Fertilizer', 'Seeds')) NOT NULL
);

ALTER TABLE Items
ADD price FLOAT NULL;


CREATE TABLE purchase (
    Cust_id INT ,
    itemID INT,
    PRIMARY KEY(Cust_id, itemID),
    FOREIGN KEY (itemID) REFERENCES Items(Id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Cust_id) REFERENCES Customers(Cust_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Payment (
    payment_Nb INT IDENTITY(1000,1),
    Pdate DATE NOT NULL,
    amount INT NOT NULL,
    cust_id INT,
    PRIMARY KEY(cust_id,payment_Nb),
    FOREIGN KEY (cust_id) REFERENCES Customers(Cust_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Findings (
    nameStory VARCHAR(2000) NOT NULL,
    Fdate DATE NULL,
    ecology VARCHAR(50) NULL,
    remarks VARCHAR(100) NULL,
    plant_name VARCHAR(20),
    FOREIGN KEY (plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Conditions (
    cond_Nb INT IDENTITY (1,1),
    soil VARCHAR(30) NULL,
    sunlight VARCHAR(30) NULL,
    hydration VARCHAR(30) NULL,
    pruning VARCHAR(30) NULL,
    fertilization VARCHAR(30) NULL,
    plant_name VARCHAR(20),
    PRIMARY KEY(plant_name,cond_Nb),
    FOREIGN KEY (plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Habitat (
    habitat_Nb INT IDENTITY (1,1) PRIMARY KEY,
    location VARCHAR(30) NOT NULL,
    humidity INT NULL,
    temperature INT NULL,
    latitude INT NULL,
    longitude INT NULL,
    altitude INT NULL,
    hardiness INT NULL,
    plant_name VARCHAR(20),
    cond_Nb INT,
    FOREIGN KEY (plant_name, cond_Nb) REFERENCES Conditions(plant_name, cond_Nb) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE specify (
    plant_name VARCHAR(20),
    cond_Nb INT,
    habitatId INT,
    PRIMARY KEY(cond_Nb, habitatId),
    FOREIGN KEY (plant_name, cond_Nb) REFERENCES Conditions(plant_name, cond_Nb) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (habitatId) REFERENCES Habitat(habitat_Nb) ON DELETE NO ACTION ON UPDATE NO ACTION
);




CREATE TABLE Measurements (
    size INT NULL,
    height INT NULL,
    spread INT NULL,
    plant_name VARCHAR(20),
    FOREIGN KEY (plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Color (
    color_Nb INT IDENTITY(1,1),
    leaf_color VARCHAR(30) NULL,
    stem_color VARCHAR(30) NULL,
    fruit_color VARCHAR(30) NULL,
    flower_color VARCHAR(30) NULL,
    plant_name VARCHAR(20),
    PRIMARY KEY(color_Nb, plant_name),
    FOREIGN KEY (plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE [Planting Calendar] (
    planting_time VARCHAR(30) NULL,
    harvesting_time VARCHAR(30) NULL,
    blooming_time VARCHAR(30) NULL,
    plant_name VARCHAR(20),
    FOREIGN KEY (plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Disease (
    plantName VARCHAR(20) NOT NULL,
    disease VARCHAR(20) NOT NULL,
    FOREIGN KEY (plantName) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(plantName, disease)
);

CREATE TABLE Synonym (
    plantName VARCHAR(20) NOT NULL,
    synonym VARCHAR(20) NOT NULL,
    FOREIGN KEY (plantName) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(plantName, synonym)
);

CREATE TABLE Fertilizers (
    it_id INT PRIMARY KEY,
    --fert_name VARCHAR(20) NOT NULL,
    --qty INT NULL,
    f_rate INT NULL CHECK (f_rate >= 0 AND f_rate <= 5),
    FOREIGN KEY (it_id) REFERENCES Items(Id)
);

CREATE TABLE Seeds (
    it_id INT PRIMARY KEY,
    --S_name VARCHAR(20) NOT NULL,
    --qty INT NULL,
    S_rate INT NULL CHECK (S_rate >= 0 AND S_rate <= 5),
    plant_name VARCHAR(20),
    FOREIGN KEY (it_id) REFERENCES Items(Id),
    FOREIGN KEY (plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE used_for (
    fertilizer_id INT,
    plant_name VARCHAR(20),
    PRIMARY KEY(fertilizer_id, plant_name),
    FOREIGN KEY(fertilizer_id) REFERENCES Fertilizers(it_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(plant_name) REFERENCES plants(name) ON DELETE CASCADE ON UPDATE CASCADE
);


---------------------------------------------------------------------------


INSERT INTO plants (name, lifespan, description, type, disease, symbolism, synonyms, images)
VALUES 
('Cucumber', '1-2 months', 'A creeping vine that bears cucumiform fruits used as vegetables.', 'Vegetable', NULL, 'Coolness, Refreshment', 'Cuke, Gherkin','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\cucumber.jpg'),
('Eggplant', '1-3 years', 'A species of nightshade grown for its edible fruit.', 'Vegetable', 'Verticillium Wilt', 'Sensitivity, Mystery', 'Aubergine','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\eggplant.jpg'),
('CherryPlum', '20-25 years', 'A species of plum tree, also known as Myrobalan Plum, cultivated for its fruit.', 'Fruit tree', 'Black Knot', 'Love, Good Fortune', 'Myrobalan Plum','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Cherry_Plum.jpg'),
('Onion', '3-6 months', 'A biennial plant grown as a vegetable for its edible bulb.', 'Vegetable', 'Downy Mildew', 'Endurance, Renewal', 'Allium cepa','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\onion.jpg'),
('ChinaRose', '5-7 years', 'A woody perennial flowering plant, commonly known as Hibiscus.', 'Flower', 'Hibiscus Bacterial Blight', 'Passion, Beauty', 'Hibiscus rosa-sinensis','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\China_Rose.jpg'),
('Mango', '30-40 years', 'A tropical fruit tree cultivated for its edible fruit.', 'Fruit tree', 'Anthracnose', 'Abundance, Love', NULL,'C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Mango.jpg'),
('CornPlant', '2-3 years', 'A species of Dracaena known for its long leaves and ease of growth as a houseplant.', 'Houseplant', NULL, 'Abundance, Prosperity', 'Dracaena fragrans','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\corn_plant.jpg'),
('Inchplant', 'Indoor', 'A species of Tradescantia grown as a houseplant for its trailing habit and striking foliage.', 'Houseplant', NULL, 'Adaptability, Growth', 'Tradescantia zebrina','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Inchplant.jpg'),
('CrepeMyrtle', '20-30 years', 'A flowering tree or shrub known for its colorful and long-lasting summer blooms.', 'Ornamental', 'Powdery Mildew', 'Love, Romance', 'Lagerstroemia','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Crepe_Myrtle.jpg'),
('Tomato', '1-2 years', 'A savory, typically red fruit commonly used as a vegetable in cooking.', 'Vegetable', 'Early Blight', 'Abundance, Vitality', NULL,'C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Tomato.jpg'),
('AloeVera', 'Indoor', 'A succulent plant species cultivated for its medicinal, cosmetic, and ornamental uses.', 'Houseplant', NULL, 'Healing, Protection', 'Aloe barbadensis','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Aloe.jpg'),
('FoxtailAgave', '10-15 years', 'A species of Agave known for its symmetrical rosettes of narrow, rigid leaves.', 'Succulent', NULL, 'Endurance, Strength', 'Agave attenuata','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Foxtail.jpg'),
('JapanesePrivet', '50+ years', 'A species of Ligustrum often used as a hedge or ornamental plant.', 'Shrub', 'Leaf Spot', 'Purity, Loyalty', 'Ligustrum japonicum','C:\Users\User\OneDrive\Desktop\GhidaGhalayini-202301088-Database Final Project\Images\Japanese.jpg');


INSERT INTO Synonym (plantName, synonym)
VALUES 
('Cucumber', 'Cuke'),
('Cucumber', 'Gherkin'),
('Cucumber', 'Pickles'),
('Eggplant', 'Aubergine'),
('Eggplant', 'Brinjal'),
('CherryPlum', 'Myrobalan Plum'),
('CherryPlum', 'Wild Plum'),
('Onion', 'Allium cepa'),
('Onion', 'Bulb Onion'),
('ChinaRose', 'Hawaiian Hibiscus'),
('Mango', 'Mangifera indica'),
('Mango', 'King of Fruits'),
('CornPlant', 'Dracaena fragrans'),
('CornPlant', 'Cornstalk Dracaena'),
('Inchplant', 'Tradescantia zebrina'),
('Inchplant', 'Wandering Jew'),
('CrepeMyrtle', 'Lagerstroemia'),
('CrepeMyrtle', 'Crape Myrtle'),
('Tomato', 'Solanum lycopersicum'),
('Tomato', 'Love Apple'),
('AloeVera', 'Aloe barbadensis'),
('AloeVera', 'True Aloe'),
('FoxtailAgave', 'Agave attenuata'),
('FoxtailAgave', 'Lions Tail'),
('JapanesePrivet', 'Ligustrum japonicum'),
('JapanesePrivet', 'Waxleaf Privet');


INSERT INTO Disease (plantName, disease)
VALUES 
('Cucumber', 'Powdery Mildew'),
('Eggplant', 'Verticillium Wilt'),
('Eggplant', 'Powdery Mildew'),
('CherryPlum', 'Black Knot'),
('CherryPlum', 'Bacterial Canker'),
('Onion', 'White Rot'),
('ChinaRose', 'Powdery Mildew'),
('Mango', 'Anthracnose'),
('CornPlant', 'Corn Smut'),
('Inchplant', 'Leaf Spot'),
('CrepeMyrtle', 'Powdery Mildew'),
('Tomato', 'Early Blight'),
('AloeVera', 'Aloe Rust'),
('FoxtailAgave', 'Agave Snout Weevil'),
('JapanesePrivet', 'Leaf Spot');


INSERT INTO [Planting Calendar] (planting_time, harvesting_time, blooming_time, plant_name)
VALUES 
('Spring', 'Summer', 'Summer', 'Cucumber'),
('Spring', 'Summer', 'Summer', 'Eggplant'),
('Spring', 'Summer', 'Spring', 'CherryPlum'),
('Spring', 'Summer', 'Fall', 'Onion'),
('Spring', 'Summer', 'Summer', 'ChinaRose'),
('Spring', 'Summer', 'Summer', 'Mango'),
('Spring', 'Summer', 'Summer', 'CornPlant'),
('Spring', 'Summer', 'Summer', 'Inchplant'),
('Spring', 'Summer', 'Summer', 'CrepeMyrtle'),
('Spring', 'Summer', 'Summer', 'Tomato'),
('Spring', 'Summer', 'Spring', 'AloeVera'),
('Spring', 'Summer', 'Summer', 'FoxtailAgave'),
('Spring', 'Summer', 'Spring', 'JapanesePrivet');


INSERT INTO Measurements (size, height, spread, plant_name)
VALUES 
(10, 20, 15, 'Cucumber'),
(15, 25, 20, 'Eggplant'),
(20, 30, 25, 'CherryPlum'),
(12, 18, 10, 'Onion'),
(18, 35, 15, 'ChinaRose'),
(22, 40, 30, 'Mango'),
(16, 28, 18, 'CornPlant'),
(14, 22, 12, 'Inchplant'),
(25, 45, 35, 'CrepeMyrtle'),
(18, 32, 22, 'Tomato'),
(8, 12, 8, 'AloeVera'),
(20, 35, 30, 'FoxtailAgave'),
(24, 38, 28, 'JapanesePrivet');


INSERT INTO Color (leaf_color, stem_color, fruit_color, flower_color, plant_name)
VALUES 
('Green', 'Green', 'Green', 'Yellow', 'Cucumber'),
('Green', 'Purple', 'Purple', 'Purple', 'Eggplant'),
('Green', 'Brown', 'Red', 'Red', 'CherryPlum'),
('Green', 'White', 'White', 'White', 'Onion'),
('Green', 'Green', 'Yellow', 'Red', 'ChinaRose'),
('Green', 'Green', 'Yellow', 'Yellow', 'Mango'),
('Green', 'Yellow', 'Yellow', 'Yellow', 'CornPlant'),
('Green', 'Green', 'Green', 'Purple', 'Inchplant'),
('Pink', 'Pink', 'Pink', 'Pink', 'CrepeMyrtle'),
('Green', 'Green', 'Red', 'Yellow', 'Tomato'),
('Green', 'Green', 'Green', 'Yellow', 'AloeVera'),
('Green', 'Green', 'Green', 'Yellow', 'FoxtailAgave'),
('Green', 'Green', 'Green', 'White', 'JapanesePrivet');


INSERT INTO Conditions (soil, sunlight, hydration, pruning, fertilization, plant_name)
VALUES 
('Loamy', 'Full Sun', 'Regular', 'Occasional', 'Monthly', 'Cucumber'),
('Sandy', 'Partial Shade', 'Moderate', 'Regular', 'Bi-weekly', 'Eggplant'),
('Clay', 'Full Sun', 'Frequent', 'Regular', 'Weekly', 'CherryPlum'),
('Loamy', 'Full Sun', 'Regular', 'Regular', 'Weekly', 'Onion'),
('Sandy', 'Partial Shade', 'Regular', 'Regular', 'Monthly', 'ChinaRose'),
('Loamy', 'Full Sun', 'Frequent', 'Regular', 'Bi-weekly', 'Mango'),
('Sandy', 'Full Sun', 'Regular', 'Occasional', 'Weekly', 'CornPlant'),
('Loamy', 'Partial Shade', 'Regular', 'Regular', 'Monthly', 'Inchplant'),
('Clay', 'Full Sun', 'Regular', 'Regular', 'Bi-weekly', 'CrepeMyrtle'),
('Loamy', 'Full Sun', 'Regular', 'Regular', 'Weekly', 'Tomato'),
('Sandy', 'Full Sun', 'Infrequent', 'None', 'Monthly', 'AloeVera'),
('Sandy', 'Partial Shade', 'Regular', 'Regular', 'Bi-weekly', 'FoxtailAgave'),
('Loamy', 'Partial Shade', 'Regular', 'Regular', 'Monthly', 'JapanesePrivet');


INSERT INTO Habitat (location, humidity, temperature, latitude, longitude, altitude, hardiness, cond_Nb)
VALUES 
('Backyard', 60, 80, 40.7128, -74.0060, 100, 8, 1),  
('Garden', 70, 75, 34.0522, -118.2437, 200, 7, 2),   
('Orchard', 50, 85, 37.7749, -122.4194, 300, 9, 3), 
('Backyard', 60, 80, 40.7128, -74.0060, 100, 8, 4),  
('Garden', 70, 75, 34.0522, -118.2437, 200, 7, 5),   
('Orchard', 50, 85, 37.7749, -122.4194, 300, 9, 6), 
('Backyard', 60, 80, 40.7128, -74.0060, 100, 8, 7),  
('Garden', 70, 75, 34.0522, -118.2437, 200, 7, 8),   
('Orchard', 50, 85, 37.7749, -122.4194, 300, 9, 9),  
('Backyard', 60, 80, 40.7128, -74.0060, 100, 8, 10), 
('Garden', 70, 75, 34.0522, -118.2437, 200, 7, 11),  
('Orchard', 50, 85, 37.7749, -122.4194, 300, 9, 12), 
('Backyard', 60, 80, 40.7128, -74.0060, 100, 8, 13); 


INSERT INTO Findings (nameStory, Fdate, ecology, remarks, plant_name)
VALUES 
('Cucumbers are believed to have originated in India, where they have been cultivated for over 3,000 years. The name "cucumber" is derived from the Latin word "cucumis," which means "gourd."', '2024-04-20', 'Warm climate preferred', 'Requires regular watering', 'Cucumber'),
('Eggplants are native to the Indian subcontinent and are believed to have been first cultivated in China. The name "eggplant" originated in Europe, where early varieties resembled goose eggs.', '2024-04-21', 'Likes well-drained soil', 'Prone to Verticillium Wilt', 'Eggplant'),
('Cherry plums are a hybrid fruit resulting from the cross between the cherry and plum species. The name "CherryPlum" reflects their appearance, resembling small cherries but with the flavor of plums.', '2024-04-22', 'Full sunlight needed', 'Susceptible to Black Knot', 'CherryPlum'),
('The name "onion" comes from the Latin word "unio," meaning "single" or "union," possibly referring to the onions layered structure. Onions have been cultivated for thousands of years and have a rich culinary history worldwide.', '2024-04-20', 'Partial sunlight preferred', 'Moderate water requirement', 'Onion'),
('China rose, also known as Hibiscus rosa-sinensis, is native to East Asia. The name "ChinaRose" reflects its origin in China and its rose-like flowers, which have cultural significance in many Asian countries.', '2024-04-21', 'Well-drained soil required', 'Susceptible to Downy Mildew', 'ChinaRose'),
('Mangoes are native to South Asia, where they have been cultivated for over 4,000 years. The name "mango" is derived from the Tamil word "mangkay" or the Malayalam word "manga."', '2024-04-22', 'Requires humid environment', 'Prone to Anthracnose', 'Mango'),
('Corn plants, also known as Dracaena fragrans, are native to tropical Africa. The name "CornPlant" likely comes from their resemblance to maize (corn) plants, particularly their tall, slender stalks and broad leaves.', '2024-04-20', 'Requires ample sunlight', 'Regular watering needed', 'CornPlant'),
('Inch plants, also known as Tradescantia zebrina, are native to Mexico and Central America. The name "Inchplant" may refer to their creeping growth habit, as they can spread rapidly and cover large areas.', '2024-04-21', 'Thrives in moist soil', 'Susceptible to Spider Mites', 'Inchplant'),
('Crepe myrtles, also known as Lagerstroemia indica, are native to Asia. The name "CrepeMyrtle" may refer to their crinkled or crepe-like flowers, which resemble the texture of crepe fabric.', '2024-04-22', 'Well-drained soil preferred', 'Resistant to powdery mildew', 'CrepeMyrtle'),
('Tomatoes are native to western South America and were first cultivated by indigenous peoples. The name "tomato" is derived from the Nahuatl word "tomatl," which means "the swelling fruit."', '2024-04-20', 'Full sunlight required', 'Requires support for vines', 'Tomato'),
('Aloe vera is a succulent plant species native to the Arabian Peninsula. The name "AloeVera" is derived from the Arabic word "Alloeh," meaning "bitter," and the Latin word "vera," meaning "true."', '2024-04-21', 'Well-drained soil preferred', 'Susceptible to Blossom End Rot', 'AloeVera'),
('Foxtail agaves, also known as Agave attenuata, are native to Mexico. The name "FoxtailAgave" may refer to their flowering stalks, which resemble bushy fox tails.', '2024-04-22', 'Tolerates partial shade', 'Resistant to drought', 'FoxtailAgave'),
('Japanese privet, also known as Ligustrum japonicum, is native to Japan and eastern Asia. The name "JapanesePrivet" reflects its origin and its use as a hedge plant in traditional Japanese gardens.', '2024-04-20', 'Partial shade preferred', 'Resistant to deer browsing', 'JapanesePrivet');


INSERT INTO [Agriculture Expert] VALUES('Ziad Houssam','ZHoussam@hotmail.com','Phd in agriculture');
INSERT INTO [Agriculture Expert] VALUES('Amer Beydoun','AmerBey@gmail.com','ME in Bioprocessing Engineering & Entomology');
INSERT INTO [Agriculture Expert] VALUES('Lana Jammal','LanaJammal@gmail.com','Phd in Plant and Soil Science');
INSERT INTO [Agriculture Expert] VALUES('Maria Toubaji','MToubaji@hotmail.com','ME in Environmental Engineering');


INSERT INTO Customers VALUES('Samar Rajya','Beirut, 19-20th Street','S@gmail.com',1);
INSERT INTO Customers VALUES('Rayyan Hosni','Saida, 10-11th Street','R@hotmail.com',1);
INSERT INTO Customers VALUES('Sawsan Hameed','Beirut, 20-10th Street','S@gmail.com',2);
INSERT INTO Customers VALUES('Omar Reef','Tripoli, 30-14th Street','O@gmail.com',4);
INSERT INTO Customers VALUES('Zakaria Malik','Beirut, 20-10th Street','Z@gmail.com',3);
INSERT INTO Customers VALUES('Ziad Houssam','Beirut, 45-30th Street','Z@hotmail.com',2);
INSERT INTO Customers VALUES('Najat Hallak','Beirut, 11-12th Street','n@gmail.com',1);



INSERT INTO Items (It_name, quantity, price, item_type)
VALUES 
('Neu Base Granular', 50, 6,'Fertilizer'),
('Neu Olive & Mais', 50, 4.99,'Fertilizer'),
('Rose Food Fertilizer', 50, 10,'Fertilizer'),
('Neu-Zepton', 50, 7.68,'Fertilizer'),
('NeuCal-Mag', 50 ,3.25,'Fertilizer'),
('NeuCan', 50, 9,'Fertilizer'),
('NeuCombi', 50, 15,'Fertilizer'),
('NeuFlow', 50, 6.5,'Fertilizer'),
('NeuHumi-Start', 50, 4.25,'Fertilizer'),
('Cucumber seeds', 67,  56, 'Seeds'),
('Eggplant seeds', 100,  45.20, 'Seeds'),
('Onion seeds', 45,  60, 'Seeds'),
('Corn plant seeds', 67,  56, 'Seeds'),
('Inchplant seeds', 55,  40.40, 'Seeds'),
('China rose seeds', 85,  30, 'Seeds'),
('Crepe myrtle seeds', 40, 40, 'Seeds'),
('Mango seeds', 60, 50, 'Seeds'),
('Tomato seeds', 60,  20, 'Seeds'),
('Aloe vera seeds', 75,  50, 'Seeds'),
('Foxtail agave seeds', 55,  40, 'Seeds'),
('Japaneseprivet seeds', 40,  60,'Seeds'),
('Cherry plum seeds', 45,  40, 'Seeds');


INSERT INTO Fertilizers (it_id, f_rate)
VALUES 
(1,  3),
(2,  2),
(3,  4),
(4, 3),
(5, 2),
(6, 4),
(7, 4),
(8, 3),
(9, 2);


INSERT INTO Seeds (it_id, S_rate, plant_name)
VALUES
(10,  5, 'Cucumber'),
(11,  4, 'Eggplant'),
(12,  2, 'Onion'),
(13,  5, 'CornPlant'),
(14, 3,  'Inchplant'),
(15,  4, 'ChinaRose'),
(16,  4,'CrepeMyrtle'),
(17,  4,  'Mango'),
(18,  3,'Tomato'),
(19, 5, 'AloeVera'),
(20,  3,  'FoxtailAgave'),
(21,  4,  'JapanesePrivet'),
(22,  2, 'CherryPlum');


INSERT INTO used_for VALUES(1,'Cucumber');
INSERT INTO used_for VALUES(1,'Eggplant');
INSERT INTO used_for VALUES(1,'CherryPlum');
INSERT INTO used_for VALUES(2,'Eggplant');
INSERT INTO used_for VALUES(2,'Onion');
INSERT INTO used_for VALUES(2,'ChinaRose');
INSERT INTO used_for VALUES(2,'Mango');
INSERT INTO used_for VALUES(3,'Eggplant');
INSERT INTO used_for VALUES(3,'Mango');
INSERT INTO used_for VALUES(3,'CornPlant');
INSERT INTO used_for VALUES(3,'Inchplant');
INSERT INTO used_for VALUES(3,'ChinaRose');
INSERT INTO used_for VALUES(3,'Cucumber');
INSERT INTO used_for VALUES(3,'Onion');
INSERT INTO used_for VALUES(3,'CrepeMyrtle');
INSERT INTO used_for VALUES(4,'Tomato');
INSERT INTO used_for VALUES(4,'AloeVera');
INSERT INTO used_for VALUES(4,'FoxtailAgave');
INSERT INTO used_for VALUES(5,'JapanesePrivet');
INSERT INTO used_for VALUES(5,'CherryPlum');
INSERT INTO used_for VALUES(6,'CherryPlum');
INSERT INTO used_for VALUES(6,'JapanesePrivet');
INSERT INTO used_for VALUES(7,'Eggplant');
INSERT INTO used_for VALUES(7,'CrepeMyrtle');
INSERT INTO used_for VALUES(7,'CornPlant');
INSERT INTO used_for VALUES(8,'AloeVera');
INSERT INTO used_for VALUES(8,'CornPlant');
INSERT INTO used_for VALUES(9,'ChinaRose');
INSERT INTO used_for VALUES(9,'FoxtailAgave');


INSERT INTO purchase (Cust_id, itemID)
VALUES 
(1, 22),
(1, 13),
(2, 5),
(2, 17),
(3, 8),
(4, 20),
(4, 13),
(5, 22),
(5, 4),
(6, 18),
(6, 16);


INSERT INTO browsing (Cust_id, Plant_name)
VALUES 
(1, 'Cucumber'),
(2, 'Eggplant'),
(3, 'CherryPlum'),
(4, 'Onion'),
(5, 'ChinaRose'),
(6, 'Mango'),
(1, 'CrepeMyrtle'),
(2, 'Tomato'),
(3, 'AloeVera'),
(4, 'FoxtailAgave'),
(5, 'JapanesePrivet');


INSERT INTO Payment VALUES('2024-01-08',200,6);
INSERT INTO Payment VALUES('2023-09-17',420,1);
INSERT INTO Payment VALUES('2024-02-24',180,5);
INSERT INTO Payment VALUES('2023-10-26',240,2);


INSERT INTO specify (cond_Nb, habitatId)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13);



-----------------------------------------------------------------------------------------

--1 What are the different types of plants available in the dataset?
SELECT DISTINCT type 
FROM plants;

--2 Can you provide me with the names of plants that start with the letter 'C'?
SELECT name 
FROM plants 
WHERE name LIKE 'C%';

--3 Which plants have the highest height recorded, and in what order?
SELECT M.plant_name 
FROM Measurements AS M 
ORDER BY M.height DESC;

--4 Can you show me the names of plants along with their synonyms, if any?
SELECT plants.name, Synonym.synonym 
FROM plants INNER JOIN Synonym ON plants.name = Synonym.plantName;

--5 Could you create a summary view showing the total purchases and total spent by each customer?
CREATE VIEW CustomerPurchaseSummary AS
SELECT 
    c.Cust_id,
    c.name,
    COUNT(p.payment_Nb) AS total_purchases,
    SUM(p.amount) AS total_spent
FROM 
    Customers c
LEFT JOIN 
    Payment p ON c.Cust_id = p.Cust_id
GROUP BY 
    c.Cust_id, c.name;

--6  What are the names of plants and their associated fertilizers, along with the rate of usage?
SELECT plants.name AS Plant_Name, Items.It_name AS Fertilizer_Name, Fertilizers.f_rate AS Usage_Rate
FROM plants
LEFT JOIN used_for ON plants.name = used_for.plant_name
LEFT JOIN Fertilizers ON used_for.fertilizer_id = Fertilizers.it_id
LEFT JOIN Items ON Fertilizers.it_id = Items.Id
WHERE Fertilizers.it_id IS NOT NULL;

--7  Can you list the names of plants that are vegetables and require full sun exposure weekly?
SELECT name
FROM plants
WHERE type = 'Vegetable'
AND 'Full Sun' = ALL (SELECT sunlight FROM Conditions WHERE plant_name = plants.name)
AND 'Weekly' = ALL (SELECT fertilization FROM Conditions WHERE plant_name = plants.name);

--8 Show me the names of customers who have purchased both seeds and fertilizer.
SELECT c.name 
FROM Customers c 
WHERE EXISTS (SELECT * 
                FROM purchase pur JOIN Items i ON pur.itemID = i.Id 
                WHERE pur.Cust_id = c.Cust_id AND i.item_type = 'Seeds') AND EXISTS (SELECT * 
                                                                                        FROM purchase pur2 JOIN Items i2 ON pur2.itemID = i2.Id 
                                                                                        WHERE pur2.Cust_id = c.Cust_id AND i2.item_type = 'Fertilizer');


--9 What are the names and descriptions of all the plants in the dataset?
SELECT name, description 
FROM plants;

--10 Which plants have leaf colors that contain the word 'green'?
SELECT name 
FROM plants 
WHERE name IN (SELECT DISTINCT plant_name 
                FROM Color 
                WHERE leaf_color LIKE '%green%');

--11 What is the average, maximum, and minimum prices of items available?
SELECT AVG(price) AS Average, MAX(price) AS Maximum, MIN(price) AS Minimum
FROM Items;

--12 How many times has each plant been browsed by customers?
SELECT p.name, COUNT(b.Cust_id) AS Num_Of_Browses
FROM plants AS p
LEFT JOIN browsing AS b ON p.name = b.Plant_name
LEFT JOIN used_for AS u ON p.name = u.plant_name
GROUP BY p.name;

--13 Provide me with the names of plants whose average size is greater than 15.
SELECT name
FROM plants
WHERE name IN (
    SELECT plant_name
    FROM Measurements
    GROUP BY plant_name
    HAVING AVG(size) > 15
);

--14 What is the total quantity of fertilizers available?
SELECT SUM(quantity) AS Total_Fertilizers
FROM Fertilizers
JOIN Items ON Fertilizers.it_id = Items.Id;

--15 What is the total amount each customer has spent after a 10% discount?
SELECT Cust_id, SUM(amount * 0.9) AS Total_Amount_After_Discount 
FROM Payment 
GROUP BY Cust_id;

--16 Show me the names of plants along with their habitat locations.
SELECT p.name, h.location 
FROM plants p JOIN Conditions c ON p.name = c.plant_name JOIN Habitat h ON c.cond_Nb = h.cond_Nb;

--17 Which customers have not made any purchases?
SELECT c.name 
FROM Customers c 
WHERE NOT EXISTS (SELECT * 
                    FROM purchase 
                    WHERE Cust_id = c.Cust_id);

--18 Can you list the names of plants along with any associated diseases, if applicable?
SELECT p.name, d.disease 
FROM plants p LEFT OUTER JOIN Disease d ON p.name = d.plantName 
WHERE d.disease IS NOT NULL;

--19  Who are the agriculture experts, and how many customers does each expert have?
SELECT AE.name AS Expert_Name, COUNT(C.Expert_id) AS Customer_Count
FROM [Agriculture Expert] AE
LEFT JOIN Customers C ON AE.Exp_id = C.Expert_id
GROUP BY AE.name;

--20  Which plants should be planted during the fall season according to the planting calendar?
SELECT PC.plant_name, PC.planting_time
FROM [Planting Calendar] PC
WHERE blooming_time ='Fall';









