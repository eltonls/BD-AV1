-----------------------------------------------------------------------------------------------------
-- Criando um Banco de Dados Teste!
-----------------------------------------------------------------------------------------------------
USE [master];
GO

CREATE DATABASE [SQLTestDB];
GO

USE [SQLTestDB];
GO
CREATE TABLE SQLTest (
    ID INT NOT NULL PRIMARY KEY,
    c1 VARCHAR(100) NOT NULL,
    dt1 DATETIME NOT NULL DEFAULT GETDATE()
);
GO

USE [SQLTestDB]
GO

INSERT INTO SQLTest (ID, c1) VALUES (1, 'test1');
INSERT INTO SQLTest (ID, c1) VALUES (2, 'test2');
INSERT INTO SQLTest (ID, c1) VALUES (3, 'test3');
INSERT INTO SQLTest (ID, c1) VALUES (4, 'test4');
INSERT INTO SQLTest (ID, c1) VALUES (5, 'test5');
GO

SELECT * FROM SQLTest;
GO