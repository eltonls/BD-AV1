-- Crie um novo job
EXEC msdb.dbo.sp_add_job
    @job_name = 'BackupSQLTestDB';

-- Defina o proprietário do job (substitua 'SeuProprietario' pelo nome do proprietário desejado)
EXEC msdb.dbo.sp_add_jobserver
    @job_name = 'BackupSQLTestDB',
    @server_name = N'(local)';

-- Crie um novo passo no job
EXEC msdb.dbo.sp_add_jobstep
    @job_name = 'BackupSQLTestDB',
    @step_id = 1,
    @step_name = 'Backup Passo',
    @subsystem = 'TSQL',
    @command = '
    USE SQLTestDB;
    BACKUP DATABASE SQLTestDB
    TO DISK = ''C:\CaminhoParaBackup\BackupCompletoSemanal.bak''
    WITH FORMAT, MEDIANAME = ''MeuBackup'', NAME = ''Backup Completo do Meu Banco de Dados'';',
    @database_name = 'master';

-- Crie um novo agendamento para o job
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = 'AgendamentoSemanal',
    @freq_type = 4, -- Frequência semanal
    @freq_interval = 1, -- Toda semana
    @active_start_time = 10000, -- Hora de início (por exemplo, 10:00 AM)
    @active_end_time = 235959, -- Hora de término (por exemplo, 11:59:59 PM);

-- Associe o agendamento ao job
EXEC msdb.dbo.sp_attach_schedule
    @job_name = 'BackupSQLTestDB',
    @schedule_name = 'AgendamentoSemanal';

-- Ative o job
EXEC msdb.dbo.sp_update_job
    @job_name = 'BackupSQLTestDB',
    @enabled = 1;
