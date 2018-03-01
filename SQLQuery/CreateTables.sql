CREATE TABLE Clients (
	id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	LastName nvarchar(30) NOT NULL,
	Name nvarchar(20) NOT NULL,
	FatherName nvarchar(25),
	BirthDate date NOT NULL,
	Address nvarchar(128) NOT NULL,
	Phone nvarchar(13) NOT NULL,
	IdentityNumber nvarchar(10)
);
GO

CREATE TABLE DocumentType (
	id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Type nvarchar(50) NOT NULL
);
GO

CREATE TABLE ClientsDocument(
	id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	id_documentType int NOT NULL FOREIGN KEY REFERENCES DocumentType(id),
	Seria nvarchar(5),
	Number nvarchar(10) NOT NULL,
	DateOfIssue date NOT NULL,
	AgencyWhoIssued nvarchar(80)
);
GO
