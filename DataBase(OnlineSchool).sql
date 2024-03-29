USE OnlineSchool
	GO
	

	if object_id('User_access_level') is null
	BEGIN
	CREATE TABLE User_access_level
	(
		ID_level INT PRIMARY KEY IDENTITY,
		Type_of_access NVARCHAR(30) NOT NULL
	);
	END
	if object_id('Registration') is null
	BEGIN
	Create TABLE Registration
	(
		ID_registration INT PRIMARY KEY IDENTITY,
		Login NVARCHAR(20) UNIQUE,
		Password NVARCHAR(20) UNIQUE,
		ID_level INT
	);

	ALTER TABLE Registration
	ADD FOREIGN KEY(ID_level) REFERENCES User_access_level(ID_level);
	END
	if object_id('Pupils') is null
	BEGIN
	CREATE TABLE Pupils
	(
		ID_pupil INT PRIMARY KEY IDENTITY,
		Passport NVARCHAR(20) UNIQUE,
		Name NVARCHAR(50) NOT NULL,
		Balance NVARCHAR(20),
		ID_registration INT
	);

	ALTER TABLE Pupils
	ADD FOREIGN KEY(ID_registration) REFERENCES Registration(ID_registration);
	END
	if object_id('Payment') is null
	BEGIN
	CREATE TABLE Payment
	(
		ID_payment INT PRIMARY KEY IDENTITY,
		ID_pupil INT,
		Type NVARCHAR(20) NOT NULL,
		Summa DECIMAL,
		ID_discount INT,
		After_discount DECIMAL
	);

	ALTER TABLE Payment
	ADD FOREIGN KEY(ID_pupil) REFERENCES Pupils(ID_pupil);
	END
	if object_id('Discount') is null
	BEGIN
	CREATE TABLE Discount
	(
		ID_discount INT PRIMARY KEY IDENTITY,
		Size DECIMAL NOT NULL,
	);

	ALTER TABLE Payment
	ADD FOREIGN KEY(ID_discount) REFERENCES Discount(ID_discount);
	END
	if object_id('List_pupil') is null
	BEGIN
	CREATE TABLE List_pupil
	(
		ID_ls_pupil INT PRIMARY KEY IDENTITY,
		ID_pupil INT,
		ID_language INT,
		Language_level NVARCHAR(20) NOT NULL
	);

	ALTER TABLE List_pupil
	ADD FOREIGN KEY(ID_pupil) REFERENCES Pupils(ID_pupil);
	END
	if object_id('Language') is null
	BEGIN
		CREATE TABLE Language
	(
		ID_language INT PRIMARY KEY IDENTITY,
		Name NVARCHAR(20) NOT NULL
	);

	ALTER TABLE List_pupil
	ADD FOREIGN KEY(ID_language) REFERENCES Language(ID_language);
	END
	if object_id('Teacher') is null
	BEGIN
		CREATE TABLE Teacher
	(
		ID_teacher INT PRIMARY KEY IDENTITY,
		Name NVARCHAR(20) NOT NULL,
		Description NVARCHAR(20) NOT NULL,
		ID_registration INT
	);

	ALTER TABLE Teacher
	ADD FOREIGN KEY(ID_registration) REFERENCES Registration(ID_registration);
	END
	if object_id('List_teacher') is null
	BEGIN
	CREATE TABLE List_teacher
	(
		ID_ls_teacher INT PRIMARY KEY IDENTITY,
		ID_teacher INT,
		ID_language INT,
		Experience NVARCHAR(20) NOT NULL,
		Cost DECIMAL
	);

	ALTER TABLE List_teacher
	ADD FOREIGN KEY(ID_teacher) REFERENCES Teacher(ID_teacher);

	ALTER TABLE List_teacher
	ADD FOREIGN KEY(ID_language) REFERENCES Language(ID_language);
	END
	if object_id('Lesson') is null
	BEGIN
		CREATE TABLE Lesson
	(
		ID_lesson INT PRIMARY KEY IDENTITY,
		ID_language INT,
		Subject_matter NVARCHAR(100) NOT NULL
	);

	ALTER TABLE Lesson
	ADD FOREIGN KEY(ID_language) REFERENCES Language(ID_language);
	END

	if object_id('Shedule') is null
	BEGIN
	CREATE TABLE Shedule
	(
		ID INT PRIMARY KEY IDENTITY,
		ID_lesson INT,
		ID_teacher INT,
		ID_pupil INT,
		Lesson_status NVARCHAR(20),
		Date DATE,
		Time TIME
	);

	ALTER TABLE Shedule
	ADD FOREIGN KEY(ID_teacher) REFERENCES Teacher(ID_teacher);

	ALTER TABLE Shedule
	ADD FOREIGN KEY(ID_lesson) REFERENCES Lesson(ID_lesson);

	ALTER TABLE Shedule
	ADD FOREIGN KEY(ID_pupil) REFERENCES Pupils(ID_pupil);
	END
	if object_id('Statement') is null
	BEGIN
	CREATE TABLE Statement
	(
		ID_statement INT PRIMARY KEY IDENTITY,
		ID INT,
		ID_pupil INT,
		Comment NVARCHAR(100)
	);

	ALTER TABLE Statement
	ADD FOREIGN KEY(ID) REFERENCES Shedule(ID);

	ALTER TABLE Statement
	ADD FOREIGN KEY(ID_pupil) REFERENCES Pupils(ID_pupil);
	END
