CREATE DATABASE InsuranceServices
GO

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
	id_resultCarProperty integer NOT NULL,
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


--Виды транспорта
CREATE TABLE [CarType] (
	id integer NOT NULL,
	Type varchar(20) NOT NULL,
  CONSTRAINT [PK_CARTYPE] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Свойства транспорта + коефициент
CREATE TABLE [CarTypeProperty] (
	id integer NOT NULL,
	Name varchar(3) NOT NULL,
	Coef decimal(3,2) NOT NULL,
  CONSTRAINT [PK_CARTYPEPROPERTY] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Соответствия свойства и типа машины
CREATE TABLE [ResultCarProperty] (
	id integer NOT NULL,
	id_carType integer NOT NULL,
	id_carTypeProperty integer NOT NULL,
  CONSTRAINT [PK_RESULTCARPROPERTY] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Зоны регистрации авто(1 Зона, ... , 7 Зона)
CREATE TABLE [ZonesOfRegister] (
	id integer NOT NULL,
	Name varchar(6) NOT NULL,
  CONSTRAINT [PK_ZONESOFREGISTER] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Города регистрации авто по зонам(Киев - 1 Зона, ..., Макаров - 6 Зона)
CREATE TABLE [CitiesOfRegistrations] (
	id integer NOT NULL,
	Name varchar(30) NOT NULL,
	id_zoneOfRegistration integer NOT NULL,
  CONSTRAINT [PK_CITIESOFREGISTRATIONS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Страховые компании(ТАС, АХА, ...)
CREATE TABLE [Companies] (
	id integer NOT NULL,
	Name varchar(50) NOT NULL,
	WorkWithTaxi bit NOT NULL,
  CONSTRAINT [PK_COMPANIES] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Коефициенты для зон регистрации ТС
CREATE TABLE [CoefByZone] (
	id integer NOT NULL,
	id_zoneOfRegister integer NOT NULL,
	id_company integer NOT NULL,
	Coef decimal(3,2) NOT NULL,
  CONSTRAINT [PK_COEFBYZONE] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Выгодно ли делать договор по этой компании для этой зоны регистрации
CREATE TABLE [IsProfit] (
	id integer NOT NULL,
	id_zoneOfRegister integer NOT NULL,
	id_company integer NOT NULL,
	Profitable bit NOT NULL,
  CONSTRAINT [PK_ISPROFIT] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Коефициент для сферы использования ТС(физ ? юр)
CREATE TABLE [CoefBySphere] (
	id integer NOT NULL,
	id_company integer NOT NULL,
	IsIndividual bit NOT NULL,
	Coef decimal(3,2) NOT NULL,
  CONSTRAINT [PK_COEFBYSPHERE] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Коефициент для стажа вождения (зависит от компании и страхователь (физ ? юр))
CREATE TABLE [CoefByExperience] (
	id integer NOT NULL,
	id_company integer NOT NULL,
	id_coefBySphere integer NOT NULL,
	Coef decimal(3,2) NOT NULL,
  CONSTRAINT [PK_COEFBYEXPERIENCE] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Коефициент для периода использования ТС
CREATE TABLE [CoefByTerm] (
	id integer NOT NULL,
	DurationOfTerm integer NOT NULL,
	Coef decimal(3,2) NOT NULL,
  CONSTRAINT [PK_COEFBYTERM] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Виды скидок за безубыточность
CREATE TABLE [BonusMalusInfo] (
	id integer NOT NULL,
	Name varchar(5) NOT NULL,
	Value decimal(3,2) NOT NULL,
  CONSTRAINT [PK_BONUSMALUSINFO] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Коефициенты за безубыточность(зависят от компании и многих других факторов)
CREATE TABLE [CoefByBonusMalus] (
	id integer NOT NULL,
	id_zoneOfRegister integer NOT NULL,
	id_bmInfo integer NOT NULL,
	id_franchiseBC integer NOT NULL,
	IsPrivileges bit NOT NULL,
  CONSTRAINT [PK_COEFBYBONUSMALUS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
--Франшиза пот компаниям
CREATE TABLE [FranchiseByCompany] (
	id integer NOT NULL,
	id_company integer NOT NULL,
	Value integer NOT NULL,
  CONSTRAINT [PK_FRANCHISEBYCOMPANY] PRIMARY KEY CLUSTERED
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
ALTER TABLE [Cars] WITH CHECK ADD CONSTRAINT [Cars_fk1] FOREIGN KEY ([id_resultCarProperty]) REFERENCES [ResultCarProperty]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [Cars] CHECK CONSTRAINT [Cars_fk1]
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

ALTER TABLE [ResultCarProperty] WITH CHECK ADD CONSTRAINT [ResultCarProperty_fk0] FOREIGN KEY ([id_carType]) REFERENCES [CarType]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [ResultCarProperty] CHECK CONSTRAINT [ResultCarProperty_fk0]
GO
ALTER TABLE [ResultCarProperty] WITH CHECK ADD CONSTRAINT [ResultCarProperty_fk1] FOREIGN KEY ([id_carTypeProperty]) REFERENCES [CarTypeProperty]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [ResultCarProperty] CHECK CONSTRAINT [ResultCarProperty_fk1]
GO


ALTER TABLE [CitiesOfRegistrations] WITH CHECK ADD CONSTRAINT [CitiesOfRegistrations_fk0] FOREIGN KEY ([id_zoneOfRegistration]) REFERENCES [ZonesOfRegister]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CitiesOfRegistrations] CHECK CONSTRAINT [CitiesOfRegistrations_fk0]
GO


ALTER TABLE [CoefByZone] WITH CHECK ADD CONSTRAINT [CoefByZone_fk0] FOREIGN KEY ([id_zoneOfRegister]) REFERENCES [ZonesOfRegister]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefByZone] CHECK CONSTRAINT [CoefByZone_fk0]
GO
ALTER TABLE [CoefByZone] WITH CHECK ADD CONSTRAINT [CoefByZone_fk1] FOREIGN KEY ([id_company]) REFERENCES [Companies]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefByZone] CHECK CONSTRAINT [CoefByZone_fk1]
GO

ALTER TABLE [IsProfit] WITH CHECK ADD CONSTRAINT [IsProfit_fk0] FOREIGN KEY ([id_zoneOfRegister]) REFERENCES [ZonesOfRegister]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [IsProfit] CHECK CONSTRAINT [IsProfit_fk0]
GO
ALTER TABLE [IsProfit] WITH CHECK ADD CONSTRAINT [IsProfit_fk1] FOREIGN KEY ([id_company]) REFERENCES [Companies]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [IsProfit] CHECK CONSTRAINT [IsProfit_fk1]
GO

ALTER TABLE [CoefBySphere] WITH CHECK ADD CONSTRAINT [CoefBySphere_fk0] FOREIGN KEY ([id_company]) REFERENCES [Companies]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefBySphere] CHECK CONSTRAINT [CoefBySphere_fk0]
GO

ALTER TABLE [CoefByExperience] WITH CHECK ADD CONSTRAINT [CoefByExperience_fk0] FOREIGN KEY ([id_company]) REFERENCES [Companies]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefByExperience] CHECK CONSTRAINT [CoefByExperience_fk0]
GO
ALTER TABLE [CoefByExperience] WITH CHECK ADD CONSTRAINT [CoefByExperience_fk1] FOREIGN KEY ([id_coefBySphere]) REFERENCES [CoefBySphere]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefByExperience] CHECK CONSTRAINT [CoefByExperience_fk1]
GO



ALTER TABLE [CoefByBonusMalus] WITH CHECK ADD CONSTRAINT [CoefByBonusMalus_fk0] FOREIGN KEY ([id_zoneOfRegister]) REFERENCES [ZonesOfRegister]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefByBonusMalus] CHECK CONSTRAINT [CoefByBonusMalus_fk0]
GO
ALTER TABLE [CoefByBonusMalus] WITH CHECK ADD CONSTRAINT [CoefByBonusMalus_fk1] FOREIGN KEY ([id_bmInfo]) REFERENCES [BonusMalusInfo]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefByBonusMalus] CHECK CONSTRAINT [CoefByBonusMalus_fk1]
GO
ALTER TABLE [CoefByBonusMalus] WITH CHECK ADD CONSTRAINT [CoefByBonusMalus_fk2] FOREIGN KEY ([id_franchiseBC]) REFERENCES [FranchiseByCompany]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [CoefByBonusMalus] CHECK CONSTRAINT [CoefByBonusMalus_fk2]
GO

ALTER TABLE [FranchiseByCompany] WITH CHECK ADD CONSTRAINT [FranchiseByCompany_fk0] FOREIGN KEY ([id_company]) REFERENCES [Companies]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [FranchiseByCompany] CHECK CONSTRAINT [FranchiseByCompany_fk0]
GO

