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

