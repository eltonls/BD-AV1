-----------------------------------------------------------------------------------------------------
-- A Criação de Um Dispositivo de Backup
-----------------------------------------------------------------------------------------------------
DECLARE @Current_Date DATETIME;
DECLARE @pname varchar(300);
SET @Current_Date = SYSDATETIME();
set @pname = (select 'C:\WEEKLY_EXPORTS\TEST_DB_BACKUP' + replace(CONVERT(varchar,@Current_Date, 20), ':', '_') + '.bak' );
EXEC sp_addumpdevice @devtype = 'disk',
@logicalname = 'WEEKLY_BACKUP',
@physicalname = @pname;
GO

USE [master];
GO
BACKUP DATABASE [SQLTestDB]
TO @pname
WITH NOFORMAT, NOINIT,
NAME = N'SQLTestDB-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO

-----------------------------------------------------------------------------------------------------
-- Propriedades da Operação de BACKUP
-----------------------------------------------------------------------------------------------------

-- NOINIT: Especifica que esse backup deve ser adicionado ao resto e no sobrescrever os antigos.
-- INIT: Sobrescreve os backups antigos

-- { SKIP | NOSKIP }: Controla se a operação de backup checa a data de expiração antes de sobrescrever
-- { FORMAT | NOFORMAT }: Define se o cabeçalho de mídia deve ser escrito nos volumes usados nessa operação 
-- Para sobrescrever qualquer cabealho de mdia e conjunto de backups.

-- REWIND: Define que o SQL Server liberar e rebobinar a fita. REWIND  o PADRO
-- NOREWIND: Define que o SQL vai manter a fita aberta depois da operao de Backup.

-----------------------------------------------------------------------------------------------------
-- Backup Diferencial
-----------------------------------------------------------------------------------------------------

-- BACKUP DIFERENCIAL COM TSQL
-- Lembrando que s  possvel fazer backup diferencial se houver ao menos um backup completo.
BACKUP DATABASE SQLTestDB  
   TO DISK = N'C:\Users\Public\Backup\SQLTestDB.bak'
   WITH DIFFERENTIAL;  
GO  

USE SQLTestDB

-- Adicionando novos dados
INSERT INTO SQLTest (ID, c1) VALUES (6, 'newtest1');
INSERT INTO SQLTest (ID, c1) VALUES (7, 'newtest2');
INSERT INTO SQLTest (ID, c1) VALUES (8, 'newtest3');
INSERT INTO SQLTest (ID, c1) VALUES (9, 'newtest4');
INSERT INTO SQLTest (ID, c1) VALUES (10, 'newtest5');
GO

-- Fazendo backup diferencial
BACKUP DATABASE SQLTestDB  
   TO @pname
   WITH DIFFERENTIAL;  
GO