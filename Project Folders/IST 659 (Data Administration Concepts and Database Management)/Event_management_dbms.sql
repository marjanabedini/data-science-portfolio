--create DATABASE project
GO
--USE project
GO

-- down foreign keys


if exists(select * from  INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_event_requests_request_approved_client_id')
    Alter table event_requests DROP CONSTRAINT fk_event_requests_request_approved_client_id;
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_locations_locations_client_id')
    Alter table locations DROP CONSTRAINT fk_locations_locations_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_vendors_vendors_invoice_id')
    Alter table vendors DROP CONSTRAINT fk_vendors_vendors_invoice_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_invoices_invoices_vendor_id')
    Alter table invoices DROP CONSTRAINT fk_invoices_invoices_vendor_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_invoices_invoices_client_id')
    Alter table invoices DROP CONSTRAINT fk_invoices_invoices_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_invoices_invoices_payment_id')
    Alter table invoices DROP CONSTRAINT fk_invoices_invoices_payment_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_invoices_invoices_vendor_id')
    Alter table invoices DROP CONSTRAINT fk_invoices_invoices_vendor_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_invoices_invoices_client_id')
    Alter table invoices DROP CONSTRAINT fk_invoices_invoices_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_invoices_invoices_payment_id')
    Alter table invoices DROP CONSTRAINT fk_invoices_invoices_payment_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_events_events_location_id')
    Alter table events DROP CONSTRAINT fk_events_events_location_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_events_events_client_id')
    Alter table events DROP CONSTRAINT fk_events_events_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_events_events_feedback_id')
    Alter table events DROP CONSTRAINT fk_events_events_feedback_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_feedbacks_feedbacks_client_id')
    Alter table feedbacks DROP CONSTRAINT fk_feedbacks_feedbacks_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_feedbacks_feedbacks_event_id')
    Alter table feedbacks DROP CONSTRAINT fk_feedbacks_feedbacks_event_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_feedbacks_feedbacks_staff_id')
    Alter table feedbacks DROP CONSTRAINT fk_feedbacks_feedbacks_staff_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_staff_staff_feedback_id')
    Alter table staff DROP CONSTRAINT fk_staff_staff_feedback_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_clients_clients_location_id')
    Alter table clients DROP CONSTRAINT fk_clients_clients_location_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_clients_clients_invoice_id')
    Alter table clients DROP CONSTRAINT fk_clients_clients_invoice_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_clients_clients_event_id')
    Alter table clients DROP CONSTRAINT fk_clients_clients_event_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_clients_clients_feedback_id')
    Alter table clients DROP CONSTRAINT fk_clients_clients_feedback_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_clients_clients_payment_id')
    Alter table clients DROP CONSTRAINT fk_clients_clients_payment_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_payments_payments_invoice_id')
    Alter table payments DROP CONSTRAINT fk_payments_payments_invoice_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_payment_payments_client_id')
    Alter table payments DROP CONSTRAINT fk_payment_payments_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_locations_vendors_location_id')
    Alter table locations_vendors DROP CONSTRAINT fk_locations_vendors_location_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_locations_vendors_vendor_id')
    Alter table locations_vendors DROP CONSTRAINT fk_locations_vendors_vendor_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_clients_vendors_client_id')
    Alter table clients_vendors DROP CONSTRAINT fk_clients_vendors_client_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_clients_vendors_vendor_id')
    Alter table clients_vendors DROP CONSTRAINT fk_clients_vendors_vendor_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_events_staff_event_id')
    Alter table events_staff DROP CONSTRAINT fk_events_staff_event_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_events_staff_staff_id')
    Alter table events_staff DROP CONSTRAINT fk_events_staff_staff_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_staff_tasks_task_id')
    Alter table staff_tasks DROP CONSTRAINT fk_staff_tasks_task_id
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_staff_tasks_staff_id')
    Alter table staff_tasks DROP CONSTRAINT fk_staff_tasks_staff_id
-- if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_pending_bookings_client_contact_person_first_name')
--     Alter table pending_bookings DROP CONSTRAINT fk_pending_bookings_client_contact_person_first_name
-- if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_approved_bookings_client_contact_person_first_name')
--     Alter table approved_bookings DROP CONSTRAINT fk_approved_bookings_client_contact_person_first_name
-- down tables
DROP TABLE if EXISTS locations
DROP TABLE if EXISTS vendors
DROP TABLE if EXISTS invoices
DROP TABLE if EXISTS events
DROP TABLE if EXISTS feedbacks
DROP TABLE if EXISTS staff
DROP TABLE if EXISTS clients
DROP TABLE if EXISTS payments
DROP TABLE if EXISTS tasks
DROP TABLE if EXISTS locations_vendors
DROP TABLE if EXISTS clients_vendors
DROP TABLE if EXISTS events_staff
DROP TABLE if EXISTS staff_tasks
DROP TABLE if EXISTS event_requests
-- DROP TABLE if EXISTS pending_bookings
-- DROP TABLE if EXISTS approved_bookings

-- up metadata
CREATE TABLE locations(
    location_id INT IDENTITY(1,1),
    city_name VARCHAR(50),
    location_type VARCHAR(50),
    max_occupancy INT Null,
    locations_client_id INT Null,
    CONSTRAINT pk_locations_location_id PRIMARY KEY(location_id)
)
CREATE TABLE vendors(
    vendor_id INT IDENTITY(1,1),
    vendor_first_name VARCHAR(255),
    vendor_last_name VARCHAR(255),
    vendor_contact_person VARCHAR(255),
    vendor_email VARCHAR(100),
    vendor_contact_number char(11),
    vendors_invoice_id INT,
    CONSTRAINT pk_vendors_vendor_id PRIMARY KEY(vendor_id)
)
CREATE TABLE invoices(
    invoice_id INT IDENTITY(1,1),
    invoice_date_issued DATE,
    invoice_status CHAR(10),
    invoices_vendor_id INT,
    invoices_client_id INT,
    invoices_payment_id INT,
    CONSTRAINT pk_invoices_invoice_id PRIMARY KEY(invoice_id)
)
CREATE TABLE events(
    event_id INT IDENTITY(1,1),
    event_date DATE,
    event_type VARCHAR(50),
    event_guest_count INT,
    event_description VARCHAR(255),
    events_location_id INT,
    events_client_id INT,
    events_feedback_id INT,
    CONSTRAINT pk_events_event_id PRIMARY KEY(event_id)
)
CREATE table feedbacks(
    feedback_id INT IDENTITY(1,1),
    feedback_rating INT,
    feedback_comment VARCHAR(255),
    feedbacks_client_id INT,
    feedbacks_event_id INT,
    feedbacks_staff_id INT,
    CONSTRAINT pk_feedbacks_feedback_id PRIMARY KEY(feedback_id) 
)
CREATE TABLE staff(
    staff_id INT IDENTITY(1,1),
    staff_first_name VARCHAR(255),
    staff_last_name VARCHAR(255),
    staff_position VARCHAR(255),
    staff_email VARCHAR(50),
    staff_contact_number INT,
    CONSTRAINT pk_staff_staff_id PRIMARY KEY (staff_id)
)
create TABLE clients(
    client_id INT IDENTITY(1,1),
    client_name VARCHAR(255),
    client_contact_person_first_name VARCHAR(255),
    client_contact_person_last_name VARCHAR(255),
    client_type VARCHAR(255),
    client_email VARCHAR(255),
    client_contact_number INT,
    clients_location_id INT,
    clients_invoice_id INT,
    clients_event_id INT,
    clients_feedback_id INT,
    clients_payment_id INT,
    clients_pending_bookings_id INT,
    CONSTRAINT pk_clients_client_id PRIMARY KEY(client_id)
)
CREATE TABLE payments(
    payment_id INT IDENTITY(1,1),
    payment_amount INT,
    payment_date DATE NULL,
    payment_method CHAR(50) NULL,
    payments_invoice_id INT,
    payments_client_id INT,
    CONSTRAINT pk_payments_payment_id PRIMARY KEY (payment_id)
)
create table tasks(
    task_id INT IDENTITY(1,1),
    task VARCHAR(255),
    CONSTRAINT pk_tasks_task_id PRIMARY KEY(task_id)
)
CREATE TABLE event_requests(
    request_id INT IDENTITY(1,1),
    requesting_client_name VARCHAR(50),
    requesting_client_id INT,
    event_date DATE,
    event_guest_count INT,
    request_approved_client_id INT,
    request_approved_date DATE,
    request_event_description VARCHAR(255),
    CONSTRAINT pk_event_requests_request_id PRIMARY KEY(request_id)
)




CREATE TABLE locations_vendors(
    location_id INT,
    vendor_id INT
)
CREATE TABLE clients_vendors(
    client_id INT,
    vendor_id INT
)
CREATE TABLE events_staff(
    event_id INT,
    staff_id INT
)
CREATE TABLE staff_tasks(
    staff_id INT,
    task_id INT
)
-- for powerapps

-- CREATE TABLE pending_bookings(
--     pending_bookings_id INT,
--     pending_bookings_booking_name VARCHAR(50),
--     pending_bookings_client_contact_person_first_name VARCHAR(255),
--     CONSTRAINT pk_pending_bookings_id PRIMARY KEY (pending_bookings_id)
-- )

-- CREATE TABLE approved_bookings(
--     approved_bookings_booking_name VARCHAR(50), 
--     approved_bookings_client_contact_person_first_name VARCHAR(255),
-- )


-- up foreign keys


ALTER TABLE invoices
    ADD CONSTRAINT fk_invoices_invoices_payment_id FOREIGN KEY (invoices_payment_id)
    REFERENCES payments(payment_id)
GO
ALTER TABLE events
    ADD CONSTRAINT fk_events_events_location_id FOREIGN KEY (events_location_id)
    REFERENCES locations(location_id)
GO
ALTER TABLE events
    ADD CONSTRAINT fk_events_events_client_id FOREIGN KEY (events_client_id)
    REFERENCES clients(client_id)
GO
ALTER TABLE events
    ADD CONSTRAINT fk_events_events_feedback_id FOREIGN KEY (events_feedback_id)
    REFERENCES feedbacks(feedback_id)
GO

ALTER TABLE payments
    ADD CONSTRAINT fk_payment_payments_client_id FOREIGN KEY (payments_client_id)
    REFERENCES clients(client_id)
GO

ALTER TABLE locations_vendors
    ADD CONSTRAINT fk_locations_vendors_location_id FOREIGN KEY (location_id)
    REFERENCES locations(location_id)
GO
ALTER TABLE locations_vendors
    ADD CONSTRAINT fk_locations_vendors_vendor_id FOREIGN KEY (vendor_id)
    REFERENCES vendors(vendor_id)
GO
ALTER TABLE clients_vendors
    ADD CONSTRAINT fk_clients_vendors_client_id FOREIGN KEY (client_id)
    REFERENCES clients(client_id)
GO
ALTER TABLE clients_vendors
    ADD CONSTRAINT fk_clients_vendors_vendor_id FOREIGN KEY (vendor_id)
    REFERENCES vendors(vendor_id)
GO
ALTER TABLE events_staff
    ADD CONSTRAINT fk_events_staff_event_id FOREIGN KEY (event_id)
    REFERENCES events(event_id)
GO
ALTER TABLE events_staff
    ADD CONSTRAINT fk_events_staff_staff_id FOREIGN KEY (staff_id)
    REFERENCES staff(staff_id)
GO
ALTER TABLE staff_tasks
    ADD CONSTRAINT fk_staff_tasks_task_id FOREIGN KEY (task_id)
    REFERENCES tasks(task_id)
GO
ALTER TABLE staff_tasks
    ADD CONSTRAINT fk_staff_tasks_staff_id FOREIGN KEY (staff_id)
    REFERENCES staff(staff_id)
GO
ALTER TABLE event_requests
    ADD CONSTRAINT fk_event_requests_requesting_client_id FOREIGN KEY (requesting_client_id)
    REFERENCES clients(client_id)

ALTER TABLE event_requests
    ADD CONSTRAINT fk_event_requests_request_approved_client_id FOREIGN KEY (request_approved_client_id)
    REFERENCES clients(client_id)


-- for powerapps 
-- ALTER TABLE pending_bookings
--     ADD CONSTRAINT fk_pending_bookings_client_contact_person_first_name FOREIGN KEY (pending_bookings_client_contact_person_first_name)
--     REFERENCES clients(client_contact_person_first_name);


-- ALTER TABLE approved_bookings
--     ADD CONSTRAINT fk_approved_bookings_client_contact_person_first_name FOREIGN KEY (client_contact_person_first_name)
--     REFERENCES clients(pending_bookings_id)
-- GO


--***************************************************************************************************************************************** 
INSERT INTO locations (city_name, location_type, max_occupancy, locations_client_id)
VALUES 
('New York', 'Office', NULL, 253), ('Los Angeles', 'Indoor', 100, NULL), ('Chicago', 'Outdoor', 150, 102), ('Houston', 'Office', NULL, 185), ('Los Angeles', 'Office', NULL, 177),
('Chicago', 'Indoor', 90, NULL), ('New York', 'Outdoor', 110, 165), ('Houston', 'Office', NULL, 132), ('Los Angeles', 'Indoor', 140, NULL), ('Chicago', 'Outdoor', 120, 108),
('New York', 'Office', NULL, 191), ('Houston', 'Indoor', 95, NULL), ('Los Angeles', 'Outdoor', 130, 214), ('Chicago', 'Office', NULL, 176), ('New York', 'Indoor', 110, NULL),
('Houston', 'Outdoor', 150, 267), ('Phoenix', 'Office', NULL, 223), ('Philadelphia', 'Indoor', 120, NULL), ('San Antonio', 'Outdoor', 80, 198), ('San Diego', 'Office', NULL, 154),
('Dallas', 'Indoor', 110, NULL), ('San Jose', 'Outdoor', 140, 143), ('Austin', 'Office', NULL, 201), ('Jacksonville', 'Indoor', 100, NULL), ('Fort Worth', 'Outdoor', 130, 166),
('Columbus', 'Office', NULL, 281), ('Charlotte', 'Indoor', 110, NULL), ('San Francisco', 'Outdoor', 120, 237), ('Indianapolis', 'Office', NULL, 193), ('Seattle', 'Indoor', 90, NULL),
('Denver', 'Outdoor', 110, 214), ('Washington', 'Office', NULL, 189), ('Boston', 'Indoor', 100, NULL), ('El Paso', 'Outdoor', 130, 248), ('Nashville', 'Office', NULL, 147),
('Detroit', 'Indoor', 90, NULL), ('Oklahoma City', 'Outdoor', 110, 182), ('Portland', 'Office', NULL, 269), ('Las Vegas', 'Indoor', 100, NULL), ('Memphis', 'Outdoor', 120, 217),
('Louisville', 'Office', NULL, 178), ('Baltimore', 'Indoor', 90, NULL), ('Milwaukee', 'Outdoor', 110, 202), ('Albuquerque', 'Office', NULL, 233), ('Tucson', 'Indoor', 100, NULL),
('Fresno', 'Outdoor', 120, 159), ('Mesa', 'Office', NULL, 185), ('Sacramento', 'Indoor', 90, NULL), ('Atlanta', 'Outdoor', 110, 223), ('Kansas City', 'Office', NULL, 177),
('Colorado Springs', 'Indoor', 100, NULL), ('Miami', 'Outdoor', 120, 244), ('Raleigh', 'Office', NULL, 191), ('Omaha', 'Indoor', 90, NULL), ('Long Beach', 'Outdoor', 110, 215),
('Virginia Beach', 'Office', NULL, 178), ('Oakland', 'Indoor', 90, NULL), ('Minneapolis', 'Outdoor', 110, 202), ('Tulsa', 'Office', NULL, 159), ('Arlington', 'Indoor', 90, NULL),
('Tampa', 'Outdoor', 110, 227), ('New Orleans', 'Office', NULL, 205), ('Wichita', 'Indoor', 90, NULL), ('Bakersfield', 'Outdoor', 110, 186), ('Cleveland', 'Office', NULL, 172),
('Aurora', 'Indoor', 90, NULL), ('Anaheim', 'Outdoor', 110, 199), ('Honolulu', 'Office', NULL, 156), ('Santa Ana', 'Indoor', 90, NULL), ('Riverside', 'Outdoor', 110, 213);

INSERT INTO clients (client_name, client_contact_person_first_name, client_contact_person_last_name, client_type, client_email, client_contact_number, clients_location_id, clients_invoice_id, clients_event_id, clients_feedback_id, clients_payment_id)
VALUES 
('ABC Corporation', 'John', 'Smith', 'Corporate', 'abc_corp@gmail.com', 123456789, 1, NULL, 1, NULL, NULL),
('XYZ Ltd.', 'Emily', 'Johnson', 'Corporate', 'xyz_ltd@gmail.com', 234567890, 2, NULL, 2, NULL, NULL),
('Sunset Enterprises', 'Michael', 'Brown', 'Corporate', 'sunset_ent@gmail.com', 345678901, 3, NULL, 3, NULL, NULL),
('Golden Events', 'Jennifer', 'Davis', 'Corporate', 'golden_events@gmail.com', 456789012, 4, NULL, 4, NULL, NULL),
('Blue Sky Inc.', 'William', 'Martinez', 'Corporate', 'blue_sky_inc@gmail.com', 567890123, 5, NULL, 5, NULL, NULL),
('Event Solutions', 'Elizabeth', 'Wilson', 'Corporate', 'event_solutions@gmail.com', 678901234, 6, NULL, 6, NULL, NULL),
('Starlight Productions', 'Daniel', 'Taylor', 'Corporate', 'starlight_pro@gmail.com', 789012345, 7, NULL, 7, NULL, NULL),
('Sunrise Events', 'Sophia', 'Anderson', 'Corporate', 'sunrise_events@gmail.com', 890123456, 8, NULL, 8, NULL, NULL),
('Green Leaf Group', 'James', 'Thomas', 'Corporate', 'green_leaf_group@gmail.com', 901234567, 9, NULL, 9, NULL, NULL),
('Ocean View Enterprises', 'Olivia', 'Hernandez', 'Corporate', 'ocean_view@gmail.com', 123456789, 10, NULL, 10, NULL, NULL),
('Eventful Creations', 'David', 'Young', 'Corporate', 'eventful_creations@gmail.com', 234567890, 11, NULL, 11, NULL, NULL),
('Silver Lining Events', 'Emma', 'King', 'Corporate', 'silver_lining@gmail.com', 345678901, 12, NULL, 12, NULL, NULL),
('Sky High Productions', 'Michael', 'Lee', 'Corporate', 'sky_high_pro@gmail.com', 456789012, 13, NULL, 13, NULL, NULL),
('Aurora Events', 'Sarah', 'Garcia', 'Corporate', 'aurora_events@gmail.com', 567890123, 14, NULL, 14, NULL, NULL),
('Bright Ideas Inc.', 'Matthew', 'Brown', 'Corporate', 'bright_ideas@gmail.com', 678901234, 15, NULL, 15, NULL, NULL),
('Event Horizon', 'Jessica', 'Lopez', 'Corporate', 'event_horizon@gmail.com', 789012345, 16, NULL, 16, NULL, NULL),
('Eventualities Ltd.', 'Christopher', 'Scott', 'Corporate', 'eventualities@gmail.com', 890123456, 17, NULL, 17, NULL, NULL),
('Moonlight Events', 'Amanda', 'Green', 'Corporate', 'moonlight_events@gmail.com', 901234567, 18, NULL, 18, NULL, NULL),
('Northern Lights Productions', 'Justin', 'Evans', 'Corporate', 'northern_lights@gmail.com', 123456789, 19, NULL, 19, NULL, NULL),
('Eclipse Events', 'Ashley', 'Baker', 'Corporate', 'eclipse_events@gmail.com', 234567890, 20, NULL, 20, NULL, NULL),
('Starry Night Enterprises', 'Joshua', 'Hill', 'Corporate', 'starry_night@gmail.com', 345678901, 21, NULL, 21, NULL, NULL),
('Twilight Events', 'Melissa', 'Adams', 'Corporate', 'twilight_events@gmail.com', 456789012, 22, NULL, 22, NULL, NULL),
('Eventuality Solutions', 'Ryan', 'Rivera', 'Corporate', 'eventuality_solutions@gmail.com', 567890123, 23, NULL, 23, NULL, NULL),
('Sunny Side Events', 'Megan', 'Mitchell', 'Corporate', 'sunny_side@gmail.com', 678901234, 24, NULL, 24, NULL, NULL),
('Rainbow Events', 'Nicholas', 'Perez', 'Corporate', 'rainbow_events@gmail.com', 789012345, 25, NULL, 25, NULL, NULL),
('Event Dynamics', 'Hannah', 'Roberts', 'Corporate', 'event_dynamics@gmail.com', 890123456, 26, NULL, 26, NULL, NULL),
('Brilliant Events', 'David', 'Turner', 'Corporate', 'brilliant_events@gmail.com', 901234567, 27, NULL, 27, NULL, NULL),
('Crescent Moon Productions', 'Kayla', 'Phillips', 'Corporate', 'crescent_moon@gmail.com', 123456789, 28, NULL, 28, NULL, NULL),
('Harmony Events', 'Tyler', 'Campbell', 'Corporate', 'harmony_events@gmail.com', 234567890, 29, NULL, 29, NULL, NULL),
('Majestic Events', 'Stephanie', 'Nelson', 'Corporate', 'majestic_events@gmail.com', 345678901, 30, NULL, 30, NULL, NULL),
('Dreamscape Events', 'Brandon', 'Mitchell', 'Corporate', 'dreamscape_events@gmail.com', 456789012, 31, NULL, 31, NULL, NULL),
('Eventive Solutions', 'Samantha', 'Roberts', 'Corporate', 'eventive_solutions@gmail.com', 567890123, 32, NULL, 32, NULL, NULL),
('Tranquility Events', 'Jordan', 'Cook', 'Corporate', 'tranquility_events@gmail.com', 678901234, 33, NULL, 33, NULL, NULL),
('Peak Performance Events', 'Alexis', 'Hill', 'Corporate', 'peak_performance@gmail.com', 789012345, 34, NULL, 34, NULL, NULL),
('Elegant Events', 'Zachary', 'Nelson', 'Corporate', 'elegant_events@gmail.com', 890123456, 35, NULL, 35, NULL, NULL),
('Event Essence', 'Emily', 'Walker', 'Corporate', 'event_essence@gmail.com', 901234567, 36, NULL, 36, NULL, NULL),
('Exquisite Events', 'Cody', 'Young', 'Corporate', 'exquisite_events@gmail.com', 123456789, 37, NULL, 37, NULL, NULL),
('Summit Events', 'Emma', 'King', 'Corporate', 'summit_events@gmail.com', 234567890, 38, NULL, 38, NULL, NULL),
('Dynamic Events', 'Madison', 'Allen', 'Corporate', 'dynamic_events@gmail.com', 345678901, 39, NULL, 39, NULL, NULL),
('Spectra Events', 'Adam', 'Lewis', 'Corporate', 'spectra_events@gmail.com', 456789012, 40, NULL, 40, NULL, NULL),
('Eventuality Inc.', 'Robert', 'Walker', 'Corporate', 'eventuality_inc@gmail.com', 567890123, 41, NULL, 41, NULL, NULL),
('Vivid Events', 'Abigail', 'Wright', 'Corporate', 'vivid_events@gmail.com', 678901234, 42, NULL, 42, NULL, NULL),
('Dream Events', 'Samuel', 'Lopez', 'Corporate', 'dream_events@gmail.com', 789012345, 43, NULL, 43, NULL, NULL),
('Splendid Events', 'Ella', 'Garcia', 'Corporate', 'splendid_events@gmail.com', 890123456, 44, NULL, 44, NULL, NULL),
('Creative Events', 'Dylan', 'Flores', 'Corporate', 'creative_events@gmail.com', 901234567, 45, NULL, 45, NULL, NULL),
('Elite Events', 'Mia', 'Young', 'Corporate', 'elite_events@gmail.com', 123456789, 46, NULL, 46, NULL, NULL),
('Euphoria Events', 'Noah', 'Martin', 'Corporate', 'euphoria_events@gmail.com', 234567890, 47, NULL, 47, NULL, NULL),
('Epic Events', 'Sophie', 'Gonzalez', 'Corporate', 'epic_events@gmail.com', 345678901, 48, NULL, 48, NULL, NULL),
('Prime Events', 'Logan', 'Rodriguez', 'Corporate', 'prime_events@gmail.com', 456789012, 49, NULL, 49, NULL, NULL),
('Grand Events', 'Charlotte', 'Martinez', 'Corporate', 'grand_events@gmail.com', 567890123, 50, NULL, 50, NULL, NULL),
('Royal Events', 'Luke', 'Lee', 'Corporate', 'royal_events@gmail.com', 678901234, 51, NULL, 51, NULL, NULL),
('Glamour Events', 'Liam', 'Hernandez', 'Corporate', 'glamour_events@gmail.com', 789012345, 52, NULL, 52, NULL, NULL),
('Prestige Events', 'Lily', 'Gonzalez', 'Corporate', 'prestige_events@gmail.com', 890123456, 53, NULL, 53, NULL, NULL),
('Divine Events', 'Lucas', 'Rodriguez', 'Corporate', 'divine_events@gmail.com', 901234567, 54, NULL, 54, NULL, NULL),
('Opulent Events', 'Zoe', 'Rodriguez', 'Corporate', 'opulent_events@gmail.com', 123456789, 55, NULL, 55, NULL, NULL),
('Extravagant Events', 'Elijah', 'Lee', 'Corporate', 'extravagant_events@gmail.com', 234567890, 56, NULL, 56, NULL, NULL),
('Luxury Events', 'Mason', 'Hernandez', 'Corporate', 'luxury_events@gmail.com', 345678901, 57, NULL, 57, NULL, NULL),
('Elite Affairs', 'Avery', 'Gonzalez', 'Corporate', 'elite_affairs@gmail.com', 456789012, 58, NULL, 58, NULL, NULL),
('Pinnacle Events', 'Scarlett', 'Rodriguez', 'Corporate', 'pinnacle_events@gmail.com', 567890123, 59, NULL, 59, NULL, NULL),
('Sovereign Events', 'Ellie', 'Hernandez', 'Corporate', 'sovereign_events@gmail.com', 678901234, 60, NULL, 60, NULL, NULL),
('Supreme Events', 'Jack', 'Lee', 'Corporate', 'supreme_events@gmail.com', 789012345, 61, NULL, 61, NULL, NULL),
('Paramount Events', 'Hazel', 'Gonzalez', 'Corporate', 'paramount_events@gmail.com', 890123456, 62, NULL, 62, NULL, NULL),
('Regal Events', 'Natalie', 'Rodriguez', 'Corporate', 'regal_events@gmail.com', 901234567, 63, NULL, 63, NULL, NULL),
('Imperial Events', 'Eli', 'Hernandez', 'Corporate', 'imperial_events@gmail.com', 123456789, 64, NULL, 64, NULL, NULL),
('Royal Affairs', 'Violet', 'Lee', 'Corporate', 'royal_affairs@gmail.com', 234567890, 65, NULL, 65, NULL, NULL),
('Majesty Events', 'Jackson', 'Gonzalez', 'Corporate', 'majesty_events@gmail.com', 345678901, 66, NULL, 66, NULL, NULL),
('Crown Events', 'Sophia', 'Rodriguez', 'Corporate', 'crown_events@gmail.com', 456789012, 67, NULL, 67, NULL, NULL),
('Noble Events', 'Gabriel', 'Hernandez', 'Corporate', 'noble_events@gmail.com', 567890123, 68, NULL, 68, NULL, NULL),
('Elite Entertainments', 'Madelyn', 'Lee', 'Corporate', 'elite_entertainments@gmail.com', 678901234, 69, NULL, 69, NULL, NULL),
('Elite Experiences', 'Chase', 'Gonzalez', 'Corporate', 'elite_experiences@gmail.com', 789012345, 70, NULL, 70, NULL, NULL),
('Dream Weddings', 'Caleb', 'Rodriguez', 'Corporate', 'dream_weddings@gmail.com', 890123456, 71, NULL, 71, NULL, NULL),
('Fairytale Events', 'Penelope', 'Hernandez', 'Corporate', 'fairytale_events@gmail.com', 901234567, 72, NULL, 72, NULL, NULL),
('Magic Moments', 'Levi', 'Lee', 'Corporate', 'magic_moments@gmail.com', 123456789, 73, NULL, 73, NULL, NULL),
('Blissful Events', 'Allison', 'Gonzalez', 'Corporate', 'blissful_events@gmail.com', 234567890, 74, NULL, 74, NULL, NULL),
('Enchanted Affairs', 'Ian', 'Rodriguez', 'Corporate', 'enchanted_affairs@gmail.com', 345678901, 75, NULL, 75, NULL, NULL),
('Wonderful Weddings', 'Silas', 'Hernandez', 'Corporate', 'wonderful_weddings@gmail.com', 456789012, 76, NULL, 76, NULL, NULL),
('Celestial Events', 'Adeline', 'Lee', 'Corporate', 'celestial_events@gmail.com', 567890123, 77, NULL, 77, NULL, NULL),
('Cherished Moments', 'Bryson', 'Gonzalez', 'Corporate', 'cherished_moments@gmail.com', 678901234, 78, NULL, 78, NULL, NULL),
('Elegant Occasions', 'Theodore', 'Rodriguez', 'Corporate', 'elegant_occasions@gmail.com', 789012345, 79, NULL, 79, NULL, NULL),
('Heavenly Events', 'Elena', 'Hernandez', 'Corporate', 'heavenly_events@gmail.com', 890123456, 80, NULL, 80, NULL, NULL),
('Timeless Events', 'Julian', 'Lee', 'Corporate', 'timeless_events@gmail.com', 901234567, 81, NULL, 81, NULL, NULL),
('Forever Yours Events', 'Ivy', 'Gonzalez', 'Corporate', 'forever_yours@gmail.com', 123456789, 82, NULL, 82, NULL, NULL),
('Everlasting Events', 'Owen', 'Rodriguez', 'Corporate', 'everlasting_events@gmail.com', 234567890, 83, NULL, 83, NULL, NULL),
('Infinite Moments', 'Lucy', 'Hernandez', 'Corporate', 'infinite_moments@gmail.com', 345678901, 84, NULL, 84, NULL, NULL),
('Unforgettable Events', 'Greyson', 'Lee', 'Corporate', 'unforgettable_events@gmail.com', 456789012, 85, NULL, 85, NULL, NULL),
('Legendary Events', 'Evangeline', 'Gonzalez', 'Corporate', 'legendary_events@gmail.com', 567890123, 86, NULL, 86, NULL, NULL),
('Iconic Events', 'Ezra', 'Rodriguez', 'Corporate', 'iconic_events@gmail.com', 678901234, 87, NULL, 87, NULL, NULL),
('Classic Events', 'Nova', 'Hernandez', 'Corporate', 'classic_events@gmail.com', 789012345, 88, NULL, 88, NULL, NULL),
('Vintage Events', 'Maximilian', 'Lee', 'Corporate', 'vintage_events@gmail.com', 890123456, 89, NULL, 89, NULL, NULL),
('Timeless Affairs', 'Aria', 'Gonzalez', 'Corporate', 'timeless_affairs@gmail.com', 901234567, 90, NULL, 90, NULL, NULL),
('Cherished Celebrations', 'Daxton', 'Rodriguez', 'Corporate', 'cherished_celebrations@gmail.com', 123456789, 91, NULL, 91, NULL, NULL),
('Forever Yours Affairs', 'Amara', 'Hernandez', 'Corporate', 'forever_yours_affairs@gmail.com', 234567890, 92, NULL, 92, NULL, NULL),
('Eternal Events', 'Landon', 'Lee', 'Corporate', 'eternal_events@gmail.com', 345678901, 93, NULL, 93, NULL, NULL),
('Elegant Celebrations', 'Axel', 'Gonzalez', 'Corporate', 'elegant_celebrations@gmail.com', 456789012, 94, NULL, 94, NULL, NULL),
('Endless Events', 'Freya', 'Rodriguez', 'Corporate', 'endless_events@gmail.com', 567890123, 95, NULL, 95, NULL, NULL),
('Timeless Celebrations', 'Finn', 'Hernandez', 'Corporate', 'timeless_celebrations@gmail.com', 678901234, 96, NULL, 96, NULL, NULL),
('Cherished Affairs', 'Phoenix', 'Lee', 'Corporate', 'cherished_affairs@gmail.com', 789012345, 97, NULL, 97, NULL, NULL),
('Forever Yours Celebrations', 'Ayla', 'Gonzalez', 'Corporate', 'forever_yours_celebrations@gmail.com', 890123456, 98, NULL, 98, NULL, NULL),
('Eternal Affairs', 'Sawyer', 'Rodriguez', 'Corporate', 'eternal_affairs@gmail.com', 901234567, 99, NULL, 99, NULL, NULL),
('Elegant Gatherings', 'Kai', 'Hernandez', 'Corporate', 'elegant_gatherings@gmail.com', 123456789, 100, NULL, 100, NULL, NULL),
('Endless Celebrations', 'Lyra', 'Lee', 'Corporate', 'endless_celebrations@gmail.com', 234567890, 101, NULL, 101, NULL, NULL),
('Timeless Gatherings', 'Alder', 'Gonzalez', 'Corporate', 'timeless_gatherings@gmail.com', 345678901, 102, NULL, 102, NULL, NULL),
('Cherished Gatherings', 'Sage', 'Rodriguez', 'Corporate', 'cherished_gatherings@gmail.com', 456789012, 103, NULL, 103, NULL, NULL),
('Forever Yours Gatherings', 'Iris', 'Hernandez', 'Corporate', 'forever_yours_gatherings@gmail.com', 567890123, 104, NULL, 104, NULL, NULL),
('Eternal Gatherings', 'Rowan', 'Lee', 'Corporate', 'eternal_gatherings@gmail.com', 678901234, 105, NULL, 105, NULL, NULL),
('Elegant Affairs', 'Jasper', 'Gonzalez', 'Corporate', 'elegant_affairs@gmail.com', 789012345, 106, NULL, 106, NULL, NULL),
('Endless Gatherings', 'Aurora', 'Rodriguez', 'Corporate', 'endless_gatherings@gmail.com', 890123456, 107, NULL, 107, NULL, NULL),
('Timeless Affairs', 'Orion', 'Hernandez', 'Corporate', 'timeless_affairs@gmail.com', 901234567, 108, NULL, 108, NULL, NULL),  
('Sunrise Foundation', 'Michael', 'Johnson', 'Foundation', 'sunrise.foundation@gmail.com', 345678901, 26, NULL, 4, NULL, 221),
('Green Earth Organization', 'Noah', 'Garcia', 'Organization', 'greenearth_org@gmail.com', 789012345, 32, 156, 17, NULL, NULL),
('Vibrant Ventures', 'Noah', 'Evans', 'Venture', 'vibrant_ventures@gmail.com', 234567890, 29, 83, NULL, NULL, NULL),
('Oceanic Charity', 'Sophia', 'White', 'Charity', 'oceanic_charity@gmail.com', 456789012, 18, 221, 5, NULL, NULL),
('Hope Foundation', 'Emma', 'Johnson', 'Foundation', 'hope.foundation@gmail.com', 678901234, 9, 255, 7, NULL, NULL),
('Future Builders', 'James', 'Taylor', 'Organization', 'future.builders@gmail.com', 901234567, 5, 198, NULL, NULL, NULL),
('Sunset Trust', 'Noah', 'Brown', 'Trust', 'sunset_trust@gmail.com', 123456789, 14, 47, NULL, NULL, NULL),
('Bright Horizon', 'Sophia', 'Wilson', 'Foundation', 'bright_horizon@gmail.com', 234567890, 29, 83, 11, NULL, NULL),
('Unity Charity', 'Olivia', 'Martinez', 'Charity', 'unity_charity@gmail.com', 678901234, 32, 156, NULL, NULL, NULL),
('Angel Wish', 'Lucas', 'Anderson', 'Foundation', 'angels_wish@gmail.com', 456789012, 18, 221, NULL, NULL, NULL),
('Eco Harmony', 'Ethan', 'Garcia', 'Organization', 'eco_harmony@gmail.com', 901234567, 5, 198, 15, NULL, NULL);



INSERT INTO payments (payment_amount, payment_date, payment_method, payments_invoice_id, payments_client_id)
VALUES 
(15000, '2024-01-01', 'Credit Card', 1, 2),
(18000, '2024-01-03', 'Bank Transfer', 3, 3),
(25000, '2024-01-05', 'Cash', 5, 4),
(23000, '2024-01-07', 'PayPal', 7, 5),
(24000, '2024-01-09', 'Cheque', 9, 6),
(26000, '2024-01-11', 'Credit Card', 11, 7),
(22000, '2024-01-13', 'Bank Transfer', 13, 8),
(21000, '2024-01-15', 'Cash', 15, 9),
(23000, '2024-01-17', 'PayPal', 17, 10),
(26000, '2024-01-19', 'Cheque', 19, 11),
(20000, '2024-01-21', 'Credit Card', 21, 12),
(23000, '2024-01-23', 'PayPal', 23, 13),
(21000, '2024-01-25', 'Cash', 25, 14),
(24000, '2024-01-27', 'Cheque', 27, 15),
(26000, '2024-01-29', 'Credit Card', 29, 16),
(28000, '2024-01-31', 'Bank Transfer', 31, 17),
(27000, '2024-02-02', 'Cash', 33, 18),
(29000, '2024-02-04', 'PayPal', 35, 19),
(24000, '2024-02-06', 'Cheque', 37, 20),
(22000, '2024-02-08', 'Credit Card', 39, 21),
(23000, '2024-02-10', 'Bank Transfer', 41, 22),
(25000, '2024-02-12', 'Cash', 43, 23),
(21000, '2024-02-14', 'PayPal', 45, 24),
(24000, '2024-02-16', 'Cheque', 47, 25),
(27000, '2024-02-18', 'Credit Card', 49, 26),
(28000, '2024-02-20', 'Bank Transfer', 51, 27),
(26000, '2024-02-22', 'Cash', 53, 28),
(25000, '2024-02-24', 'PayPal', 55, 29),
(24000, '2024-02-26', 'Cheque', 57, 30),
(22000, '2024-02-28', 'Credit Card', 59, 31),
(23000, '2024-03-01', 'Bank Transfer', 61, 32),
(25000, '2024-03-03', 'Cash', 63, 33),
(24000, '2024-03-05', 'PayPal', 65, 34),
(22000, '2024-03-07', 'Cheque', 67, 35),
(27000, '2024-03-09', 'Credit Card', 69, 36),
(28000, '2024-03-11', 'Bank Transfer', 71, 37),
(25000, '2024-03-13', 'Cash', 73, 38),
(24000, '2024-03-15', 'PayPal', 75, 39),
(22000, '2024-03-17', 'Cheque', 77, 40),
(26000, '2024-03-19', 'Credit Card', 79, 41),
(23000, '2024-03-21', 'Bank Transfer', 81, 42),
(25000, '2024-03-23', 'Cash', 83, 43),
(24000, '2024-03-25', 'PayPal', 85, 44),
(22000, '2024-03-27', 'Cheque', 87, 45),
(27000, '2024-03-29', 'Credit Card', 89, 46),
(28000, '2024-03-31', 'Bank Transfer', 91, 47),
(25000, '2024-04-02', 'Cash', 93, 48),
(24000, '2024-04-04', 'PayPal', 95, 49),
(22000, '2024-04-06', 'Cheque', 97, 50),
(26000, '2024-04-08', 'Credit Card', 99, 51),
(27000, '2024-04-10', 'Bank Transfer', 101, 52), 
(28000, '2024-04-12', 'Cash', 103, 53),
(25000, '2024-04-14', 'PayPal', 105, 54),
(22000, '2024-04-16', 'Cheque', 107, 55),
(27000, '2024-04-18', 'Credit Card', 109, 56),
(28000, '2024-04-20', 'Bank Transfer', 111, 57),
(26000, '2024-04-22', 'Cash', 113, 58),
(25000, '2024-04-24', 'PayPal', 115, 59),
(22000, '2024-04-26', 'Cheque', 117, 60),
(27000, '2024-04-28', 'Credit Card', 119, 61),
(28000, '2024-04-30', 'Bank Transfer', 121, 62),
(26000, '2024-05-02', 'Cash', 123, 63),
(25000, '2024-05-04', 'PayPal', 125, 64),
(22000, '2024-05-06', 'Cheque', 127, 65),
(27000, '2024-05-08', 'Credit Card', 129, 66),
(28000, '2024-05-10', 'Bank Transfer', 131, 67),
(26000, '2024-05-12', 'Cash', 133, 68),
(25000, '2024-05-14', 'PayPal', 135, 69),
(22000, '2024-05-16', 'Cheque', 137, 70),
(27000, '2024-05-18', 'Credit Card', 139, 71),
(28000, '2024-05-20', 'Bank Transfer', 141, 72),
(26000, '2024-05-22', 'Cash', 143, 73),
(25000, '2024-05-24', 'PayPal', 145, 74),
(22000, '2024-05-26', 'Cheque', 147, 75),
(27000, '2024-05-28', 'Credit Card', 149, 76),
(28000, '2024-05-30', 'Bank Transfer', 151, 77),
(26000, '2024-06-01', 'Cash', 153, 78),
(25000, '2024-06-03', 'PayPal', 155, 79),
(22000, '2024-06-05', 'Cheque', 157, 80),
(27000, '2024-06-07', 'Credit Card', 159, 81),
(28000, '2024-06-09', 'Bank Transfer', 161, 82),
(26000, '2024-06-11', 'Cash', 163, 83),
(25000, '2024-06-13', 'PayPal', 165, 84),
(22000, '2024-06-15', 'Cheque', 167, 85),
(27000, '2024-06-17', 'Credit Card', 169, 86),
(28000, '2024-06-19', 'Bank Transfer', 171, 87),
(26000, '2024-06-21', 'Cash', 173, 88),
(25000, '2024-06-23', 'PayPal', 175, 89),
(22000, '2024-06-25', 'Cheque', 177, 90),
(27000, '2024-06-27', 'Credit Card', 179, 91),
(28000, '2024-06-29', 'Bank Transfer', 181, 92),
(26000, '2024-07-01', 'Cash', 183, 93),
(25000, '2024-07-03', 'PayPal', 185, 94),
(22000, '2024-07-05', 'Cheque', 187, 95),
(27000, '2024-07-07', 'Credit Card', 189, 96),
(28000, '2024-07-09', 'Bank Transfer', 191, 97),
(26000, '2024-07-11', 'Cash', 193, 98),
(25000, '2024-07-13', 'PayPal', 195, 99),
(22000, '2024-07-15', 'Cheque', 197, 100),
(27000, '2024-07-17', 'Credit Card', 199, 101),
(28000, '2024-07-19', 'Bank Transfer', 201, 102);

INSERT INTO invoices (invoice_date_issued, invoice_status, invoices_vendor_id, invoices_client_id, invoices_payment_id)
VALUES 
('2024-01-01', 'paid', 12, NULL, 1), ('2024-01-02', 'pending', 7, 102, 2), ('2024-01-03', 'paid', NULL, 299, 3), ('2024-01-04', 'pending', 26, NULL, 4), ('2024-01-05', 'paid', 18, 221, 5),
('2024-01-06', 'pending', 33, NULL, 6), ('2024-01-07', 'paid', NULL, 134, 7), ('2024-01-08', 'pending', 15, NULL, 8), ('2024-01-09', 'paid', 11, 57, 9), ('2024-01-10', 'pending', NULL, 194, 10),
('2024-01-11', 'paid', 23, NULL, 11), ('2024-01-12', 'pending', 31, NULL, 12), ('2024-01-13', 'paid', NULL, 67, 13), ('2024-01-14', 'pending', 8, NULL, 14), ('2024-01-15', 'paid', 22, NULL, 15),
('2024-01-16', 'pending', 5, NULL, 16), ('2024-01-17', 'paid', NULL, 298, 17), ('2024-01-18', 'pending', 14, NULL, 18), ('2024-01-19', 'paid', 32, NULL, 19), ('2024-01-20', 'pending', 27, NULL, 20),
('2024-01-21', 'paid', NULL, 83, 21), ('2024-01-22', 'pending', 2, NULL, 22), ('2024-01-23', 'paid', 16, NULL, 23), ('2024-01-24', 'pending', 25, NULL, 24), ('2024-01-25', 'paid', 21, NULL, 25),
('2024-01-26', 'pending', NULL, 221, 26), ('2024-01-27', 'paid', 10, NULL, 27), ('2024-01-28', 'pending', 19, NULL, 28), ('2024-01-29', 'paid', 4, NULL, 29), ('2024-01-30', 'pending', 30, NULL, 30),
('2024-01-31', 'paid', 6, NULL, 31), ('2024-02-01', 'pending', 1, NULL, 32), ('2024-02-02', 'paid', 13, NULL, 33), ('2024-02-03', 'pending', 28, NULL, 34), ('2024-02-04', 'paid', 9, NULL, 35),
('2024-02-05', 'pending', NULL, 78, 36), ('2024-02-06', 'paid', 24, NULL, 37), ('2024-02-07', 'pending', 3, NULL, 38), ('2024-02-08', 'paid', 20, NULL, 39), ('2024-02-09', 'pending', 29, NULL, 40),
('2024-02-10', 'paid', 17, NULL, 41), ('2024-02-11', 'pending', 11, NULL, 42), ('2024-02-12', 'paid', NULL, 291, 43), ('2024-02-13', 'pending', 8, NULL, 44), ('2024-02-14', 'paid', 33, NULL, 45),
('2024-02-15', 'pending', 21, NULL, 46), ('2024-02-16', 'paid', 14, NULL, 47), ('2024-02-17', 'pending', 31, NULL, 48), ('2024-02-18', 'paid', 27, NULL, 49), ('2024-02-19', 'pending', NULL, 209, 50),
('2024-02-20', 'paid', 5, NULL, 51), ('2024-02-21', 'pending', 18, NULL, 52), ('2024-02-22', 'paid', 12, NULL, 53), ('2024-02-23', 'pending', 2, NULL, 54), ('2024-02-24', 'paid', 23, NULL, 55),
('2024-02-25', 'pending', 15, NULL, 56), ('2024-02-26', 'paid', NULL, 278, 57), ('2024-02-27', 'pending', 19, NULL, 58), ('2024-02-28', 'paid', 6, NULL, 59), ('2024-02-29', 'pending', 28, NULL, 60),
('2024-03-01', 'paid', 9, NULL, 61), ('2024-03-02', 'pending', 24, NULL, 62), ('2024-03-03', 'paid', 13, NULL, 63), ('2024-03-04', 'pending', 30, NULL, 64), ('2024-03-05', 'paid', 4, NULL, 65),
('2024-03-06', 'pending', NULL, 88, 66), ('2024-03-07', 'paid', 20, NULL, 67), ('2024-03-08', 'pending', 29, NULL, 68), ('2024-03-09', 'paid', 17, NULL, 69), ('2024-03-10', 'pending', 11, NULL, 70),
('2024-03-11', 'paid', NULL, 179, 71), ('2024-03-12', 'pending', 7, NULL, 72), ('2024-03-13', 'paid', 32, NULL, 73), ('2024-03-14', 'pending', 25, NULL, 74), ('2024-03-15', 'paid', 16, NULL, 75),
('2024-03-16', 'pending', 3, NULL, 76), ('2024-03-17', 'paid', 22, NULL, 77), ('2024-03-18', 'pending', 10, NULL, 78), ('2024-03-19', 'paid', 1, NULL, 79), ('2024-03-20', 'pending', 14, NULL, 80),
('2024-03-21', 'paid', 33, NULL, 81), ('2024-03-22', 'pending', 21, NULL, 82), ('2024-03-23', 'paid', 18, NULL, 83), ('2024-03-24', 'pending', 5, NULL, 84), ('2024-03-25', 'paid', 26, NULL, 85),
('2024-03-26', 'pending', 8, NULL, 86), ('2024-03-27', 'paid', 19, NULL, 87), ('2024-03-28', 'pending', 12, NULL, 88), ('2024-03-29', 'paid', 23, NULL, 89), ('2024-03-30', 'pending', 15, NULL, 90),
('2024-03-31', 'paid', NULL, 243, 91), ('2024-04-01', 'pending', 27, NULL, 92), ('2024-04-02', 'paid', 6, NULL, 93), ('2024-04-03', 'pending', 28, NULL, 94), ('2024-04-04', 'paid', 9, NULL, 95),
('2024-04-05', 'pending', 24, NULL, 96), ('2024-04-06', 'paid', 13, NULL, 97), ('2024-04-07', 'pending', 30, NULL, 98), ('2024-04-08', 'paid', 4, NULL, 99), ('2024-04-09', 'pending', NULL, 192, 100),
('2024-04-10', 'paid', 20, NULL, 101);


INSERT INTO vendors (vendor_first_name, vendor_last_name, vendor_contact_person, vendor_email, vendor_contact_number, vendors_invoice_id)
VALUES 
('John', 'Doe', 'Rajesh Kumar', 'john.doe@gmail.com', '1234567890', 101), 
('Alice', 'Smith', 'Priya Patel', 'alice.smith@hotmail.com', '2345678901', 102), 
('Michael', 'Johnson', 'Anjali Sharma', 'michael.johnson@yahoo.com', '3456789012', 99), 
('Emily', 'Brown', 'Amit Singh', 'emily.brown@gmail.com', '4567890123', 100), 
('David', 'Wilson', 'Sunita Gupta', 'david.wilson@hotmail.com', '5678901234', 98),
('Sophia', 'Martinez', 'Rakesh Verma', 'sophia.martinez@yahoo.com', '6789012345', 101), 
('James', 'Taylor', 'Meera Patel', 'james.taylor@gmail.com', '7890123456', 100), 
('Olivia', 'Anderson', 'Rahul Kumar', 'olivia.anderson@hotmail.com', '8901234567', 99), 
('Daniel', 'Thomas', 'Ananya Gupta', 'daniel.thomas@yahoo.com', '9012345678', 102), 
('Emma', 'Jackson', 'Neha Sharma', 'emma.jackson@gmail.com', '1234567890', 101),
('William', 'White', 'Akash Verma', 'william.white@hotmail.com', '2345678901', 100), 
('Ava', 'Harris', 'Vivek Singh', 'ava.harris@yahoo.com', '3456789012', 101), 
('Alexander', 'Martin', 'Sneha Patel', 'alexander.martin@gmail.com', '4567890123', 99), 
('Chloe', 'Thompson', 'Gaurav Kumar', 'chloe.thompson@hotmail.com', '5678901234', 100), 
('Mason', 'Garcia', 'Priyanka Singh', 'mason.garcia@yahoo.com', '6789012345', 98),
('Sophia', 'Lee', 'Vikas Sharma', 'sophia.lee@gmail.com', '7890123456', 99), 
('Ethan', 'Perez', 'Ritu Patel', 'ethan.perez@hotmail.com', '8901234567', 101), 
('Isabella', 'Young', 'Deepak Kumar', 'isabella.young@yahoo.com', '9012345678', 100), 
('Michael', 'Hernandez', 'Swati Sharma', 'michael.hernandez@gmail.com', '1234567890', 99), 
('Mia', 'King', 'Karan Verma', 'mia.king@hotmail.com', '2345678901', 100),
('Jayden', 'Evans', 'Anita Patel', 'jayden.evans@yahoo.com', '3456789012', 101), 
('Liam', 'Clark', 'Rajni Sharma', 'liam.clark@gmail.com', '4567890123', 100), 
('Emma', 'Baker', 'Arun Kumar', 'emma.baker@hotmail.com', '5678901234', 99), 
('Benjamin', 'Morales', 'Anjali Singh', 'benjamin.morales@yahoo.com', '6789012345', 98), 
('Avery', 'Hall', 'Mohit Sharma', 'avery.hall@gmail.com', '7890123456', 101),
('Charlotte', 'Young', 'Rohan Patel', 'charlotte.young@hotmail.com', '8901234567', 100), 
('Jackson', 'Gonzalez', 'Shreya Sharma', 'jackson.gonzalez@yahoo.com', '9012345678', 99), 
('Aria', 'Allen', 'Amita Patel', 'aria.allen@gmail.com', '1234567890', 101), 
('Elijah', 'Scott', 'Yash Singh', 'elijah.scott@hotmail.com', '2345678901', 100), 
('Zoey', 'Lopez', 'Divya Sharma', 'zoey.lopez@yahoo.com', '3456789012', 99),
('Nathan', 'Hall', 'Ankit Patel', 'nathan.hall@gmail.com', '4567890123', 101), 
('Leah', 'Rivera', 'Rahul Verma', 'leah.rivera@hotmail.com', '5678901234', 100), 
('Elena', 'Barnes', 'Aarti Patel', 'elena.barnes@yahoo.com', '6789012345', 99);

INSERT INTO staff (staff_first_name, staff_last_name, staff_position, staff_email, staff_contact_number)
VALUES 
('Muhammad', 'Abdullah', 'Event Coordinator', 'muhammad.abdullah@syr.edu', 123456789),
('Aisha', 'Kamara', 'Event Planner', 'aisha.kamara@syr.edu', 234567890),
('Fatima', 'Sow', 'Venue Manager', 'fatima.sow@syr.edu', 345678901),
('Malik', 'Traoré', 'Operations Manager', 'malik.traore@syr.edu', 456789012),
('Amira', 'Müller', 'Marketing Manager', 'amira.muller@syr.edu', 567890123),
('Omar', 'Jalloh', 'Logistics Coordinator', 'omar.jalloh@syr.edu', 678901234),
('Saida', 'Adebayo', 'Client Relations Manager', 'saida.adebayo@syr.edu', 789012345),
('Yusuf', 'Berger', 'Technical Director', 'yusuf.berger@syr.edu', 890123456),
('Jamila', 'Diallo', 'Event Coordinator', 'jamila.diallo@syr.edu', 901234567),
('Abdul', 'Sesay', 'Event Planner', 'abdul.sesay@syr.edu', 123456789),
('Amina', 'Okoro', 'Venue Manager', 'amina.okoro@syr.edu', 234567890),
('Idris', 'Nkosi', 'Operations Manager', 'idris.nkosi@syr.edu', 345678901),
('Nasrin', 'Schwarz', 'Marketing Manager', 'nasrin.schwarz@syr.edu', 456789012),
('Hamza', 'Keita', 'Logistics Coordinator', 'hamza.keita@syr.edu', 567890123),
('Rania', 'Osman', 'Client Relations Manager', 'rania.osman@syr.edu', 678901234),
('Khalil', 'Wolf', 'Technical Director', 'khalil.wolf@syr.edu', 789012345),
('Nadia', 'Okeke', 'Event Coordinator', 'nadia.okeke@syr.edu', 890123456),
('Ibrahim', 'Diop', 'Event Planner', 'ibrahim.diop@syr.edu', 901234567),
('Yasmin', 'Kante', 'Venue Manager', 'yasmin.kante@syr.edu', 123456789),
('Bilal', 'Hoffmann', 'Operations Manager', 'bilal.hoffmann@syr.edu', 234567890),
('Safiya', 'Adams', 'Marketing Manager', 'safiya.adams@syr.edu', 345678901),
('Karim', 'Nyathi', 'Logistics Coordinator', 'karim.nyathi@syr.edu', 456789012),
('Aisha', 'Abacha', 'Client Relations Manager', 'aisha.abacha@syr.edu', 567890123),
('Khalid', 'Schmidt', 'Technical Director', 'khalid.schmidt@syr.edu', 678901234),
('Zara', 'Bakari', 'Event Coordinator', 'zara.bakari@syr.edu', 789012345),
('Youssef', 'Nwadike', 'Event Planner', 'youssef.nwadike@syr.edu', 890123456),
('Hassan', 'Osei', 'Venue Manager', 'hassan.osei@syr.edu', 901234567),
('Laila', 'Becker', 'Operations Manager', 'laila.becker@syr.edu', 123456789),
('Anwar', 'Onyango', 'Marketing Manager', 'anwar.onyango@syr.edu', 234567890),
('Muna', 'Bertrand', 'Logistics Coordinator', 'muna.bertrand@syr.edu', 345678901),
('Nabil', 'Müller', 'Client Relations Manager', 'nabil.muller@syr.edu', 456789012),
('Hala', 'Kabila', 'Technical Director', 'hala.kabila@syr.edu', 567890123),
('Amir', 'Adisa', 'Event Coordinator', 'amir.adisa@syr.edu', 678901234),
('Amina', 'Okafor', 'Event Planner', 'amina.okafor@syr.edu', 789012345),
('Mustafa', 'Asamoah', 'Venue Manager', 'mustafa.asamoah@syr.edu', 890123456),
('Ranya', 'Graf', 'Operations Manager', 'ranya.graf@syr.edu', 901234567),
('Jamal', 'Kamau', 'Marketing Manager', 'jamal.kamau@syr.edu', 123456789),
('Nasra', 'Wagner', 'Logistics Coordinator', 'nasra.wagner@syr.edu', 234567890),
('Nadir', 'Diop', 'Client Relations Manager', 'nadir.diop@syr.edu', 345678901),
('Yusra', 'Ludwig', 'Technical Director', 'yusra.ludwig@syr.edu', 456789012),
('Yahya', 'Berger', 'Event Coordinator', 'yahya.berger@syr.edu', 567890123),
('Salma', 'Akin', 'Event Planner', 'salma.akin@syr.edu', 678901234),
('Rashid', 'Obi', 'Venue Manager', 'rashid.obi@syr.edu', 789012345),
('Adila', 'Kwame', 'Operations Manager', 'adila.kwame@syr.edu', 890123456),
('Kofi', 'Stein', 'Marketing Manager', 'kofi.stein@syr.edu', 901234567),
('Alima', 'Hartmann', 'Logistics Coordinator', 'alima.hartmann@syr.edu', 123456789),
('Ismail', 'Nkosi', 'Client Relations Manager', 'ismail.nkosi@syr.edu', 234567890),
('Amina', 'Wagner', 'Technical Director', 'amina.wagner@syr.edu', 345678901),
('Jamila', 'Müller', 'Event Coordinator', 'jamila.muller@syr.edu', 456789012),
('Adnan', 'Okeke', 'Event Planner', 'adnan.okeke@syr.edu', 567890123),
('Habib', 'Asamoah', 'Venue Manager', 'habib.asamoah@syr.edu', 678901234),
('Nadia', 'Berger', 'Operations Manager', 'nadia.berger@syr.edu', 789012345),
('Bilal', 'Traoré', 'Marketing Manager', 'bilal.traore@syr.edu', 890123456),
('Layla', 'Kamara', 'Logistics Coordinator', 'layla.kamara@syr.edu', 901234567),
('Hassan', 'Bertrand', 'Client Relations Manager', 'hassan.bertrand@syr.edu', 123456789),
('Amina', 'Müller', 'Technical Director', 'amina.muller@syr.edu', 234567890),
('Yusuf', 'Diallo', 'Event Coordinator', 'yusuf.diallo@syr.edu', 345678901),
('Amir', 'Sesay', 'Event Planner', 'amir.sesay@syr.edu', 456789012),
('Fatima', 'Nkosi', 'Venue Manager', 'fatima.nkosi@syr.edu', 567890123),
('Malik', 'Berger', 'Operations Manager', 'malik.berger@syr.edu', 678901234),
('Sara', 'Kante', 'Marketing Manager', 'sara.kante@syr.edu', 789012345),
('Khalil', 'Traoré', 'Logistics Coordinator', 'khalil.traore@syr.edu', 890123456),
('Nadia', 'Abacha', 'Client Relations Manager', 'nadia.abacha@syr.edu', 901234567),
('Nabil', 'Keita', 'Technical Director', 'nabil.keita@syr.edu', 123456789),
('Rania', 'Diallo', 'Event Coordinator', 'rania.diallo@syr.edu', 234567890),
('Jamal', 'Osei', 'Event Planner', 'jamal.osei@syr.edu', 345678901),
('Nasra', 'Okoro', 'Venue Manager', 'nasra.okoro@syr.edu', 456789012),
('Nadir', 'Nkosi', 'Operations Manager', 'nadir.nkosi@syr.edu', 567890123),
('Yusra', 'Adams', 'Marketing Manager', 'yusra.adams@syr.edu', 678901234),
('Yahya', 'Nyathi', 'Logistics Coordinator', 'yahya.nyathi@syr.edu', 789012345),
('Salma', 'Abacha', 'Client Relations Manager', 'salma.abacha@syr.edu', 890123456),
('Rashid', 'Schmidt', 'Technical Director', 'rashid.schmidt@syr.edu', 901234567);




INSERT INTO feedbacks (feedback_rating, feedback_comment, feedbacks_client_id, feedbacks_event_id, feedbacks_staff_id) 
VALUES 
(5, 'The birthday celebration was amazing! Everything from the decorations to the food was perfect. Sarah was thrilled with how her 30th birthday turned out. Thank you!', 143, 1, 23),
(4, 'The opening ceremony was well-organized and impressive. The event marked an important milestone for XYZ Corporation. Looking forward to future successes!', 102, 2, 45),
(3, 'The marriage ceremony was lovely, although there were some delays during the reception. John and Emily looked beautiful together. Overall, a nice event.', 221, 3, 67),
(4, 'The naming ceremony was heartwarming, and baby Emma stole the show! The event had a warm and joyful atmosphere. Well done!', 4, 5, 78),
(5, 'The concert was electrifying! The XYZ band put on an incredible show, and the crowd loved every moment of it. Can not wait for the next concert!', 67, 6, 12),
(2, 'The party for Johns graduation was a bit underwhelming. The venue was too small for the number of guests, and the music was not great. Disappointing overall.', 287, 7, 36),
(4, 'The office conference was informative, with great speakers and topics. Networking opportunities were abundant. A productive and enjoyable event!', 156, 8, 81),
(3, 'The product launch was exciting, but the presentation lacked clarity at times. The new smartphone model looks promising, though Room for improvement.', 9, 9, 58),
(5, 'The charity fundraiser event was a huge success! The community came together for a good cause, and we raised more than expected. Heartwarming and fulfilling.', 198, 10, 79),
(4, 'Alice 10th birthday party was fun and colorful! The kids had a blast with the games and activities. Well done on creating a memorable celebration.', 47, 11, 67),
(4, 'The naming ceremony for baby Noah was touching and well-organized. Everything went smoothly, and it was a joyous occasion for the family. Great job!', 83, 12, 45),
(5, 'The jazz night concert was fantastic! The music, atmosphere, and venue were all top-notch. A delightful evening filled with great performances.', 17, 13, 24),
(3, 'The summer pool party was a bit chaotic. The venue was overcrowded, and there were not enough facilities for the guests. Could have been better organized.', 255, 14, 36),
(4, 'The grand opening of ABC Mall was impressive! The ceremony was elegant, and the mall looks stunning. Excited to explore the new shops and amenities.', 176, 15, 72),
(5, 'The wedding of Michael and Olivia was absolutely magical! Everything was perfect, from the venue to the decorations. A fairy tale come true!', 298, 16, 18),
(5, 'David 5th birthday celebration was a blast! The theme was a hit with the kids, and everyone had a great time. Well done!', 142, 17, 37),
(3, 'The annual sales conference was informative, but some sessions felt repetitive. Overall, a decent event with opportunities for improvement.', 156, 18, 89),
(4, 'The product launch for the new gaming console generated a lot of buzz! The event was well-received, and the product demos were impressive. Exciting times ahead!', 224, 19, 51),
(3, 'The community cleanup event was a bit disorganized. There was not clear guidance, and some volunteers seemed unsure of what to do. Could be improved for next time.', 56, 20, 77),
(5, 'The farewell party for Sarah was emotional and heartfelt. She will be missed dearly by everyone. Wishing her all the best in her future endeavors!', 201, 21, 29),
(5, 'The rock concert featuring famous bands was epic! The music, lights, and energy were electrifying. An unforgettable night filled with rock and roll!', 63, 22, 14),
(4, 'The grand opening of XYZ Restaurant was a success! The ambiance and food were excellent. Looking forward to dining here again soon!', 267, 23, 46),
(4, 'The blessing ceremony for baby Sophia was lovely and meaningful. The event had a warm and welcoming atmosphere. Congratulations to the proud parents!', 26, 24, 32),
(5, 'The wedding of James and Emma was beautiful and romantic. Everything was perfect, from the vows to the reception. A day to remember forever!', 293, 25, 28),
(5, 'Lily 16th birthday celebration was fabulous! The party was lively, and the decorations were stunning. A memorable night for everyone!', 112, 26, 19),
(3, 'Tech expo 2024 was informative, but some exhibitors seemed disorganized. More interactive exhibits would have enhanced the experience.', 198, 27, 88),
(4, 'The launch event for the new fashion line was stylish and chic! The designs were impressive, and the runway show was captivating. A fashionable evening indeed!', 29, 28, 42),
(4, 'The volunteer appreciation event was heartwarming and well-deserved. It was great to see the community come together to recognize the efforts of volunteers.', 274, 29, 79),
(5, 'The end-of-year celebration was a blast! Everyone had a great time unwinding and celebrating the achievements of the past year. Here to another successful year ahead!', 97, 30, 21),
(5, 'The classical music concert was breathtaking! The performances were exquisite, and the venue was perfect for the occasion. A night of pure musical delight!', 186, 31, 57),
(4, 'The grand opening of XYZ Hotel was grand indeed! The event was well-organized, and the hotel looks luxurious. Excited to book a stay here soon!', 113, 32, 34),
(4, 'The naming ceremony for baby Ethan was beautiful and heartfelt. It was wonderful to witness the joy and love of the family. Congratulations!', 225, 33, 68),
(5, 'The wedding of Alexander and Isabella was a fairy tale come true! Everything was perfect, from the vows to the reception. Wishing them a lifetime of happiness together!', 267, 34, 17),
(5, 'Lucas 8th birthday party was a blast! The kids had a great time with the games and activities. Well done on creating a fun-filled celebration!', 174, 35, 27),
(4, 'Emily housewarming party was cozy and welcoming! The decorations were lovely, and the atmosphere was inviting. A wonderful gathering with friends and family.', 39, 36, 53),
(5, 'The pop music concert was electrifying! The performers were fantastic, and the crowd was energized throughout the night. Can not wait for the next concert!', 211, 37, 71),
(4, 'The grand opening of ABC Cafe was charming and delightful! The ambiance and food were excellent. Looking forward to many more visits in the future!', 295, 38, 49),
(4, 'The blessing ceremony for baby Mia was touching and heartfelt. It was a joyous occasion for the family, filled with love and blessings.', 197, 39, 63),
(5, 'The wedding of Benjamin and Sophia was magical! Everything was perfect, from the venue to the decorations. A beautiful celebration of love and commitment!', 263, 40, 82),
(5, 'Noah 6th birthday party was a blast! The kids had a great time with the games and activities. Well done on organizing a fun and memorable celebration!', 28, 41, 37),
(4, 'The party celebrating success was a hit! The atmosphere was lively, and everyone was in high spirits. A great way to celebrate achievements and milestones!', 268, 42, 74),
(5, 'The country music concert was fantastic! The performers were talented, and the music was uplifting. A night filled with great music and good vibes!', 48, 43, 23),
(4, 'The grand opening of XYZ Theater was impressive! The venue looks stunning, and the performances were captivating. Looking forward to future shows!', 143, 44, 65),
(4, 'The naming ceremony for baby Jack was heartwarming and joyful. It was a special moment for the family, filled with love and blessings.', 253, 45, 84),
(5, 'The wedding of William and Emma was beautiful and romantic. Everything was perfect, from the ceremony to the reception. Wishing them a lifetime of love and happiness!', 117, 46, 43),
(5, 'Ava 12th birthday celebration was fantastic! The party was a hit with the kids, and everyone had a great time. Well done on creating a memorable event!', 221, 47, 56),
(4, 'The corporate party was a success! The event was well-organized, and the venue was impressive. A great opportunity to network and celebrate achievements.', 268, 48, 76),
(5, 'The rock music festival was epic! The lineup was fantastic, and the atmosphere was electric. A night filled with great music and unforgettable memories!', 187, 49, 31),
(4, 'The grand opening of XYZ Museum was impressive! The exhibits were fascinating, and the event was well-attended. Looking forward to exploring the museum further!', 82, 50, 54),
(4, 'The blessing ceremony for baby Olivia was touching and heartfelt. It was a joyous occasion for the family, filled with love and blessings.', 129, 51, 89),
(5, 'The wedding of Michael and Sophia was a dream come true! Everything was perfect, from the vows to the reception. Wishing them a lifetime of love and happiness!', 296, 52, 74),
(5, 'Jacob 7th birthday party was a blast! The kids had a great time with the games and activities. Well done on organizing a fun and memorable celebration!', 178, 53, 67),
(4, 'The birthday bash was lively and entertaining! The decorations were festive, and the music kept everyone dancing all night. A fantastic celebration!', 61, 54, 35),
(5, 'The music festival was phenomenal! The lineup was incredible, and the atmosphere was electric. A night filled with great music and unforgettable memories!', 242, 55, 72),
(4, 'The grand opening of XYZ Club was a hit! The venue looks stylish, and the atmosphere was lively. Looking forward to many more nights of fun and entertainment!', 289, 56, 47),
(4, 'The blessing ceremony for baby Liam was heartwarming and joyful. It was a special moment for the family, filled with love and blessings.', 153, 57, 86),
(5, 'The wedding of David and Olivia was magical! Everything was perfect, from the ceremony to the reception. Wishing them a lifetime of love and happiness!', 98, 58, 39),
(5, 'Emily 18th birthday celebration was a blast! The party was lively, and everyone had a great time. Well done on creating a memorable event!', NULL, 59, 52),
(4, 'The holiday party was festive and fun! The decorations were beautiful, and the atmosphere was cheerful. A great way to celebrate the season with friends and colleagues.', 283, 60, 78),
(5, 'The jazz festival was fantastic! The performers were talented, and the music was soothing. A night filled with great music and good vibes!', 236, 61, 21),
(4, 'The grand opening of XYZ Gym was impressive! The facilities look top-notch, and the atmosphere was energetic. Excited to start working out here!', 113, 62, 47),
(4, 'The naming ceremony for baby Noah was touching and heartfelt. It was a joyous occasion for the family, filled with love and blessings.', 298, 63, 69),
(5, 'The wedding of James and Isabella was a fairy tale come true! Everything was perfect, from the vows to the reception. Wishing them a lifetime of love and happiness!', 197, 64, 58),
(5, 'Ethan 5th birthday celebration was fantastic! The party was a hit with the kids, and everyone had a great time. Well done on creating a memorable event!', 212, 65, 43),
(4, 'The house party was lively and entertaining! The atmosphere was relaxed, and the music kept everyone dancing all night. A great way to unwind with friends!', 94, 66, 37),
(5, 'The classical music concert was breathtaking! The performances were exquisite, and the venue was perfect for the occasion. A night of pure musical delight!', NULL, 67, 35),
(4, 'The grand opening of XYZ Spa was impressive! The facilities look luxurious, and the atmosphere was tranquil. Excited to indulge in some pampering here!', 176, 68, 49),
(4, 'The blessing ceremony for baby Lily was touching and heartfelt. It was a special moment for the family, filled with love and blessings.', 125, 69, 63),
(5, 'The wedding of Benjamin and Olivia was magical! Everything was perfect, from the ceremony to the reception. Wishing them a lifetime of love and happiness!', 264, 70, 82),
(5, 'Mia 10th birthday celebration was fantastic! The party was a hit with the kids, and everyone had a great time. Well done on creating a memorable event!', NULL, 71, 23),
(3, 'The naming ceremony for baby Ethan was touching and heartfelt. It was wonderful to witness the joy and love of the family. Congratulations!', 298, 72, 68),
(4, 'The wedding of James and Isabella was a beautiful celebration of love and commitment. Everything was perfect, from the ceremony to the reception. Wishing them a lifetime of happiness together!', 197, 73, 58),
(5, 'Ethan''s 5th birthday celebration was fantastic! The party was a hit with the kids, and everyone had a great time. Well done on creating a memorable event!', 212, 74, 43),
(4, 'The house party was lively and entertaining! The atmosphere was relaxed, and the music kept everyone dancing all night. A great way to unwind with friends!', 94, 75, 37),
(5, 'The classical music concert was breathtaking! The performances were exquisite, and the venue was perfect for the occasion. A night of pure musical delight!', NULL, 76, 35),
(4, 'The grand opening of XYZ Spa was impressive! The facilities look luxurious, and the atmosphere was tranquil. Excited to indulge in some pampering here!', 176, 77, 49),
(4, 'The blessing ceremony for baby Lily was touching and heartfelt. It was a special moment for the family, filled with love and blessings.', 125, 78, 63),
(5, 'The wedding of Benjamin and Olivia was magical! Everything was perfect, from the ceremony to the reception. Wishing them a lifetime of love and happiness!', 264, 79, 82),
(5, 'Mia''s 10th birthday celebration was fantastic! The party was a hit with the kids, and everyone had a great time. Well done on creating a memorable event!', NULL, 80, 23),
(4, 'The birthday celebration was enjoyable, but there were some issues with the catering service. Overall, a decent event.', 143, 81, 76),
(3, 'The opening ceremony was lackluster. The speeches were too long, and there was not much excitement. Disappointing overall.', 102, 82, 53),
(5, 'The marriage ceremony was beautiful and romantic. John and Emily looked radiant, and the venue was stunning. A day to remember!', 221, 83, 38),
(4, 'The naming ceremony was heartwarming, although the event felt a bit disorganized at times. Baby Emma stole the show, though!', 4, 84, 77),
(5, 'The concert was phenomenal! The XYZ band rocked the house, and the crowd was on their feet the whole time. Can not wait for the next one!', 67, 85, 14),
(3, 'The party for Johns graduation was okay, but it lacked excitement. The venue could have been better, and the music was not great.', 287, 86, 26),
(4, 'The office conference was informative, but some of the sessions were too long. Overall, a good event with valuable insights.', 156, 87, 63),
(3, 'The product launch was underwhelming. The presentation felt rushed, and there was not much enthusiasm from the audience.', 9, 88, 52),
(5, 'The charity fundraiser event was a huge success! We surpassed our fundraising goal, thanks to the generosity of the community. Well done!', 198, 89, 46),
(4, 'Alice''s 10th birthday party was fun, but there were some issues with the entertainment. Overall, a decent celebration.', 47, 90, 83),
(4, 'The naming ceremony for baby Noah was touching, although there were some delays in the schedule. Overall, a lovely event.', 83, 91, 37),
(5, 'The jazz night concert was fantastic! The music was smooth, and the atmosphere was laid-back. A perfect evening for jazz lovers!', 17, 92, 14),
(3, 'The summer pool party was chaotic. The venue was overcrowded, and there were not enough activities to keep everyone entertained.', 255, 93, 69),
(4, 'The grand opening of ABC Mall was impressive, although the event felt a bit rushed. Overall, a successful opening.', 176, 94, 22),
(5, 'The wedding of Michael and Olivia was magical! Everything was perfect, from the venue to the decorations. A dream wedding come true!', 298, 95, 61),
(5, 'David''s 5th birthday party was a blast! The kids had a great time playing games and eating cake. A memorable celebration!', 142, 96, 26),
(3, 'The annual sales conference was informative, but some of the presentations were dry. Overall, a decent event with room for improvement.', 156, 97, 47),
(4, 'The product launch generated a lot of buzz, but the event felt a bit rushed. Overall, a successful launch.', 224, 98, 34),
(3, 'The community cleanup event was disorganized. There was not clear direction, and it was hard to know what to do.', 56, 99, 68),
(5, 'The farewell party for Sarah was emotional and heartfelt. She will be missed by all of us. Wishing her the best in her future endeavors!', 201, 100, 54);




INSERT INTO tasks VALUES 
('Complete project proposal by Friday'),
('Schedule team meeting for next week'),
('Review and approve budget report'),
('Prepare presentation for client meeting'),
('Follow up with vendors for quotations'),
('Research latest industry trends'),
('Draft agenda for upcoming conference'),
('Organize files and documents'),
('Coordinate logistics for event setup'),
('Compile feedback from recent event'),
('Update project timeline and milestones'),
('Conduct performance review with team members'),
('Analyze market competition'),
('Create marketing campaign plan'),
('Brainstorm new product ideas');

--select * from clients;
--FOR POWERAPPS 

-- INSERT INTO pending_bookings VALUES 
-- ('Wedding Ceremony','Jhon'),
-- ('Birthday','Emily'),
-- ('Funeral','Jennifer');




--select * from pending_bookings;

-- Inserting data into event_requests table
INSERT INTO event_requests (requesting_client_name, requesting_client_id, event_date, event_guest_count, request_approved_client_id, request_approved_date, request_event_description)
VALUES 
('ABC Corporation', 1, '2024-06-15', 100, NULL, NULL, 'Annual Conference focused on industry trends and innovations.'),
('XYZ Ltd.', 2, '2024-07-20', 150, NULL, NULL, 'Product Launch Event introducing our latest product line to clients and partners.'),
('Sunset Enterprises', 3, '2024-08-10', 200, NULL, NULL, 'Company Anniversary Celebration marking 10 years of success and growth.');


select * from event_requests;