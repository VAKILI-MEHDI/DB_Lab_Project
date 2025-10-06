
update Cases.[case] 
set status ='Closed'

TRUNCATE TABLE Cases.Appeal;
TRUNCATE TABLE Cases.Judgment;
TRUNCATE TABLE CourtManagement.[Session];
TRUNCATE TABLE Cases.LawyerAssignment;
TRUNCATE TABLE Cases.Party;
TRUNCATE TABLE Cases.Document;
TRUNCATE TABLE Cases.CaseHistory;

TRUNCATE TABLE People.Defendant;
TRUNCATE TABLE People.PersonEmail;
TRUNCATE TABLE People.PersonPhone;

DELETE FROM Cases.[Case];
DELETE FROM People.Judge;
DELETE FROM People.Lawyer;
DELETE FROM CourtManagement.Court;
DELETE FROM People.Person;
DBCC CHECKIDENT ('Cases.[Case]', RESEED, 0);
DBCC CHECKIDENT ('People.Judge', RESEED, 0);
DBCC CHECKIDENT ('People.Lawyer', RESEED, 0);
DBCC CHECKIDENT ('People.Person', RESEED, 0);
DBCC CHECKIDENT ('CourtManagement.Court', RESEED, 0);

INSERT INTO CourtManagement.Court (name, location, phone)
VALUES
('Tehran General Court', 'Imam Khomeini Square, Tehran', '02166778899'),
('Tehran Criminal Court', 'Valiasr Street, Tehran', '02188776655'),
('Isfahan Civil Court', 'Chaharbagh Street, Isfahan', '03144556677'),
('Shiraz Family Court', 'Mellat Park, Shiraz', '07111223344'),
('Mashhad Commercial Court', 'Vakilabad Blvd, Mashhad', '05133445566'),
('Tabriz Administrative Court', 'Shariati Street, Tabriz', '04155667788'),
('Karaj Criminal Court', 'Mehrshahr District, Karaj', '02677889900'),
('Qom Special Court', 'Jameh Mosque Area, Qom', '02566778899');



INSERT INTO People.Person (first_name, last_name, birth_date, gender, national_id, address)
VALUES
('Seyed', 'Rahimi', '1980-12-12', 'Male', '1212121212', 'Tehran, Hakimiyeh St'),
('Roya', 'Kamali', '1989-05-05', 'Female', '2323232323', 'Isfahan, Shahid Montazeri St'),
('Iman', 'Soltani', '1984-04-15', 'Male', '3434343434', 'Mashhad, Shahid Hemmati St'),
('Fatemeh', 'Nasseri', '1985-09-01', 'Female', '4545454545', 'Shiraz, Shahid Bahonar St'),
('Arman', 'Karami', '1987-06-20', 'Male', '5656565656', 'Tehran, Shahid Madani St'),
('Saba', 'Motamedi', '1982-02-10', 'Female', '6767676767', 'Isfahan, Shahid Motahhari St'),
('Nima', 'Rabbani', '1988-10-25', 'Male', '7878787878', 'Mashhad, Shahid Kazemi St'),
('Sahar', 'Khosravi', '1986-11-05', 'Female', '8989898989', 'Tehran, Shahid Ashrafi St'),
('Reyhaneh', 'Zarei', '1983-07-18', 'Female', '9090909090', 'Isfahan, Shahid Fakhr St'),
('Amir', 'Sedghi', '1981-05-30', 'Male', '0101010101', 'Mashhad, Shahid Rezaei St'),
('Mahdi', 'Rahimi', '1995-01-10', 'Male', '1111111111', 'Tehran, Shahid Rajai St'),
('Marjan', 'Zandi', '1990-03-05', 'Female', '2222222222', 'Isfahan, Shahid Rajaee St'),
('Navid', 'Soleimani', '1988-09-12', 'Male', '3333333333', 'Ahvaz, Shahid Montazeri St'),
('Parisa', 'Ebrahimi', '1992-06-20', 'Female', '4444444444', 'Tehran, Shahid Emami St'),
('Arash', 'Mirzaei', '1991-04-15', 'Male', '5555545555', 'Shiraz, Shahid Mofatteh St'),
('Elham', 'Jafari', '1993-02-28', 'Female', '6666666677', 'Tehran, Shahid Forouhar St'),
('Soroush', 'Rostami', '1989-08-10', 'Male', '7777777777', 'Isfahan, Shahid Salimi St'),
('Maedeh', 'Rostami', '1994-05-05', 'Female', '8988888899', 'Tehran, Shahid Khalkhali St'),
('Pooyan', 'Shojaei', '1996-12-25', 'Male', '9999999999', 'Mashhad, Shahid Ahmadi St'),
('Niloofar', 'Taghavi', '1991-11-11', 'Female', '0000000000', 'Tehran, Shahid Sherafat St'),
('Hamed', 'Zamani', '1993-07-07', 'Male', '1111111112', 'Isfahan, Shahid Haghani St'),
('Sahand', 'Tehrani', '1990-10-10', 'Male', '2222222223', 'Tehran, Shahid Sattari St'),
('Shiva', 'Jalali', '1992-04-04', 'Female', '3333333334', 'Tehran, Shahid Heydari St'),
('Fariba', 'Ziaei', '1994-06-18', 'Female', '4444454444', 'Isfahan, Shahid Nouri St'),
('Salar', 'Hashemi', '1995-09-09', 'Male', '5555555555', 'Ahvaz, Shahid Abbasi St'),
('Mitra', 'Farhang', '1990-03-15', 'Female', '6666666666', 'Tehran, Shahid Bahrami St'),
('Siamak', 'Mansouri', '1988-02-20', 'Male', '6677777777', 'Shiraz, Shahid Davari St'),
('Fereshte', 'Maleki', '1991-01-01', 'Female', '889999988', 'Tehran, Shahid Ansari St'),
('Mohammad', 'Zabihi', '1993-04-10', 'Male', '9999099999', 'Mashhad, Shahid Ghanbari St'),
('Sana', 'Talebi', '1996-08-15', 'Female', '0000010000', 'Isfahan, Shahid Rahimi St'),
('Milad', 'Ranjbar', '1992-05-05', 'Male', '1212121213', 'Tehran, Shahid Vatan St'),
('Somayeh', 'Askari', '1994-07-20', 'Female', '2323232322', 'Tehran, Shahid Sardari St'),
('Hadi', 'Khosravi', '1991-06-30', 'Male', '3434343431', 'Isfahan, Shahid Bagheri St'),
('Soraya', 'Saeedi', '1993-03-10', 'Female', '4545454541', 'Tehran, Shahid Eftekhari St'),
('Ruhollah', 'Moghadam', '1989-09-19', 'Male', '5656565651', 'Mashhad, Shahid Nikan St'),
('Roya', 'Danesh', '1995-12-12', 'Female', '6767676761', 'Isfahan, Shahid Karimi St'),
('Fatemeh', 'Sharifi', '1990-11-11', 'Female', '7878787871', 'Tehran, Shahid Akbar St'),
('Morteza', 'Zamani', '1987-02-02', 'Male', '8989898981','Tabriz, Shahid Mahdavi St'),
('Saba', 'Najafi', '1994-10-10', 'Female', '9090909091', 'Tehran, Shahid Jafari St'),
('Mostafa', 'Tehrani', '1985-08-08', 'Male', '0101010102', 'Mashhad, Shahid Borhani St'),
('Sima', 'Ghanbari', '1996-04-04', 'Female', '1212121214', 'Isfahan, Shahid Shaker St'),
('Amir', 'Saberi', '1983-01-01', 'Male', '2323232321', 'Tehran, Shahid Sadri St'),
('Negar', 'Fard', '1991-07-07', 'Female', '3434343432', 'Tehran, Shahid Nozar St'),
('Soroush', 'Zare', '1989-09-09', 'Male', '4545454542', 'Shiraz, Shahid Pirooz St'),
('Fatemeh', 'Sharifi', '1992-06-06', 'Female', '5656565652', 'Tehran, Shahid Mohammadi St'),
('Arman', 'Karami', '1995-03-03', 'Male', '6767676762', 'Mashhad, Shahid Asgari St'),
('Saba', 'Motamedi', '1990-05-05', 'Female', '7878787872', 'Isfahan, Shahid Farahani St'),
('Nima', 'Rabbani', '1988-02-02', 'Male', '8989898982', 'Tehran, Shahid Javad St'),
('Sahel', 'Nikfar', '1986-04-18', 'Male', '9090909092', 'Shiraz, Shahid Nemat St'),
('Ramin', 'Khorshidi', '1984-07-07', 'Male', '0101010103', 'Tehran, Shahid Parvizi St'),
('Zohreh', 'Salehi', '1993-11-11', 'Female', '1212121215', 'Isfahan, Shahid Amir St'),
('Alireza', 'Taheri', '1980-10-10', 'Male', '2323232324', 'Mashhad, Shahid Yusefi St'),
('Maedeh', 'Rostami', '1994-01-01', 'Female', '3434343433', 'Tehran, Shahid Danesh St'),
('Pooyan', 'Shojaei', '1987-09-09', 'Male', '4545454543', 'Isfahan, Shahid Nouri St'),
('Niloofar', 'Taghavi', '1991-08-08', 'Female', '5656565653', 'Tehran, Shahid Bahador St'),
('Hamed', 'Zamani', '1989-03-03', 'Male', '6767676763', 'Mashhad, Shahid Tavakkoli St'),
('Sajad', 'Safarnejad', '1992-02-02', 'Male', '7878787873', 'Tehran, Shahid Pourhashemi St'),
('Sahand', 'Tehrani', '1990-12-12', 'Male', '8989898983', 'Isfahan, Shahid Javadi St'),
('Shiva', 'Jalali', '1996-06-06', 'Female', '9090909093', 'Tehran, Shahid Kashani St'),
('Fariba', 'Ziaei', '1993-05-05', 'Female', '0101010104', 'Isfahan, Shahid Amiri St'),
('Salar', 'Hashemi', '1988-04-04', 'Male', '1212121216', 'Ahvaz, Shahid Gholami St'),
('Mitra', 'Farhang', '1995-02-02', 'Female', '2323232325', 'Tehran, Shahid Soltani St'),
('Siamak', 'Mansouri', '1986-01-01', 'Male', '3434343435', 'Tehran, Shahid Kamali St'),
('Fereshte', 'Maleki', '1991-09-09', 'Female', '4545454544', 'Isfahan, Shahid Roozbeh St'),
('Mohammad', 'Zabihi', '1984-07-07', 'Male', '5656565654', 'Mashhad, Shahid Jafari St'),
('Sana', 'Talebi', '1992-03-03', 'Female', '6767676764', 'Tehran, Shahid Rezaei St'),
('Milad', 'Ranjbar', '1990-11-11', 'Male', '7878787874', 'Isfahan, Shahid Amini St'),
('Somayeh', 'Askari', '1994-10-10', 'Female', '8989898984', 'Tehran, Shahid Esfandi St'),
('Hadi', 'Khosravi', '1987-08-08', 'Male', '9090909094', 'Shiraz, Shahid Shokri St'),
('Soraya', 'Saeedi', '1993-02-02', 'Female', '0101010105', 'Tehran, Shahid Maleki St'),
('Ruhollah', 'Moghadam', '1989-12-12', 'Male', '1212121217', 'Mashhad, Shahid Shahriari St'),
('Roya', 'Danesh', '1995-05-05', 'Female', '2323232326', 'Isfahan, Shahid Hashemi St'),
('Fatemeh', 'Sharifi', '1990-09-09', 'Female', '3434343436', 'Tehran, Shahid Dehghani St'),
('Morteza', 'Zamani', '1985-04-04', 'Male', '4545454546', 'Tabriz, Shahid Mirzaei St'),
('Saba', 'Najafi', '1996-10-10', 'Female', '5656565655', 'Tehran, Shahid Bahrami St'),
('Mostafa', 'Tehrani', '1983-03-03', 'Male', '6767676765', 'Mashhad, Shahid Salehi St'),
('Sima', 'Ghanbari', '1991-07-07', 'Female', '7878787875', 'Isfahan, Shahid Davari St'),
('Amir', 'Saberi', '1989-01-01', 'Male', '8989898985', 'Tehran, Shahid Saeedi St'),
('Negar', 'Fard', '1994-11-11', 'Female', '9090909095', 'Tehran, Shahid Kermani St'),
('Soroush', 'Zare', '1988-08-08', 'Male', '0101010106', 'Isfahan, Shahid Shirazi St'),
('Fatemeh', 'Sharifi', '1992-04-04', 'Female', '1212121218', 'Tehran, Shahid Alizadeh St'),
('Morteza', 'Zamani', '1987-02-02', 'Male', '2323232327', 'Mashhad, Shahid Khorsandi St'),
('Saba', 'Najafi', '1995-10-10', 'Female', '3434343437', 'Tehran, Shahid Zahedi St'),
('Mostafa', 'Tehrani', '1984-08-08', 'Male', '4545454548', 'Isfahan, Shahid Davari St'),
('Sima', 'Ghanbari', '1993-06-06', 'Female', '5656565657', 'Tehran, Shahid Golbaf St'),
('Amir', 'Saberi', '1981-01-01', 'Male', '6767676766', 'Tehran, Shahid Shams St'),
('Negar', 'Fard', '1996-12-12', 'Female', '7878787876', 'Isfahan, Shahid Bahador St'),
('Soroush', 'Zare', '1989-09-09', 'Male', '8989898986', 'Mashhad, Shahid Nikbin St'),
('Fatemeh', 'Sharifi', '1991-07-07', 'Female', '9090909096', 'Tehran, Shahid Kian St'),
('Mohsen', 'Norouzi', '1985-05-05', 'Male', '0101010107', 'Isfahan, Shahid Parsa St'),
('Nima', 'Abasi', '1990-10-10', 'Male', '1212121219', 'Tehran, Shahid Shariatmadari St'),
('Taraneh', 'Bazargan', '1988-11-11', 'Female', '2323232328', 'Tehran, Shahid Dadashi St'),
('Kaveh', 'Moradi', '1986-03-03', 'Male', '3434343438', 'Mashhad, Shahid Mehrabi St'),
('Maryam', 'Fatemie', '1988-09-10', 'Female', '2233445566', 'Tehran, Taleghani Ave'),
('Masoud', 'Ghasemi', '1984-11-03', 'Male', '3344556677', 'Isfahan, Chamran St'),
('Navid', 'Soleimani', '1989-04-20', 'Male', '4455667788', 'Mashhad, Ferdowsi St'),
('Simin', 'Safavi', '1987-07-15', 'Female', '5566778899', 'Shiraz, Daryan St'),
('Payam', 'Faraji', '1982-01-01', 'Male', '6677889900', 'Tehran, Shahrak Ghods'),
('Ladan', 'Ramezani', '1985-03-10', 'Female', '7788990011', 'Qom, Shahid Chamran St'),
('Omid', 'Sadeghi', '1980-10-10', 'Male', '8899001122', 'Tabriz, Khalilabad St'),
('Kaveh', 'Moradi', '1983-05-05', 'Male', '9900112233', 'Tehran, Vanak St'),
('Fereshteh', 'Rouhani', '1986-12-20', 'Female', '0011223344', 'Mashhad, Sabzevar St'),
('Mohammad', 'Rezaei', '1980-05-15', 'Male', '1234567890', 'Tehran, Enghelab St'),
('Fatemeh', 'Mohammadi', '1985-08-22', 'Female', '2345678901', 'Isfahan, Imam St'),
('Ali', 'Karimi', '1975-03-10', 'Male', '3456789012', 'Mashhad, Vakilabad Blvd'),
('Narges', 'Hosseini', '1990-11-30', 'Female', '4567890123', 'Shiraz, Zand St'),
('Reza', 'Ahmadi', '1982-07-18', 'Male', '5678901234', 'Tabriz, Imam St'),
('Ahmad', 'Moradi', '1983-04-12', 'Male', '6789012345', 'Karaj, Danesh Blvd');


INSERT INTO People.PersonPhone (person_id, phone_number)
VALUES
(1, '09123456789'),
(2, '09129876543'),
(3, '09351234567'),
(4, '09107654321'),
(5, '09011223344'),
(6, '09112233445'),
(7, '09334455667'),
(8, '09123344556'),
(9, '09334455668'),
(10, '09123450987'),
(11, '09105556677'),
(12, '09123434343'),
(13, '09124567890'),
(14, '09125678901'),
(15, '09126789012'),
(16, '09127890123'),
(17, '09128901234'),
(18, '09120101010'),
(19, '09121112233'),
(20, '09122223344'),
(21, '09123334455'),
(22, '09124445566'),
(23, '09125556677'),
(24, '09126667788'),
(25, '09127778899'),
(26, '09128889900'),
(27, '09129990011'),
(28, '09120001220'),
(29, '09121112234'),
(30, '09122223345'),
(31, '09123334456'),
(32, '09123334467'),
(33, '09125556678'),
(34, '09126667789'),
(35, '09127778900'),
(36, '09128889901'),
(37, '09129990012'),
(38, '09120001221'),
(39, '09121112235'),
(40, '09122223346'),
(41, '09123334457'),
(42, '09123334468'),
(43, '09125556679'),
(44, '09126667790'),
(45, '09127778901'),
(46, '09128889902'),
(47, '09129990013'),
(48, '09120001222'),
(49, '09121112236'),
(50, '09122223347'),
(51, '09123334458'),
(52, '09123334469'),
(53, '09125556680'),
(54, '09126667791'),
(55, '09127778902'),
(56, '09128889903'),
(57, '09129990014'),
(58, '09120001223'),
(59, '09121112237'),
(60, '09122223348'),
(61, '09123334459'),
(62, '09123334470'),
(63, '09125556681'),
(64, '09126667792'),
(65, '09127778903'),
(66, '09128889904'),
(67, '09129990015'),
(68, '09120001224'),
(69, '09121112238'),
(70, '09122223349'),
(71, '09123334460'),
(72, '09123334468'),
(73, '09125556682'),
(74, '09126667793'),
(75, '09127778904'),
(76, '09128889905'),
(77, '09129990016'),
(78, '09120001225'),
(79, '09121112239'),
(80, '09122223350'),
(81, '09123334461'),
(82, '09123334469'),
(83, '09125556683'),
(84, '09126667794'),
(85, '09127778905'),
(86, '09128889906'),
(87, '09129990017'),
(88, '09120001226'),
(89, '09121112240'),
(90, '09122223351'),
(91, '09123334462'),
(92, '09123334470'),
(93, '09125556684'),
(94, '09126667795'),
(95, '09127778906'),
(96, '09128889907'),
(97, '09129990018'),
(98, '09120001227'),
(99, '09121112241'),
(100, '09122223352');

-- Insert emails into PersonEmail
INSERT INTO People.PersonEmail (person_id, email)
VALUES
(1, 'seyed.rahimi@example.com'),
(2, 'roya.kamali@example.com'),
(3, 'iman.soltani@example.com'),
(4, 'fatemeh.nasseri@example.com'),
(5, 'arman.karami@example.com'),
(6, 'saba2.motamedi@example.com'),
(7, 'n.rabbani@example.com'),
(8, 'sahar.khosravi@example.com'),
(9, 'reyhaneh.zarei@example.com'),
(10, 'amir.sedghi@example.com'),
(11, 'mahdi.rahimi@example.com'),
(12, 'marjan.zandi@example.com'),
(13, 'navid.soleimani@example.com'),
(14, 'parisa.ebrahimi@example.com'),
(15, 'arash.mirzaei@example.com'),
(16, 'elham.jafari@example.com'),
(17, 'soroush.rostami@example.com'),
(18, 'maedeh.rostami@example.com'),
(19, 'pooyan.shojaei@example.com'),
(20, 'n.taghavi@example.com'),
(21, 'hamed.zamani@example.com'),
(22, 'sahand.tehrani@example.com'),
(23, 'shiva.jalali@example.com'),
(24, 'fariba.ziaei@example.com'),
(25, 'salar.hashemi@example.com'),
(26, 'mitra.farhang@example.com'),
(27, 'siamak.mansouri@example.com'),
(28, 'fereshte.maleki@example.com'),
(29, 'mohammad.zabihi@example.com'),
(30, 'sana.talebi@example.com'),
(31, 'milad.ranjbar@example.com'),
(32, 'somayeh.askari@example.com'),
(33, 'hadi.khosravi@example.com'),
(34, 'soraya.saeedi@example.com'),
(35, 'ruhollah.moghadam@example.com'),
(36, 'roya.danesh@example.com'),
(37, 'fatemeh.sharifi@example.com'),
(38, 'morteza.zamani@example.com'),
(39, 'saba.najafi@example.com'),
(40, 'mostafa.tehrani@example.com'),
(41, 'sima.ghanbari@example.com'),
(42, 'amir.saberi@example.com'),
(43, 'negar.fard@example.com'),
(44, 'soroush.zare@example.com'),
(45, 'f.sharifi@example.com'),
(46, 'a.karami@example.com'),
(47, 'saba.motamedi@example.com'),
(48, 'nima.rabbani@example.com'),
(49, 'sahel.nikfar@example.com'),
(50, 'ramin.khorshidi@example.com'),
(51, 'zohreh.salehi@example.com'),
(52, 'alireza.taheri@example.com'),
(53, 'm.rostami@example.com'),
(54, 'p.shojaei@example.com'),
(55, 'niloofar.taghavi@example.com'),
(56, 'h.zamani@example.com'),
(57, 'sajad.safarnejad@example.com'),
(58, 's.tehrani@example.com'),
(59, 'sh.jalali@example.com'),
(60, 'f.ziaei@example.com'),
(61, 's.hashemi@example.com'),
(62, 'm.farhang@example.com'),
(63, 'si.mansouri@example.com'),
(64, 'f.maleki@example.com'),
(65, 'm.zabihi@example.com'),
(66, 's.talebi@example.com'),
(67, 'm.ranjbar@example.com'),
(68, 'som.askari@example.com'),
(69, 'h.khosravi@example.com'),
(70, 's.saeedi@example.com'),
(71, 'rooollah.moghadam@example.com'),
(72, 'r.danesh@example.com'),
(73, 'fate.sharifi@example.com'),
(74, 'm.zamani@example.com'),
(75, 's.najafi@example.com'),
(76, 'm.tehrani@example.com'),
(77, 's.ghanbari@example.com'),
(78, 'amir2.saberi@example.com'),
(79, 'n.fard@example.com'),
(80, 's.zare@example.com'),
(81, 'fatemeh2.sharifi@example.com'),
(82, 'mohsen.norouzi@example.com'),
(83, 'nima.abasi@example.com'),
(84, 'taraneh.bazargan@example.com'),
(85, 'kaveh.moradi@example.com'),
(86, 'maryam.fatemie@example.com'),
(87, 'masoud.ghasemi@example.com'),
(88, 'n.soleimani@example.com'),
(89, 'simin.safavi@example.com'),
(90, 'payam.faraji@example.com'),
(91, 'ladan.ramezani@example.com'),
(92, 'omid.sadeghi@example.com'),
(93, 'k.moradi@example.com'),
(94, 'fereshteh.rouhani@example.com'),
(95, 'mohammad.rezaei@example.com'),
(96, 'fateme.mohammadi@example.com'),
(97, 'ali.karimi@example.com'),
(98, 'narges.hosseini@example.com'),
(99, 'reza.ahmadi@example.com'),
(100, 'ahmad.moradi@example.com');


INSERT INTO People.Judge 
    (person_id, license_number, start_date, specialization, rank, court_id, is_active)
VALUES
    (1, 'J10001', '2010-01-15', 'Criminal Law', 'Senior Judge', 1, 1),
    (2, 'J10002', '2016-03-20', 'Civil Law', 'Judge', 2, 1),
    (3, 'J10003', '2013-07-10', 'Family Law', 'Chief Judge', 3, 0),
    (4, 'J10004', '2018-09-05', 'Commercial Law', 'Judge', 4, 1),
    (5, 'J10005', '2013-11-12', 'Constitutional Law', 'Senior Judge', 5, 1),
    (6, 'J10006', '2017-05-25', 'Financial Law', 'Judge', 6, 1),
    (7, 'J10007', '2019-02-14', 'Administrative Law', 'Judge', 7, 1),
    (8, 'J10008', '2015-04-30', 'Criminal Law', 'Judge', 1, 1),
    (9, 'J10009', '2016-08-17', 'Civil Law', 'Judge', 2, 1),
    (10,'J10010', '2012-12-01', 'Family Law', 'Chief Judge', 3, 1);


INSERT INTO People.Lawyer 
    (person_id, license_number, issue_date, status, specializstion)
VALUES
    (11, 'L20001', '2017-01-10', 'Active', 'Criminal Law'),
    (12, 'L20002', '2018-03-15', 'Active', 'Civil Law'),
    (13, 'L20003', '2016-05-20', 'Active', 'Family Law'),
    (14, 'L20004', '2019-07-01', 'Active', 'Commercial Law'),
    (15, 'L20005', '2014-09-12', 'Suspended', 'Financial Law'),
    (16, 'L20006', '2015-11-30', 'Active', 'Administrative Law'),
    (17, 'L20007', '2020-02-14', 'Active', 'Criminal Law'),
    (18, 'L20008', '2013-04-05', 'Retired', 'Civil Law'),
    (19, 'L20009', '2017-06-18', 'Active', 'Family Law'),
    (20, 'L20010', '2016-08-25', 'Suspended', 'Commercial Law'),
    (21, 'L20011', '2019-10-10', 'Active', 'Constitutional Law'),
    (22, 'L20012', '2015-12-12', 'Active', 'Administrative Law'),
    (23, 'L20013', '2018-01-20', 'Active', 'Criminal Law'),
    (24, 'L20014', '2014-03-05', 'Active', 'Civil Law'),
    (25, 'L20015', '2017-05-15', 'License Revoked', 'Family Law'),
    (26, 'L20016', '2020-07-22', 'Active', 'Commercial Law'),
    (27, 'L20017', '2016-09-30', 'Active', 'Financial Law'),
    (28, 'L20018', '2012-11-11', 'Retired', 'Administrative Law'),
    (29, 'L20019', '2019-02-14', 'Active', 'Criminal Law'),
    (30, 'L20020', '2015-04-05', 'License Revoked', 'Civil Law');

INSERT INTO People.Defendant 
    (person_id, criminal_record, status)
VALUES
    (31, 'Theft, Assault', 'Incarcerated'),
    (32, 'Drug Possession', 'Under Investigation'),
    (33, 'Assault', 'Temporarily Released'),
    (34, NULL, 'Free'),
    (35, 'Theft, Assault', 'Fugitive'),
    (36, 'Assault', 'Temporarily Released'),
    (37, 'Drug Possession', 'Incarcerated'),
    (38, 'Fraud', 'Under Investigation'),
    (39, NULL, 'Temporarily Released'),
    (40, 'Theft', 'Free'),
    (41, 'Embezzlement', 'Incarcerated'),
    (42, 'Possession of illegal items', 'Under Investigation'),
    (43, 'Public Disturbance', 'Temporarily Released'),
    (44, NULL, 'Free'),
    (45, 'Theft', 'Fugitive'),
    (46, 'Drug Possession', 'Incarcerated'),
    (47, 'Assault', 'Under Investigation'),
    (48, 'Theft', 'Temporarily Released'),
    (49, 'Possession of illegal items', 'Free'),
    (50, 'Fraud', 'Incarcerated'),
    (51, 'Drug Possession', 'Under Investigation'),
    (52, 'Assault', 'Temporarily Released'),
    (53, 'Fraud', 'Free'),
    (54, 'Theft', 'Fugitive'),
    (55, 'Drug Possession', 'Incarcerated'),
    (56, 'Assault', 'Under Investigation'),
    (57, 'Theft', 'Temporarily Released'),
    (58, 'Fraud', 'Free'),
    (59, 'Drug Possession', 'Incarcerated'),
    (60, 'Assault', 'Under Investigation'),
    (61, 'Theft', 'Temporarily Released'),
    (62, 'Drug Possession', 'Free'),
    (63, 'Fraud', 'Fugitive'),
    (64, 'Theft', 'Incarcerated'),
    (65, 'Drug Possession', 'Under Investigation'),
    (66, 'Assault', 'Temporarily Released'),
    (67, 'Fraud', 'Free'),
    (68, 'Theft', 'Fugitive'),
    (69, 'Drug Possession', 'Incarcerated'),
    (70, 'Assault', 'Under Investigation');


INSERT INTO Cases.[Case]
    (case_number, title, register_date, case_type, status, court_id, judge_id, description, priority)
VALUES
    -- Criminal Cases
    ('CA-001', 'Theft Case - Mohammad Rezaei vs Unknown', '2020-01-10', 'Criminal', 'In Progress', 1, 1, 'Accused of theft in Tehran', 'Urgent'),
    ('CA-002', 'Drug Possession - Sara Kazemi', '2021-03-05', 'Criminal', 'Under Review', 2, NULL, 'Narcotics investigation', 'Normal'),
    ('CA-003', 'Assault and Battery - Ali Ahmadi', '2019-07-20', 'Criminal', 'Verdict Pending', 3, 4, 'Physical assault in public place', 'Emergency'),
    ('CA-004', 'Fraud Case - Amin Sayedi', '2020-09-15', 'Criminal', 'Closed', 4, 4, 'Financial fraud charges', 'Normal'),
    ('CA-005', 'Armed Robbery - Hossein Rahimi', '2022-05-12', 'Criminal', 'In Progress', 5, 5, 'Robbery with firearm', 'Urgent'),

    -- Civil Cases
    ('CA-006', 'Contract Dispute - Maryam Fatemie', '2021-02-28', 'Civil', 'In Progress', 6, 6, 'Dispute over business contract', 'Normal'),
    ('CA-007', 'Property Dispute - Farhad Najafi', '2020-11-10', 'Civil', 'Under Review', 7, NULL, 'Land ownership dispute', 'Normal'),
    ('CA-008', 'Debt Recovery - Payam Faraji', '2019-09-05', 'Civil', 'Suspended', 1, 7, 'Unpaid loan recovery', 'Normal'),
    ('CA-009', 'Employment Issue - Samira Shaghaghi', '2022-01-15', 'Civil', 'In Progress', 2, 8, 'Wrongful termination claim', 'Urgent'),
    ('CA-010', 'Tenant Eviction - Leila Karimi', '2021-05-20', 'Civil', 'Closed', 3, 9, 'Eviction due to unpaid rent', 'Normal'),

    -- Family Cases
    ('CA-011', 'Divorce Request - Saeed Alavi', '2021-04-18', 'Family', 'Under Review', 4, 10, 'Mutual divorce request', 'Normal'),
    ('CA-012', 'Child Custody - Neda Asghari', '2020-08-01', 'Family', 'In Progress', 5, 1, 'Post-divorce custody dispute', 'Urgent'),
    ('CA-013', 'Alimony Claim - Behrooz Bahrami', '2019-06-12', 'Family', 'Under Review', 6, 2, 'Unpaid alimony claim', 'Normal'),
    ('CA-014', 'Marriage Contract Validation', '2022-02-22', 'Family', 'In Progress', 7, 2, 'Challenge on marriage validity', 'Normal'),
    ('CA-015', 'Adoption Request - Fatemeh Khani', '2021-10-30', 'Family', 'Under Review', 1, 4, 'Legal adoption process', 'Urgent'),

    -- Financial Cases
    ('CA-016', 'Bank Fraud Investigation', '2020-05-15', 'Financial', 'Under Review', 2, 5, 'Suspicious transaction report', 'Normal'),
    ('CA-017', 'Tax Evasion - Masoud Ghasemi', '2021-07-01', 'Financial', 'In Progress', 3, 6, 'Unreported income for tax', 'Urgent'),
    ('CA-018', 'Loan Default - Navid Soleimani', '2019-12-10', 'Financial', 'Closed', 4, 7, 'Loan repayment failure', 'Normal'),
    ('CA-019', 'Money Laundering - Simin Safavi', '2022-03-25', 'Financial', 'Under Review', 5, 8, 'Suspicion of illegal fund transfer', 'Emergency'),
    ('CA-020', 'Credit Card Fraud - Pooyan Shojaei', '2020-11-05', 'Financial', 'In Progress', 6, 9, 'Unauthorized card usage', 'Urgent'),

    -- Administrative Cases
    ('CA-021', 'License Revocation Appeal', '2021-09-12', 'Administrative', 'Under Appeal', 7, 10, 'Appeal against license cancellation', 'Normal'),
    ('CA-022', 'Municipal Permit Denial', '2022-01-20', 'Administrative', 'In Progress', 1, 1, 'Building permit denied', 'Urgent'),
    ('CA-023', 'Government Tender Dispute', '2020-06-08', 'Administrative', 'Under Review', 2, 2, 'Bid evaluation complaint', 'Normal'),
    ('CA-024', 'Public Service Complaint', '2021-04-17', 'Administrative', 'In Progress', 3, 5, 'Complaint against service delay', 'Normal'),
    ('CA-025', 'Traffic Penalty Challenge', '2022-02-14', 'Administrative', 'Under Review', 4, 4, 'Challenging traffic fines', 'Urgent'),

    -- Commercial Cases
    ('CA-026', 'Trademark Infringement', '2020-03-10', 'Commercial', 'In Progress', 5, 5, 'Brand name duplication', 'Urgent'),
    ('CA-027', 'Breach of Partnership Agreement', '2021-05-05', 'Commercial', 'Under Review', 6, 6, 'Violation of partnership terms', 'Normal'),
    ('CA-028', 'Business Dissolution - Amir Bagheri', '2019-10-18', 'Commercial', 'Closed', 7, 7, 'Company liquidation request', 'Normal'),
    ('CA-029', 'Franchise Dispute - Sanaz Khalili', '2022-04-01', 'Commercial', 'In Progress', 1, 8, 'Franchise agreement breach', 'Urgent'),
    ('CA-030', 'Unfair Competition - Babak Niknam', '2021-08-10', 'Commercial', 'Under Review', 2, 9, 'Marketing competition issues', 'Normal'),

    -- Constitutional Cases
    ('CA-031', 'Constitutional Rights Violation', '2020-09-12', 'Constitutional', 'Under Review', 3, 10, 'Violation of constitutional rights', 'Normal'),
    ('CA-032', 'Freedom of Speech - Narges Noori', '2021-06-05', 'Constitutional', 'Under Review', 4, NULL, 'Restrictions on free speech', 'Sensitive'),
    ('CA-033', 'Right to Protest - Davood Gholami', '2022-01-25', 'Constitutional', 'In Progress', 5, 1, 'Illegal protest ban', 'Emergency'),
    ('CA-034', 'Voting Rights - Fereshteh Rouhani', '2019-05-30', 'Constitutional', 'Under Review', 6, 2, 'Denied right to vote', 'Normal'),
    ('CA-035', 'Privacy Rights - Shahab Zarei', '2020-12-15', 'Constitutional', 'Under Review', 7, 6, 'Data privacy violation', 'Urgent'),

    -- Criminal Cases (More)
    ('CA-036', 'Vehicle Theft - Mostafa Tehrani', '2021-03-11', 'Criminal', 'In Progress', 1, 4, 'Car theft by organized group', 'Urgent'),
    ('CA-037', 'Domestic Violence - Marjan Zandi', '2022-06-20', 'Criminal', 'In Progress', 2, 5, 'Spousal abuse case', 'Emergency'),
    ('CA-038', 'Smuggling - Kaveh Moradi', '2019-11-05', 'Criminal', 'Under Review', 3, 6, 'Customs smuggling', 'Normal'),
    ('CA-039', 'Cyber Crime - Soraya Saeedi', '2020-04-18', 'Criminal', 'In Progress', 4, 7, 'Online identity theft', 'Urgent'),
    ('CA-040', 'Weapons Possession - Ruhollah Moghadam', '2021-09-22', 'Criminal', 'Under Review', 5, 8, 'Unlicensed weapons found', 'Emergency'),

    -- Civil Cases (More)
    ('CA-041', 'Personal Injury - Roya Danesh', '2022-05-10', 'Civil', 'In Progress', 6, 9, 'Road accident compensation', 'Urgent'),
    ('CA-042', 'Medical Malpractice - Soroush Zare', '2020-02-14', 'Civil', 'Closed', 7, 10, 'Improper treatment claim', 'Normal'),
    ('CA-043', 'Defamation - Zahra Amjadi', '2021-08-05', 'Civil', 'Under Review', 1, NULL, 'Online defamation via social media', 'Normal'),
    ('CA-044', 'Real Estate Dispute - Hamed Zamani', '2019-12-25', 'Civil', 'In Progress', 2, 1, 'Land boundary conflict', 'Urgent'),
    ('CA-045', 'Consumer Rights - Niloofar Taghavi', '2022-03-18', 'Civil', 'Under Review', 3, 2, 'Faulty product refund issue', 'Normal'),

    -- Family & Financial
    ('CA-046', 'Inheritance Dispute - Mahdi Rahimi', '2020-07-01', 'Family', 'Under Review', 4, 7, 'Heirship disagreement', 'Normal'),
    ('CA-047', 'Spousal Support - Negar Fard', '2021-01-10', 'Family', 'In Progress', 5, 4, 'Failure to pay spousal support', 'Urgent'),
    ('CA-048', 'Embezzlement - Mohammad Zabihi', '2022-02-05', 'Financial', 'In Progress', 6, 5, 'Misuse of company funds', 'Emergency'),
    ('CA-049', 'Check Bounce - Sana Talebi', '2019-04-12', 'Financial', 'Closed', 7, 6, 'Unpaid check from client', 'Normal'),
    ('CA-050', 'Tax Dispute - Milad Ranjbar', '2020-10-18', 'Financial', 'Under Review', 1, 7, 'Dispute with Tax Office', 'Urgent');

INSERT INTO Cases.Party (case_id, person_id, role)
VALUES-- Case 1
(1, 31, 'Defendant'),
(1, 76, 'Plaintiff'),
-- Case 2
(2, 72, 'Plaintiff'),
(2, 56, 'Defendant'),
-- Case 3
(3, 75, 'Plaintiff'),
(3, 44, 'Defendant'),
-- Case 4
(4, 90, 'Plaintiff'),
(4, 60, 'Defendant'),
-- Case 5
(5, 75, 'Plaintiff'),
(5, 60, 'Defendant'),
-- Case 6
(6, 76, 'Defendant'),
(6, 80, 'Witness'), -- Witness
(6, 10, 'Victim'),
-- Case 7
(7, 83, 'Plaintiff'),
(7, 54, 'Defendant'),
(7, 91, 'Expert'), -- Expert-- Case 8
(8, 86, 'Plaintiff'),
(8, 48, 'Defendant'),
(8, 19, 'Legal_Guardian'),
-- Case 9
(9, 34, 'Defendant'),
(9, 97, 'Victim'),
(9, 78, 'Plaintiff'),
-- Case 10
(10, 88, 'Plaintiff'),
(10, 46, 'Defendant'),
(10, 80, 'Witness'),
-- Case 11
(11, 52, 'Defendant'),
(11, 94, 'Expert'),
(11, 73, 'Legal_Guardian'),
-- Case 12
(12, 96, 'Plaintiff'),
(12, 68, 'Defendant'),
(12, 77, 'Representative'), -- Representative-- Case 13
(13, 74, 'Plaintiff'),
(13, 66, 'Defendant'),
(13, 75, 'Victim'),
-- Case 14
(14, 38, 'Defendant'),
(14, 84, 'Legal_Guardian'),
(14, 85, 'Witness');
-- Case 15
EXEC Cases.sp_InsertParty @case_id = 15, @person_id = 72, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 15, @person_id = 77, @role = 'Representative';
-- Case 16
EXEC Cases.sp_InsertParty @case_id = 16, @person_id = 86, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 16, @person_id = 59, @role = 'Defendant';
-- Case 17
EXEC Cases.sp_InsertParty @case_id = 17, @person_id = 71, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 17, @person_id = 62, @role = 'Defendant';
-- Case 18
EXEC Cases.sp_InsertParty @case_id = 18, @person_id = 83, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 18, @person_id = 35, @role = 'Defendant';
-- Case 19
EXEC Cases.sp_InsertParty @case_id = 19, @person_id = 85, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 19, @person_id = 58, @role = 'Defendant';
-- Case 20
EXEC Cases.sp_InsertParty @case_id = 20, @person_id = 78, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 20, @person_id = 62, @role = 'Defendant';
-- Case 21
EXEC Cases.sp_InsertParty @case_id = 21, @person_id = 87, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 21, @person_id = 36, @role = 'Defendant';
-- Case 22
EXEC Cases.sp_InsertParty @case_id = 22, @person_id = 93, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 22, @person_id = 40, @role = 'Defendant';
-- Case 23
EXEC Cases.sp_InsertParty @case_id = 23, @person_id = 97, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 23, @person_id = 44, @role = 'Defendant';
-- Case 24
EXEC Cases.sp_InsertParty @case_id = 24, @person_id = 76, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 24, @person_id = 48, @role = 'Defendant';
-- Case 25
EXEC Cases.sp_InsertParty @case_id = 25, @person_id = 79, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 25, @person_id = 52, @role = 'Defendant';
-- Case 26
EXEC Cases.sp_InsertParty @case_id = 26, @person_id = 81, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 26, @person_id = 56, @role = 'Defendant';
-- Case 27
EXEC Cases.sp_InsertParty @case_id = 27, @person_id = 88, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 27, @person_id = 60, @role = 'Defendant';
-- Case 28
EXEC Cases.sp_InsertParty @case_id = 28, @person_id = 82, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 28, @person_id = 64, @role = 'Defendant';
-- Case 29
EXEC Cases.sp_InsertParty @case_id = 29, @person_id = 83, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 29, @person_id = 68, @role = 'Defendant';
-- Case 30
EXEC Cases.sp_InsertParty @case_id = 30, @person_id = 75, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 30, @person_id = 32, @role = 'Defendant';
-- Case 31
EXEC Cases.sp_InsertParty @case_id = 31, @person_id = 74, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 31, @person_id = 76, @role = 'Defendant';
-- Case 32
EXEC Cases.sp_InsertParty @case_id = 32, @person_id = 78, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 32, @person_id = 48, @role = 'Defendant';
-- Case 33
EXEC Cases.sp_InsertParty @case_id = 33, @person_id = 82, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 33, @person_id = 44, @role = 'Defendant';
-- Case 34
EXEC Cases.sp_InsertParty @case_id = 34, @person_id = 86, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 34, @person_id = 38, @role = 'Defendant';
-- Case 35
EXEC Cases.sp_InsertParty @case_id = 35, @person_id = 90, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 35, @person_id = 45, @role = 'Defendant';
-- Case 36
EXEC Cases.sp_InsertParty @case_id = 36, @person_id = 94, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 36, @person_id = 46, @role = 'Defendant';
-- Case 37
EXEC Cases.sp_InsertParty @case_id = 37, @person_id = 98, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 37, @person_id = 50, @role = 'Defendant';
-- Case 38
EXEC Cases.sp_InsertParty @case_id = 38, @person_id = 79, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 38, @person_id = 54, @role = 'Defendant';
-- Case 39
EXEC Cases.sp_InsertParty @case_id = 39, @person_id = 83, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 39, @person_id = 68, @role = 'Defendant';
-- Case 40
EXEC Cases.sp_InsertParty @case_id = 40, @person_id = 84, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 40, @person_id = 52, @role = 'Defendant';
-- Case 41
EXEC Cases.sp_InsertParty @case_id = 41, @person_id = 85, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 41, @person_id = 46, @role = 'Defendant';
-- Case 42
EXEC Cases.sp_InsertParty @case_id = 42, @person_id = 75, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 42, @person_id = 60, @role = 'Defendant';
-- Case 43
EXEC Cases.sp_InsertParty @case_id = 43, @person_id = 77, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 43, @person_id = 41, @role = 'Defendant';
-- Case 44
EXEC Cases.sp_InsertParty @case_id = 44, @person_id = 99, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 44, @person_id = 47, @role = 'Defendant';
-- Case 45
EXEC Cases.sp_InsertParty @case_id = 45, @person_id = 95, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 45, @person_id = 57, @role = 'Defendant';
-- Case 46
EXEC Cases.sp_InsertParty @case_id = 46, @person_id = 95, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 46, @person_id = 65, @role = 'Defendant';
-- Case 47
EXEC Cases.sp_InsertParty @case_id = 47, @person_id = 76, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 47, @person_id = 75, @role = 'Defendant';
-- Case 48
EXEC Cases.sp_InsertParty @case_id = 48, @person_id = 92, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 48, @person_id = 31, @role = 'Defendant';
-- Case 49
EXEC Cases.sp_InsertParty @case_id = 49, @person_id = 97, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 49, @person_id = 36, @role = 'Defendant';
-- Case 50
EXEC Cases.sp_InsertParty @case_id = 50, @person_id = 100, @role = 'Plaintiff';
EXEC Cases.sp_InsertParty @case_id = 50, @person_id = 67, @role = 'Defendant';


INSERT INTO Cases.LawyerAssignment (case_id, lawyer_id, client_id, start_date, end_date, role)
VALUES-- Case 1
(1, 1, 76, '2023-01-06', NULL, 'Plaintiff_Lawyer'),
(1, 4, 31, '2023-01-07', NULL, 'Defendant_Lawyer'),
-- Case 2
(2, 7, 72, '2023-01-11', NULL, 'Plaintiff_Lawyer'),
(2, 6, 56, '2023-01-12', NULL, 'Defendant_Lawyer'),
-- Case 3
(3, 11, 75, '2023-01-16', NULL, 'Plaintiff_Lawyer'),
(3, 2, 44, '2023-01-17', NULL, 'Defendant_Lawyer'),
-- Case 4
(4, 3, 90, '2023-01-21', NULL, 'Plaintiff_Lawyer'),
(4, 4, 60, '2023-01-22', NULL, 'Defendant_Lawyer'),
-- Case 5
(5, 7, 75, '2023-02-02', NULL, 'Plaintiff_Lawyer'),
(5, 6, 60, '2023-02-03', NULL, 'Defendant_Lawyer'),
-- Case 6
(6, 7, 8, '2023-02-11', NULL, 'Defendant_Lawyer'),
(6, 12, 76, '2023-02-11', NULL, 'Plaintiff_Lawyer'),
-- Case 7
(7, 9, 83, '2023-02-16', NULL, 'Plaintiff_Lawyer'),
(7, 13, 54, '2023-02-17', NULL, 'Defendant_Lawyer'),
-- Case 8
(8, 11, 86, '2023-02-21', NULL, 'Plaintiff_Lawyer'),
(8, 12, 48, '2023-02-22', NULL, 'Defendant_Lawyer'),
-- Case 9
(9, 13, 34, '2023-03-02', NULL, 'Defendant_Lawyer'),
(9, 14, 78, '2023-03-02', NULL, 'Plaintiff_Lawyer'),
-- Case 10
(10, 17, 88, '2023-03-06', NULL, 'Plaintiff_Lawyer'),
(10, 16, 46, '2023-03-07', NULL, 'Defendant_Lawyer'),
-- Case 11
(11, 1, 52, '2023-03-10', NULL, 'Plaintiff_Lawyer'),
(11, 2, 73, '2023-03-11', NULL, 'Defendant_Lawyer'),
-- Case 12
(12, 3, 96, '2023-03-15', NULL, 'Plaintiff_Lawyer'),
(12, 4, 68, '2023-03-16', NULL, 'Defendant_Lawyer'),
-- Case 13
(13, 7, 74, '2023-03-20', NULL, 'Plaintiff_Lawyer'),
(13, 6, 66, '2023-03-21', NULL, 'Defendant_Lawyer'),
-- Case 14
(14, 7, 38, '2023-03-25', NULL, 'Defendant_Lawyer'),
(14, 12, 84, '2023-03-26', NULL, 'Plaintiff_Lawyer'),
-- Case 15
(15, 9, 72, '2023-03-30', NULL, 'Plaintiff_Lawyer'),
-- Case 16
(16, 11, 86, '2023-04-05', NULL, 'Plaintiff_Lawyer'),
(16, 12, 59, '2023-04-06', NULL, 'Defendant_Lawyer'),
-- Case 17
(17, 13, 62, '2023-04-10', NULL, 'Defendant_Lawyer'),
(17, 14, 71, '2023-04-11', NULL, 'Plaintiff_Lawyer'),
-- Case 18
(18, 17, 83, '2023-04-15', NULL, 'Plaintiff_Lawyer'),
(18, 16, 35, '2023-04-16', NULL, 'Defendant_Lawyer'),
-- Case 19
(19, 17, 85, '2023-04-20', NULL, 'Plaintiff_Lawyer'),
(19, 19, 58, '2023-04-21', NULL, 'Defendant_Lawyer'),
-- Case 20
(20, 19, 78, '2023-04-25', NULL, 'Plaintiff_Lawyer'),
(20, 3, 62, '2023-04-26', NULL, 'Defendant_Lawyer'),
-- Case 21
(21, 1, 87, '2023-05-01', NULL, 'Plaintiff_Lawyer'),
(21, 2, 36, '2023-05-02', NULL, 'Defendant_Lawyer'),
-- Case 22
(22, 3, 93, '2023-05-06', NULL, 'Plaintiff_Lawyer'),
(22, 4, 40, '2023-05-07', NULL, 'Defendant_Lawyer'),
-- Case 23
(23, 4, 97, '2023-05-11', NULL, 'Plaintiff_Lawyer'),
(23, 6, 44, '2023-05-12', NULL, 'Defendant_Lawyer'),
-- Case 24
(24, 7, 76, '2023-05-16', NULL, 'Defendant_Lawyer'),
(24, 12, 48, '2023-05-17', NULL, 'Plaintiff_Lawyer'),
-- Case 25
(25, 9, 79, '2023-05-21', NULL, 'Plaintiff_Lawyer'),
(25, 13, 52, '2023-05-22', NULL, 'Defendant_Lawyer'),
-- Case 26
(26, 11, 81, '2023-05-26', NULL, 'Plaintiff_Lawyer'),
(26, 12, 56, '2023-05-27', NULL, 'Defendant_Lawyer'),
-- Case 27
(27, 13, 60, '2023-05-27', NULL, 'Defendant_Lawyer'),
(27, 14, 88, '2023-05-28', NULL, 'Plaintiff_Lawyer'),
-- Case 28
(28, 17, 82, '2023-05-28', NULL, 'Plaintiff_Lawyer'),
(28, 16, 64, '2023-05-29', NULL, 'Defendant_Lawyer'),
-- Case 29
(29, 17, 83, '2023-05-29', NULL, 'Plaintiff_Lawyer'),
(29, 19, 68, '2023-05-30', NULL, 'Defendant_Lawyer'),
-- Case 30
(30, 19, 75, '2023-05-30', NULL, 'Plaintiff_Lawyer'),
(30, 3, 32, '2023-05-30', NULL, 'Defendant_Lawyer');


INSERT INTO CourtManagement.[Session] 
    ( case_id, court_id, session_date, start_time, end_time, notes, is_completed)
VALUES-- Case 1
(1, 1, '2023-04-10', '09:00:00', '10:00:00', 'Initial hearing', 1),
(1, 1, '2023-04-17', '11:00:00', '12:00:00', 'Evidence review', 1),
-- Case 2
(2, 2, '2023-04-12', '10:00:00', '11:00:00', 'Hearing with plaintiff', 1),
(2, 2, '2023-04-19', '14:00:00', '15:00:00', 'Witness testimonies', 1),
-- Case 3
(3, 3, '2023-04-14', '09:30:00', '10:30:00', 'Preliminary investigation', 1),
(3, 3, '2023-04-21', '11:00:00', '12:00:00', 'Defendant statement', 1),
(3, 3, '2023-04-28', '13:00:00', '14:00:00', 'Final ruling discussion', 0),
-- Case 4
(4, 4, '2023-04-16', '09:00:00', '10:00:00', 'First session', 1),
(4, 4, '2023-04-23', '10:00:00', '11:00:00', 'Legal argument submission', 1),
-- Case 5
(5, 5, '2023-04-18', '09:00:00', '10:00:00', 'Case introduction', 1),
(5, 5, '2023-04-25', '11:00:00', '12:00:00', 'Evidence presentation', 1),
(5, 5, '2023-05-01', '14:00:00', '15:00:00', 'Verdict preparation', 0),
-- Case 6
(6, 6, '2023-04-20', '10:00:00', '11:00:00', 'Opening arguments', 1),
-- Case 7
(7, 7, '2023-04-22', '09:00:00', '10:00:00', 'Preliminary hearing', 1),
(7, 7, '2023-04-29', '11:00:00', '12:00:00', 'Evidence collection', 1),
-- Case 8
(8, 1, '2023-04-24', '09:00:00', '10:00:00', 'Initial meeting', 1),
(8, 1, '2023-04-30', '10:00:00', '11:00:00', 'Cross-examination', 1),
(8, 1, '2023-05-07', '14:00:00', '15:00:00', 'Final verdict discussion', 0),
-- Case 9
(9, 2, '2023-04-26', '09:00:00', '10:00:00', 'Case overview', 1),
(9, 2, '2023-05-02', '11:00:00', '12:00:00', 'Plaintiff testimony', 1),
-- Case 10
(10, 3, '2023-04-28', '10:00:00', '11:00:00', 'Opening statements', 1),
(10, 3, '2023-05-04', '13:00:00', '14:00:00', 'Defendant cross-exam', 1),
(10, 3, '2023-05-11', '15:00:00', '16:00:00', 'Closing arguments', 0),
-- Case 11
(11, 4, '2023-05-01', '09:00:00', '10:00:00', 'Preliminary hearing', 1),
-- Case 12
(12, 5, '2023-05-03', '11:00:00', '12:00:00', 'Case registration', 1),
(12, 5, '2023-05-10', '14:00:00', '15:00:00', 'Document verification', 1),
-- Case 13
(13, 6, '2023-05-05', '10:00:00', '11:00:00', 'Opening of proceedings', 1),
(13, 6, '2023-05-12', '11:00:00', '12:00:00', 'Witnesses testifying', 1),
-- Case 14
(14, 7, '2023-05-07', '09:00:00', '10:00:00', 'Case evaluation', 1),
(14, 7, '2023-05-14', '10:00:00', '11:00:00', 'Legal analysis', 1),
(14, 7, '2023-05-21', '14:00:00', '15:00:00', 'Final decision', 0),
-- Case 15
(15, 1, '2023-05-09', '09:00:00', '10:00:00', 'Hearing #1', 1),
(15, 1, '2023-05-16', '11:00:00', '12:00:00', 'Hearing #2', 1),
-- Case 16
(16, 2, '2023-05-11', '10:00:00', '11:00:00', 'Initial Hearing', 1),
(16, 2, '2023-05-18', '13:00:00', '14:00:00', 'Review of evidence', 1),
-- Case 17
(17, 3, '2023-05-13', '09:00:00', '10:00:00', 'Introductory session', 1),
(17, 3, '2023-05-20', '11:00:00', '12:00:00', 'Legal arguments', 1),
(17, 3, '2023-05-27', '14:00:00', '15:00:00', 'Final deliberation', 0),
-- Case 18
(18, 4, '2023-05-15', '10:00:00', '11:00:00', 'Hearing #1', 1),
(18, 4, '2023-05-22', '12:00:00', '13:00:00', 'Hearing #2', 1),
-- Case 19
(19, 5, '2023-05-17', '09:00:00', '10:00:00', 'First session', 1),
(19, 5, '2023-05-24', '11:00:00', '12:00:00', 'Second session', 1),
(19, 5, '2023-06-03', '14:00:00', '15:00:00', 'Third session', 0),
-- Case 20
(20, 6, '2023-05-19', '10:00:00', '11:00:00', 'Opening session', 1),
(20, 6, '2023-05-26', '11:00:00', '12:00:00', 'Evidence examination', 1),
-- Case 21
(21, 7, '2023-05-21', '09:00:00', '10:00:00', 'Case initiation', 1),
(21, 7, '2023-06-02', '11:00:00', '12:00:00', 'Statement recording', 1),
-- Case 22
(22, 1, '2023-05-23', '10:00:00', '11:00:00', 'Preliminary hearing', 1),
(22, 1, '2023-06-04', '13:00:00', '14:00:00', 'Evidence review', 1),
(22, 1, '2023-06-11', '15:00:00', '16:00:00', 'Final verdict', 0),
-- Case 23
(23, 2, '2023-05-25', '09:00:00', '10:00:00', 'Session #1', 1),
(23, 2, '2023-06-06', '11:00:00', '12:00:00', 'Session #2', 1),
-- Case 24
(24, 3, '2023-05-27', '10:00:00', '11:00:00', 'Session for evidence', 1),
(24, 3, '2023-06-08', '12:00:00', '13:00:00', 'Deliberation', 1),
(24, 3, '2023-06-15', '14:00:00', '15:00:00', 'Final ruling', 0),
-- Case 25
(25, 4, '2023-05-28', '09:00:00', '10:00:00', 'First hearing', 1),
(25, 4, '2023-06-10', '11:00:00', '12:00:00', 'Second hearing', 1),
-- Case 26
(26, 5, '2023-06-01', '10:00:00', '11:00:00', 'Preliminary session', 1),
(26, 5, '2023-06-08', '13:00:00', '14:00:00', 'Final hearing', 1),
-- Case 27
(27, 6, '2023-06-03', '09:00:00', '10:00:00', 'Opening of trial', 1),
(27, 6, '2023-06-10', '11:00:00', '12:00:00', 'Evidence collection', 1),
(27, 6, '2023-06-17', '14:00:00', '15:00:00', 'Deliberation', 0),
-- Case 28
(28, 7, '2023-06-05', '10:00:00', '11:00:00', 'Session 1', 1),
(28, 7, '2023-06-12', '12:00:00', '13:00:00', 'Session 2', 1),
-- Case 29
(29, 1, '2023-06-07', '09:00:00', '10:00:00', 'First session', 1),
(29, 1, '2023-06-14', '11:00:00', '12:00:00', 'Second session', 1),
(29, 1, '2023-06-21', '14:00:00', '15:00:00', 'Final session', 0),
-- Case 30
(30, 2, '2023-06-09', '10:00:00', '11:00:00', 'Case opening', 1),
(30, 2, '2023-06-16', '12:00:00', '13:00:00', 'Discussion on documents', 1);


INSERT INTO Cases.Document 
    (case_id, document_type, file_path, uploaded_at, description)
VALUES-- Case 1
(1, 'Medical Certificate', '/documents/case_1_medical_report.pdf', '2023-04-11', 'Medical certificate for plaintiff'),
(1, 'Investigation Report', '/documents/case_1_investigation_summary.docx', '2023-04-18', 'Initial investigation summary'),
-- Case 2
(2, 'Witness Statement', '/documents/case_2_witness_statement.pdf', '2023-04-13', 'Statement of the witness'),
(2, 'Financial Records', '/documents/case_2_financial_records.xlsx', '2023-04-20', 'Accounting documents provided'),
-- Case 3
(3, 'Export Agreement', '/documents/case_3_export_agreement.pdf', '2023-04-15', 'Signed export agreement'),
-- Case 4
(4, 'Lawyer Assignment Order', '/documents/case_4_lawyer_assignment.pdf', '2023-04-17', 'Official lawyer assignment letter'),
(4, 'Personal Documents', '/documents/case_4_personal_documents.zip', '2023-04-24', 'ID and national card copies'),
-- Case 5
(5, 'Trial Request', '/documents/case_5_trial_request.pdf', '2023-04-19', 'Request for formal trial'),
(5, 'Financial Evidence', '/documents/case_5_financial_evidence.xlsx', '2023-04-26', 'Bank records and transactions'),
-- Case 6
(6, 'Court Notes', '/documents/case_6_court_notes.docx', '2023-04-28', 'Official court session notes'),
-- Case 7
(7, 'Expert Report', '/documents/case_7_expert_analysis.pdf', '2023-04-23', 'Analysis by forensic expert'),
(7, 'Contract Copy', '/documents/case_7_contract_review.docx', '2023-04-30', 'Original contract under review'),
-- Case 8
(8, 'Criminal Record', '/documents/case_8_criminal_history.pdf', '2023-04-25', 'Defendant criminal history'),
-- Case 9
(9, 'Reconsideration Request', '/documents/case_9_reconsideration_request.pdf', '2023-04-27', 'Request to reevaluate case'),
(9, 'Bond Letter', '/documents/case_9_bond_letter.pdf', '2023-05-03', 'Monetary bond letter submitted'),
-- Case 10
(10, 'Inspection Report', '/documents/case_10_inspection_report.pdf', '2023-04-29', 'Report on site inspection'),
(10, 'Plaintiff Claim Details', '/documents/case_10_plaintiff_claim.docx', '2023-05-05', 'Claim details from plaintiff'),
-- Case 11
(11, 'Identity Verification', '/documents/case_11_identity_check.pdf', '2023-05-02', 'Identification documents verified'),
-- Case 12
(12, 'Witness Testimony', '/documents/case_12_witness_deposition.pdf', '2023-05-04', 'Deposition of key witness'),
(12, 'Legal Certification', '/documents/case_12_legal_certificate.pdf', '2023-05-10', 'Certified legal opinion'),
-- Case 13
(13, 'Hearing Notice', '/documents/case_13_hearing_notice.pdf', '2023-05-06', 'Notice of scheduled hearing'),
(13, 'Signature Verification', '/documents/case_13_signature_confirmation.docx', '2023-05-12', 'Confirmed document signature'),
-- Case 14
(14, 'Evidence of Right', '/documents/case_14_evidence_of_right.pdf', '2023-05-08', 'Proof of legal right submission'),
(14, 'Objection Rejection', '/documents/case_14_objection_rejection.docx', '2023-05-15', 'Objection rejected by court'),
-- Case 15
(15, 'Title Change Request', '/documents/case_15_title_change_request.docx', '2023-05-17', 'Case title change application'),
-- Case 16
(16, 'Previous Judgments', '/documents/case_16_previous_judgments.pdf', '2023-05-12', 'Judgments from similar cases'),
(16, 'Ownership Document', '/documents/case_16_property_ownership.docx', '2023-05-19', 'Real estate ownership proof'),
-- Case 17
(17, 'Academic Certificate', '/documents/case_17_academic_certificate.pdf', '2023-05-14', 'Certificate used as evidence'),
-- Case 18
(18, 'Detention Order', '/documents/case_18_detention_order.pdf', '2023-05-16', 'Temporary detention order issued'),
(18, 'Disconnection Notice', '/documents/case_18_disconnection_notice.docx', '2023-05-23', 'Service disconnection notice'),
-- Case 19
(19, 'Referral Order', '/documents/case_19_referral_order.pdf', '2023-05-18', 'Order to refer to lab'),
(19, 'Confirmation Letter', '/documents/case_19_confirmation_letter.pdf', '2023-05-25', 'Confirmation from external agency'),
-- Case 20
(20, 'Financial Report', '/documents/case_20_financial_report.xlsx', '2023-05-27', 'Comprehensive financial audit'),
-- Case 21
(21, 'Lawyer Appointment', '/documents/case_21_lawyer_appointment.pdf', '2023-05-22', 'Appointment of legal counsel'),
-- Case 22
(22, 'Diagnosis Report', '/documents/case_22_diagnosis_report.pdf', '2023-05-24', 'Forensic medical diagnosis'),
(22, 'Confession Statement', '/documents/case_22_confession_statement.docx', '2023-06-01', 'Written confession statement'),
-- Case 23
(23, 'Contract Agreement', '/documents/case_23_contract_agreement.pdf', '2023-05-26', 'Mutual agreement signed'),
(23, 'Ownership Documents', '/documents/case_23_property_docs.zip', '2023-06-03', 'Documents proving property ownership'),
-- Case 24
(24, 'Signature Confirmation', '/documents/case_24_signature_confirmation.docx', '2023-06-05', 'Signature authenticity confirmed'),
-- Case 25
(25, 'Violation Report', '/documents/case_25_violation_report.pdf', '2023-06-01', 'Report on legal violations'),
-- Case 26
(26, 'Defendant Statement', '/documents/case_26_defendant_statement.pdf', '2023-06-02', 'Official statement from defendant'),
(26, 'Operational Plan', '/documents/case_26_operation_plan.docx', '2023-06-09', 'Plan for legal operations'),
-- Case 27
(27, 'Connection Proof', '/documents/case_27_connection_proof.pdf', '2023-06-04', 'Digital connection verification'),
(27, 'Investigation Summary', '/documents/case_27_investigation_summary.docx', '2023-06-11', 'Summary of investigation process'),
-- Case 28
(28, 'Judicial Order', '/documents/case_28_judicial_order.pdf', '2023-06-06', 'Final court decision'),
-- Case 30
(30, 'Financial Approval', '/documents/case_30_financial_approval.xlsx', '2023-06-10', 'Financial approval from court'),
(30, 'Operation Permit', '/documents/case_30_operation_permit.pdf', '2023-06-17', 'Permit to proceed with operation');


INSERT INTO Cases.Judgment 
-- Judgment 1 - Case 3
    (case_id, judge_id, issue_date, verdict_text, type, status, appeal_deadline)
VALUES 
    (3, 4, '2023-04-28', 'The defendant is found not guilty.', 'Acquittal', 'Issued', DATEADD(DAY, 10, '2023-04-28')),
-- Judgment 2 - Case 5
    (5, 5, '2023-05-01', 'The plaintiff has been awarded damages.', 'Community_Service', 'Issued', DATEADD(DAY, 10, '2023-05-01')),
-- Judgment 3 - Case 8
    (8, 7, '2023-05-07', 'The case is dismissed due to insufficient evidence.', 'Dismissal', 'Executed', NULL),
-- Judgment 4 - Case 10
    (10, 9, '2023-05-11', 'A fine of $5000 has been issued.', 'Fine', 'Stay of Execution', DATEADD(DAY, 10, '2023-05-11')),
-- Judgment 5 - Case 14
    (14, 2, '2023-05-21', 'Defendant sentenced to probation.', 'Probation', 'Issued', DATEADD(DAY, 10, '2023-05-21')),
-- Judgment 6 - Case 17
    (17, 6, '2023-05-27', 'Plaintiff and Defendant reached a settlement.', 'Dismissal', 'Executed', NULL),
-- Judgment 7 - Case 19
    (19, 8, '2023-06-03', 'Verdict pending further investigation.', 'Custodial_Sentence', 'Issued', DATEADD(DAY, 10, '2023-06-03')),
-- Judgment 8 - Case 22
    (22, 1, '2023-06-11', 'The judgment was overturned on appeal.', 'Acquittal', 'Overturned', DATEADD(DAY, 10, '2023-06-11')),
-- Judgment 9 - Case 24
    (24, 5, '2023-06-15', 'The defendant will serve the sentence under supervision.', 'Probation', 'Issued', DATEADD(DAY, 10, '2023-06-15')),
-- Judgment 10 - Case 27
    (27, 6, '2023-06-17', 'The court ruled in favor of the plaintiff.', 'Community_Service', 'Issued', DATEADD(DAY, 10, '2023-06-17')),
-- Judgment 11 - Case 29
    (29, 8, '2023-06-21', 'The court ruled in favor of the plaintiff.', 'Community_Service', 'Issued', DATEADD(DAY, 10, '2023-06-21'));


INSERT INTO Cases.Appeal 
    (case_id, appeal_date, appeal_reason, status, court_id, result)
VALUES
-- Appeal 1 - Case 3
    (3, '2023-04-30', 'Disagreement with the verdict''s interpretation of evidence.', 'Pending', 3, NULL),
-- Appeal 2 - Case 10
    (10, '2023-05-15', 'The judgment did not consider all witness testimonies.', 'Pending', 3, NULL),
-- Appeal 3 - Case 14
    (14, '2023-05-26', 'Request to review the fine amount imposed by the court.', 'Under Review', 7, 'Appeal accepted. Fine reduced.'),
-- Appeal 4 - Case 19
    (19, '2023-06-05', 'Verdict contradicts legal precedents in similar cases.', 'Accepted', 5, 'Case referred to higher court.'),
-- Appeal 5 - Case 22
    (22, '2023-06-16', 'Defendant believes ruling was biased or incorrect.', 'Rejected', 1, 'Appeal rejected. Original ruling upheld.'),
-- Appeal 6 - Case 24
    (24, '2023-06-20', 'Claim that new evidence was overlooked during trial.', 'Pending', 3, NULL);