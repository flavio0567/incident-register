BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[users] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [is_solved] BIT NOT NULL CONSTRAINT [users_is_solved_df] DEFAULT 0,
    [create_at] DATETIME2 NOT NULL CONSTRAINT [users_create_at_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [users_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[equipments] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000),
    [department] NVARCHAR(1000),
    [area] NVARCHAR(1000),
    [create_at] DATETIME2 NOT NULL CONSTRAINT [equipments_create_at_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [equipments_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[solutions] (
    [id] NVARCHAR(1000) NOT NULL,
    [descripton] NVARCHAR(1000) NOT NULL,
    [solver_id] NVARCHAR(1000) NOT NULL,
    [create_at] DATETIME2 NOT NULL CONSTRAINT [solutions_create_at_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [solutions_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[incidents] (
    [id] NVARCHAR(1000) NOT NULL,
    [action] NVARCHAR(1000) NOT NULL,
    [date_solution] DATETIME2 NOT NULL,
    [equipment_id] NVARCHAR(1000) NOT NULL,
    [user_id] NVARCHAR(1000) NOT NULL,
    [solution_id] NVARCHAR(1000) NOT NULL,
    [create_at] DATETIME2 NOT NULL CONSTRAINT [incidents_create_at_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [incidents_pkey] PRIMARY KEY ([id])
);

-- AddForeignKey
ALTER TABLE [dbo].[solutions] ADD CONSTRAINT [solutions_solver_id_fkey] FOREIGN KEY ([solver_id]) REFERENCES [dbo].[users]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[incidents] ADD CONSTRAINT [incidents_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[incidents] ADD CONSTRAINT [incidents_equipment_id_fkey] FOREIGN KEY ([equipment_id]) REFERENCES [dbo].[equipments]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[incidents] ADD CONSTRAINT [incidents_solution_id_fkey] FOREIGN KEY ([solution_id]) REFERENCES [dbo].[solutions]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
