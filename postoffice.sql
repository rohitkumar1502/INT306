create database postoffice;
use postoffice;
create table post_office(
  office_id varchar(5) primary key,
  address varchar(50) not null,
  province varchar(5) not null
);
insert into post_office(office_id, address, province) values
 ('1', 'Dholi', 'SAK'),
 ('2', 'Bishanpur', 'MUZ'),
 ('3', 'Muzaffarpur', 'PUSA'),
 ('4', 'Susta', 'SAK'),
 ('5', 'Samastipur', 'MUZ');
 select *from post_office;
 
 create table post_employee(
  emp_id varchar(5) primary key,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  role varchar(15) check(role in ('carrier', 'clerk', 'postmaster')) not null,
  dayoff date,
  phone_number varchar(15) not null,
  email varchar(50) not null,
  salary int not null

);
insert into post_employee (emp_id, first_name, last_name, role, dayoff, phone_number, email,salary) values
('1', 'Monu', 'Kumar', 'carrier', null, '+916393639677', 'monukumar@lpu.in',45000),
 ('2', 'Sonu', 'Kumar', 'postmaster', null, '+913579466784', 'sonukumar@lpu.in',30000),
 ('3', 'Rohit', 'Kumar', 'carrier', null, '+912077193100', 'monukumar@lpu.in',43000),
 ('4', 'Ankit', 'Kuamr', 'postmaster', null, '+912811072178', 'anitkumar@lpu.in',32000),
('5', 'Abhishek', 'kumar', 'carrier', null, '+912161686721', 'abhishekkumar@lpu.in',31000),
 ('6', 'Aarti', 'Choudhary', 'carrier', null, '+912543465293', 'aartichoudhary@lpu.in',41000),
 ('7', 'Harsh', 'Raj', 'clerk', null, '+919199198140', 'harshraj@lpu.in',33000),
('8', 'Sumit', 'Kumar', 'postmaster', null, '+918681294366', 'sumitkumar@lpu.in',51000),
 ('9', 'Maahi', 'Shivhare', 'carrier', null, '+918496097120', 'maahishivhare@lpu.in',44000),
('10', 'Akansh', 'Agrwal', 'postmaster', null, '+918887825177', 'akanshagrwal2lpu.in',45000);
select *from post_employee;

create table office_room(
  office_id varchar(5) references post_office(office_id),
  emp_id varchar(5) references post_employee(emp_id),
  room_number varchar(4) not null,
  PRIMARY KEY(office_id, emp_id)
);
insert into office_room (office_id, emp_id, room_number) values 
('1', '1', '101'),
('1', '2', '102'),
('2', '3', '201'),
('2', '4', '201'),
('3', '5', '301'),
('3', '6', '302'),
('4', '7', '401'),
('4', '8', '402'),
('5', '9', '501'),
('5', '10', '502');
select *from office_room;
create table schedule(
  schedule_id varchar(5) primary key,
  start_time date NOT NULL,
  end_time date,
  emp_id varchar(5) references post_employee(emp_id),
  office_id varchar(5) references post_office(office_id)
);
insert into schedule (schedule_id, start_time, end_time, emp_id, office_id) values 
('1', sysdate(), null, '1', '1'),
('2', sysdate(), null, '2', '2'),
('3', sysdate(), null, '5', '3'),
('4', sysdate(), null, '6', '4'),
('5', sysdate(), null, '9', '5');
select *from schedule;
create table vehicle(
  vehicle_id varchar(5) primary key,
  plate_number varchar(10) not null unique,
  status varchar(15) check(status in ('in use', 'available', 'decommissioned')) not null,
  office_id varchar(5) references post_office(office_id),
  schedule_id varchar(5) references schedule(schedule_id)
);
insert into vehicle (vehicle_id, plate_number, status, office_id, schedule_id) values 
('101', 'fc9 3ce', 'available', '1', '1'),
('102', '087 b9a', 'available', '2', '3'),
('103', 'adf 630', 'available', '4', '4'),
('104', '2f6 161', 'available', '3', '5'),
('105', 'c2f 945', 'decommissioned', '1', null),
('106', 'd3f 945', 'decommissioned', '2', null),
('107', 'e4f 945', 'decommissioned', '3', null),
('108', 'f5f 945', 'decommissioned', '4', null),
('109', 'g6f 945', 'decommissioned', '5', null);
select *from vehicle;
create table route(
  route_id varchar(5) primary key,
  name varchar(50) not null,
  last_delivery date,
  status varchar(15) check(status in('not started', 'started', 'finished')) not null,
  schedule_id varchar(5) references schedule(schedule_id)
);
insert into route (route_id, name, last_delivery, status, schedule_id) values 
('1', 'Sakra Pusa Road', null, 'not started', '1'),
('2', 'NH-28 Muzaffarpur Samastipur Road 2', null, 'not started', '2'),
('3', 'Muzaffarpur bhagwanpur road ', null, 'not started', '3'),
('4', 'Village maniyaari kajienda', null, 'not started', '4'),
('5', 'Muzaffarpur Samastipur Road 3', null, 'not started', '5'),
('6', 'Sakra Pusa Road', null, 'not started', '1'),
('7', 'NH-28 Muzaffarpur Samastipur Road', null, 'not started', '2'),
('8', 'Muzaffarpur main road', null, 'not started', '3'),
('9', 'Village maniyaari', null, 'not started', '4'),
('10', 'Muzaffarpur Samastipur Road', null, 'not started', '5');
select *from route;

create table postal_code(
 code varchar(7) primary key,
 province varchar(50) not null,
 city varchar(50) not null,
 route_id varchar(5) references route(route_id)
);

insert into postal_code (code, province, city, route_id) values 
('843105', 'SAK', 'Sakra', '1'),
('843102', 'SAK', 'Sakra', '1'),
('843106', 'SAK', 'Sakra', '2'),
('843111', 'SAK', 'Sakra', '2'),
('843101', 'SAK', 'Sakra', '1'),
('843104', 'SAK', 'Sakra', '2'),
('842001', 'MUZ', 'Muzaffarpur', '3'),
('842005', 'MUZ', 'Muzaffarpur', '3'),
('842002', 'MUZ', 'Muzaffarpur', '4'),
('842011', 'MUZ', 'Muzaffarpur', '4'),
('842004', 'MUZ', 'Muzaffarpur', '3'),
('842006', 'MUZ', 'Muzaffarpur', '4'),
('843001', 'PUSA', 'Pusa', '5'),
('843004', 'PUSA', 'Pusa', '5'),
('843005', 'PUSA', 'Pusa', '6'),
('843009', 'PUSA', 'Pusa', '6'),
('843002', 'PUSA', 'Pusa', '5'),
('843007', 'PUSA', 'Pusa', '6'),
('842012', 'SAK', 'Muzaffarpur', '7'),
('842022', 'SAK', 'Muzaffarpur', '7'),
('842009', 'SAK', 'Muzaffarpur', '8'),
('842014', 'SAK', 'Muzaffarpur', '8'),
('842016', 'SAK', 'Muzaffarpur', '7'),
('842015', 'SAK', 'Muzaffarpur', '8'),
('842019', 'SAK', 'Muzaffarpur', '8'),
('842020', 'SAK', 'Muzaffarpur', '8'),
('533001', 'MUZ', 'Maniyaari', '9'),
('533004', 'MUZ', 'Maniyaari', '9'),
('533009', 'MUZ', 'Maniyaari', '10'),
('533008', 'MUZ', 'Maniyaari', '10'),
('533002', 'MUZ', 'Maniyaari', '9'),
('533005', 'MUZ', 'Maniyaari', '10'),
('533011', 'MUZ', 'Maniyaari', '10'),
('533012', 'MUZ', 'Maniyaari', '10');
select *from postal_code;
create table registeredMail(
  mail_id varchar(5) primary key,
  weight decimal(6,2) not null,
  postage decimal(5,2) not null,
  status varchar(25) not null,
  delivery_address varchar(150) not null,
  return_address varchar(150) not null,
  delivery_country varchar(150) not null,
  delivery_code varchar(7) references postal_code(code),
  return_code varchar(7) references postal_code(code)
);
insert into registeredmail (mail_id, weight, postage, status, delivery_address, return_address, delivery_country, delivery_code, return_code) values 
('1', 0.25, 1.00, 'waiting', '58 nehru place', '757 damu Road', 'India', '843105', '842014'),
('2', 0.25, 2.25, 'waiting', '7 kachhi pakki', '94 Ramsey Park road',  'India', '843102', '842009' ),
('3', 15.00, 3.43, 'waiting', '805 ramnagar sanjay kirana', 'word no 7 bhagnagri ', 'India', '843106', '842022'),
('4', 96.00, 1.25, 'waiting', '52 kalmbag road', '70 jubni hill', 'India', '843111', '842012'),
('5', 5.12, 1.00, 'waiting', '2 sakra samastipur rod', '834 muzaffarpur', 'India', '843101', '843007'),
('6', 6.98, 1.00, 'waiting', '7 Faridawad up', '6 nehru place delhi', 'India', '843104', '843002'),
('7', 111.11, 1.00, 'waiting', '45 sabha muzaffarpur ', '6 muzaffarpur samastipur road', 'India', '842001', '843009'),
('8', 192.50, 82.00, 'waiting', '913 sehan vaishali', '34720 vaishali hajipur road', 'India', '842005', '843005'),
('9', 0.80, 0.85, 'waiting', '0 samsung Service center', '41 Golden temple', 'India', '842002', '843004'),
('10', 0.80, 0.85, 'waiting', '6 gopalpur bhagnagri', '011 motijhill muzaffarpur', 'India', '842011', '843001');
select *from registeredmail;
create table unregisteredMail(
  mail_id varchar(5) primary key,
  weight decimal(6,2) not null,
  postage decimal(5,2) not null,
  status varchar(25) not null,
  delivery_address varchar(150) not null,
  return_address varchar(150),
  delivery_country varchar(150) not null,
  delivery_code varchar(7) references postal_code(code),
  return_code varchar(7)
);
insert into unregisteredmail (mail_id, weight, postage, status, delivery_address, return_address, delivery_country, delivery_code, return_code) values 
('1', 501.00, 6.00, 'waiting', '3677 Farrukhabad UP', 'Shree Neelkanth Mandir, Rajbansi Nagar, Patna', 'India', '533012', null),
('2', 1000.00, 0.85, 'waiting', '9 New Sachiwalaya, Desh Ratna Marg, Rajbansi Nagar', 'Maa Sweets, Gaushala Road, Mushari, Muzaffarpur', 'India', '842016', null),
('3', 23.89, 0.85, 'waiting', 'Old Secretariat, Rajbansi Nagar, Patna, Bihar', 'B. S. Furniture, Gaushala Road, Mushari, Muzaffarpur', 'India', '842015', null),
('4', 241.20, 0.85, 'waiting', 'Office of Director General of Police Bihar, Rajbansi Nagar', 'Tridev Auto Part, Gaushala Road, Mushari, Muzaffarpur', 'India', '842019', null),
('5', 25.25, 0.85, 'waiting', 'Eco Park, Deshratna Marg, Rajbansi Nagar, Patna', 'Goodwill Agencies, Gaushala Road, Mushari, Muzaffarpur', 'India', '842020', null),
('6', 26.12, 0.85, 'waiting', ' Patna Junction', 'State Bank of India-Bihar Vidhan Mandal, Rajbansi Nagar', 'India', '533001', null),
('7', 277.95, 3.50, 'waiting', 'Aryabhatta Coaching Centre, Gaushala Road, Mushari, Muzaffarpur', 'Gupta Homeopathic, Gaushala Road, Mushari, Muzaffarpur', 'India', '533004', null),
('8', 28.33, 0.85, 'waiting', '1 Post Office-Patna Secretariat, Rajbansi Nagar, Patna', 'Manoj Repairing Centre, Gaushala Road, Mushari, Muzaffarpur', 'India', '533009', null),
('9', 29.29, 0.85, 'waiting', '4 Minority Welfare Department Bihar Patna, Rajbansi Naga', 'Deepak Book Stationary, Gaushala Road, Mushari, Muzaffarpur', 'India', '533009', null),
('10', 30.00, 0.85, 'waiting', 'Vishwa Barati Coaching Centre & Academy, Gaushala Road, Mushari, Muzaffarpur', 'Menu Restaurant, Strand Road, Rajbansi Nagar, Patna', 'India', '533008', null);
select *from unregisteredmail;

create table users(
  aadhaar_no varchar(12) primary key,
  u_f_name varchar(10) not null,
  u_l_name varchar(10),
  u_email_id varchar(30) not null,
  u_address varchar(50) not null,
  phone varchar(13) not null,
  emp_id varchar(5) not null references post_employee(emp_id)
  
);
insert into users (aadhaar_no, u_f_name, u_l_name, u_email_id, u_address, phone, emp_id) values
('123456789121','Aakash','Kumar','aakashkumar@gmail.com','Patna','+912323232321','8'),
('123456789122','Aayush','Bhardwaj','aayushbhardwaj@gmail.com','Patna','+912323232322','10'),
('123456789123','Ankita','Kumari','ankitakumari@gmail.com','Patna','+912323232323','2'),
('123456789124','Tarun','','tarun@gmail.com','haryana','+912323232324','4'),
('123456789125','tanmay','Bansal','tanmaybansal@gmail.com','Jalandhar','+912323232325','8'),
('123456789126','Nikhil','Vij','nikhilvij@gmail.com','Ludhiana','+912323232326','10'),
('123456789127','Ashok','','ashok@gmail.com','Rajasthan','+912323232327','8'),
('123456789128','Harsh','mahawar','harshmahawar@gmail.com','MP','+912323232328','4'),
('123456789129','Nakesh','Kose','nakeshkose@gmail.com','MP','+912323232329','2'),
('123456789130','Neelabh','Nagle','neelabhnagle@gmail.com','MP','+912323232330','10');
select *from users;
create table transaction (
amount varchar(255) null,
transaction_id varchar(6) primary key,
start_time_to_tran date not null,
aadhaar_no varchar(12) not null references post_users(aadhaar_no)
);
insert into transaction (amount, transaction_id, start_time_to_tran, aadhaar_no) values
('200', 'A2341', sysdate(), '123456789121'),
('2030', 'A2342', sysdate(), '123456789122'),
('453', 'A2343', sysdate(), '123456789122'),
('290', 'A2344', sysdate(), '123456789121'),
('100', 'A2345', sysdate(), '123456789123'),
('250', 'A2346', sysdate(), '123456789123'),
('106', 'A2347', sysdate(), '123456789124'),
('258', 'A2348', sysdate(), '123456789125'),
('240', 'A2349', sysdate(), '123456789126'),
('250', 'A2350', sysdate(), '123456789127'),
('200', 'A2351', sysdate(), '123456789128'),
('240', 'A2352', sysdate(), '123456789129'),
('230', 'A2353', sysdate(), '123456789130');
select *from transaction;



