-- Общие данные для юр и физ лиц = Клиенты
CREATE TABLE [Clients] (
	id integer NOT NULL,
	id_individualClient integer,
	id_entityClient integer,
	Address varchar(128) NOT NULL,
	Phone varchar(13) NOT NULL,
  CONSTRAINT [PK_CLIENTS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Документ клиента
CREATE TABLE [ClientDocuments] (
	id integer NOT NULL,
	id_documentType integer NOT NULL,
	id_client integer NOT NULL,
	Seria varchar(7) NOT NULL,
	Number varchar(20) NOT NULL,
	DateOfIssue date NOT NULL,
	AgencyWhoIssue varchar(80) NOT NULL,
  CONSTRAINT [PK_CLIENTDOCUMENTS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Тип документа(паспорт, права, загран. паспорт ...)
CREATE TABLE [DocumentType] (
	id integer NOT NULL,
	Type varchar(50) NOT NULL,
  CONSTRAINT [PK_DOCUMENTTYPE] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Машины
CREATE TABLE [Cars] (
	id integer NOT NULL,
	id_clientInfo integer NOT NULL,
	id_resultCarInfo integer NOT NULL,
	PlateNumber varchar(10) NOT NULL,
	Mark varchar(30) NOT NULL,
	Model varchar(50) NOT NULL,
	YearOfIssue integer NOT NULL,
	VIN_Code varchar(17) NOT NULL,
	PlaceOfRegistration varchar(30) NOT NULL,
  CONSTRAINT [PK_CARS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Юридическое лицо
CREATE TABLE [EntityClient] (
	id integer NOT NULL,
	Name varchar(50) NOT NULL,
	EDRPOU varchar(8) NOT NULL,
  CONSTRAINT [PK_ENTITYCLIENT] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Физическое лицо
CREATE TABLE [IndividualClient] (
	id integer NOT NULL,
	LastName varchar(30) NOT NULL,
	Name varchar(20) NOT NULL,
	FatherName varchar(25),
	PersonalNumber varchar(10) NOT NULL,
	BirthDate date NOT NULL,
  CONSTRAINT [PK_INDIVIDUALCLIENT] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Тип машины (легковая, грузовая ...)
CREATE TABLE [CarType] (
	id integer NOT NULL,
	Type varchar(20) NOT NULL,
  CONSTRAINT [PK_CARTYPE] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Свойство машины (С1, С2, В1, А1 ...)
CREATE TABLE [CarTypeProperty] (
	id integer NOT NULL,
	Name varchar(3) NOT NULL,
  CONSTRAINT [PK_CARTYPEPROPERTY] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Соответствие типа и свойста машины (легковая - В1, ...)
CREATE TABLE [ResultCarInfo] (
	id integer NOT NULL,
	id_carType integer NOT NULL,
	id_carTypeProperty integer NOT NULL,
  CONSTRAINT [PK_RESULTCARINFO] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Договор
CREATE TABLE [Treaty] (
	id integer NOT NULL,
	id_client integer NOT NULL,
	id_car integer NOT NULL,
	id_company integer NOT NULL,
	DateBegin datetime NOT NULL,
	DateEnd datetime NOT NULL,
	InsuranceOfHealthLimit varchar(20) NOT NULL,
	InsuranceOfPropertyLimit varchar(20) NOT NULL,
	Franchise varchar(30) NOT NULL,
	DateOfPayment datetime NOT NULL,
	DateOfExecute date NOT NULL,
  CONSTRAINT [PK_TREATY] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
-- Заказ
CREATE TABLE [Orders] (
	id integer NOT NULL,
	id_treaty integer NOT NULL,
	DateOfOrder datetime NOT NULL,
  CONSTRAINT [PK_ORDERS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
ALTER TABLE [Clients] WITH CHECK ADD CONSTRAINT [Clients_fk0] FOREIGN KEY ([id_individualClient]) REFERENCES [IndividualClient]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Clients] CHECK CONSTRAINT [Clients_fk0]
GO
ALTER TABLE [Clients] WITH CHECK ADD CONSTRAINT [Clients_fk1] FOREIGN KEY ([id_entityClient]) REFERENCES [EntityClient]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Clients] CHECK CONSTRAINT [Clients_fk1]
GO

ALTER TABLE [ClientDocuments] WITH CHECK ADD CONSTRAINT [ClientDocuments_fk0] FOREIGN KEY ([id_documentType]) REFERENCES [DocumentType]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [ClientDocuments] CHECK CONSTRAINT [ClientDocuments_fk0]
GO
ALTER TABLE [ClientDocuments] WITH CHECK ADD CONSTRAINT [ClientDocuments_fk1] FOREIGN KEY ([id_client]) REFERENCES [IndividualClient]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [ClientDocuments] CHECK CONSTRAINT [ClientDocuments_fk1]
GO


ALTER TABLE [Cars] WITH CHECK ADD CONSTRAINT [Cars_fk0] FOREIGN KEY ([id_clientInfo]) REFERENCES [Clients]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Cars] CHECK CONSTRAINT [Cars_fk0]
GO
ALTER TABLE [Cars] WITH CHECK ADD CONSTRAINT [Cars_fk1] FOREIGN KEY ([id_resultCarInfo]) REFERENCES [ResultCarInfo]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Cars] CHECK CONSTRAINT [Cars_fk1]
GO





ALTER TABLE [ResultCarInfo] WITH CHECK ADD CONSTRAINT [ResultCarInfo_fk0] FOREIGN KEY ([id_carType]) REFERENCES [CarType]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [ResultCarInfo] CHECK CONSTRAINT [ResultCarInfo_fk0]
GO
ALTER TABLE [ResultCarInfo] WITH CHECK ADD CONSTRAINT [ResultCarInfo_fk1] FOREIGN KEY ([id_carTypeProperty]) REFERENCES [CarTypeProperty]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [ResultCarInfo] CHECK CONSTRAINT [ResultCarInfo_fk1]
GO

ALTER TABLE [Treaty] WITH CHECK ADD CONSTRAINT [Treaty_fk0] FOREIGN KEY ([id_client]) REFERENCES [Clients]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Treaty] CHECK CONSTRAINT [Treaty_fk0]
GO
ALTER TABLE [Treaty] WITH CHECK ADD CONSTRAINT [Treaty_fk1] FOREIGN KEY ([id_car]) REFERENCES [Cars]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Treaty] CHECK CONSTRAINT [Treaty_fk1]
GO

ALTER TABLE [Orders] WITH CHECK ADD CONSTRAINT [Orders_fk0] FOREIGN KEY ([id_treaty]) REFERENCES [Treaty]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Orders] CHECK CONSTRAINT [Orders_fk0]
GO

