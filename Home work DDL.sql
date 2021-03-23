--1 
CREATE DATABASE BookStore

CREATE TABLE [Editors] (
	eu_id integer,
	ed_lname varchar(255) NOT NULL,
	ed_fname varchar(255) NOT NULL,
	phone integer NOT NULL,
	address varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	state varchar(255) NOT NULL,
	zip integer NOT NULL,
  CONSTRAINT [PK_EDITORS] PRIMARY KEY CLUSTERED
  (
  [eu_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [authors] (
	au_id integer,
	au_lname varchar(255) NOT NULL,
	au_fname varchar(255) NOT NULL,
	phone integer NOT NULL,
	adress varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	state varchar(255) NOT NULL,
	zip integer NOT NULL,
  CONSTRAINT [PK_AUTHORS] PRIMARY KEY CLUSTERED
  (
  [au_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [titleauthors] (
	au_id integer NOT NULL,
	title_id integer NOT NULL
)
GO
CREATE TABLE [titleeditors] (
	eu_id integer NOT NULL,
	title_id integer NOT NULL
)
GO
CREATE TABLE [titles] (
	title_id integer NOT NULL,
	title varchar(255) NOT NULL,
	pub_id integer NOT NULL,
	price float NOT NULL,
	notes text NOT NULL,
	pubdate datetime NOT NULL,
  CONSTRAINT [PK_TITLES] PRIMARY KEY CLUSTERED
  (
  [title_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [publishers] (
	pub_id integer NOT NULL,
	pub_name varchar(255) NOT NULL,
	address varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	state varchar(255) NOT NULL,
  CONSTRAINT [PK_PUBLISHERS] PRIMARY KEY CLUSTERED
  (
  [pub_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [salesdetails] (
	sonum integer NOT NULL,
	title_id integer NOT NULL,
	qty_ordered integer NOT NULL,
	qty_shipped integer NOT NULL,
	date_shipped datetime NOT NULL
)
GO
CREATE TABLE [sales] (
	sonum integer NOT NULL,
	sdate datetime NOT NULL,
  CONSTRAINT [PK_SALES] PRIMARY KEY CLUSTERED
  (
  [sonum] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO


ALTER TABLE [titleauthors] WITH CHECK ADD CONSTRAINT [titleauthors_fk0] FOREIGN KEY ([au_id]) REFERENCES [authors]([au_id])
ON UPDATE CASCADE
GO
ALTER TABLE [titleauthors] CHECK CONSTRAINT [titleauthors_fk0]
GO
ALTER TABLE [titleauthors] WITH CHECK ADD CONSTRAINT [titleauthors_fk1] FOREIGN KEY ([title_id]) REFERENCES [titles]([title_id])
ON UPDATE CASCADE
GO
ALTER TABLE [titleauthors] CHECK CONSTRAINT [titleauthors_fk1]
GO

ALTER TABLE [titleeditors] WITH CHECK ADD CONSTRAINT [titleeditors_fk0] FOREIGN KEY ([eu_id]) REFERENCES [Editors]([eu_id])
ON UPDATE CASCADE
GO
ALTER TABLE [titleeditors] CHECK CONSTRAINT [titleeditors_fk0]
GO
ALTER TABLE [titleeditors] WITH CHECK ADD CONSTRAINT [titleeditors_fk1] FOREIGN KEY ([title_id]) REFERENCES [titles]([title_id])
ON UPDATE CASCADE
GO
ALTER TABLE [titleeditors] CHECK CONSTRAINT [titleeditors_fk1]
GO

ALTER TABLE [titles] WITH CHECK ADD CONSTRAINT [titles_fk0] FOREIGN KEY ([pub_id]) REFERENCES [publishers]([pub_id])
ON UPDATE CASCADE
GO
ALTER TABLE [titles] CHECK CONSTRAINT [titles_fk0]
GO


ALTER TABLE [salesdetails] WITH CHECK ADD CONSTRAINT [salesdetails_fk0] FOREIGN KEY ([sonum]) REFERENCES [sales]([sonum])
ON UPDATE CASCADE
GO
ALTER TABLE [salesdetails] CHECK CONSTRAINT [salesdetails_fk0]
GO
ALTER TABLE [salesdetails] WITH CHECK ADD CONSTRAINT [salesdetails_fk1] FOREIGN KEY ([title_id]) REFERENCES [titles]([title_id])
ON UPDATE CASCADE
GO
ALTER TABLE [salesdetails] CHECK CONSTRAINT [salesdetails_fk1]
GO

--2
ALTER TABLE authors
ADD birthdate datetime 

ALTER TABLE publishers
ALTER COLUMN state char(2)

ALTER TABLE titles
DROP COLUMN notes

--3

CREATE INDEX euidind on Editors (eu_id)

DROP INDEX euidind on Editors

CREATE INDEX sdateinx  on sales (sdate)

ALTER INDEX sdateinx  on sales DISABLE

ALTER INDEX sdateinx  on sales REBUILD

--4
DROP TABLE sales