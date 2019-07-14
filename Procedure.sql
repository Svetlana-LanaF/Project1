-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE <Procedure_Name, sysname, ProcedureName> 
	-- Add the parameters for the stored procedure here
	<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
END
GO

USE OnlineSchool
GO

CREATE PROCEDURE [dbo].[Reg]
	@Login NVARCHAR(50)=null,
	@Password NVARCHAR(50)=null,
	@Level NVARCHAR(50)
AS
	declare @id int;
BEGIN
	if  @Login is null OR @Password is null
	return 1
	else
	if (SELECT Login
	FROM dbo.Registration
	Where Login = @Login)=@Login
	return 2
	else
	Begin
	set @id = (Select ID_level
	From User_access_level
	Where Type_of_access = @Level)
	Insert into Registration VALUES ( @Login, @Password, @id)
	End
END
GO

Create procedure [dbo].[LK]
	@Login nvarchar(20),
	@Passport nvarchar(20) = null,
	@Name Nvarchar(20),
	@Balance Nvarchar(20) = null,
	@Description Nvarchar(20) = null
AS
	declare @id int;
	declare @access int;
Begin
	Begin
		set @id = (Select ID_Registration
		From Registration
		Where Login = @Login)

		set @access = (Select ID_level
		From Registration
		Where Login = @Login)

		IF (@access = 1)

		Insert into Pupils VALUES (@Passport, @Name, @Balance, @id)
		Else
		INSERT INTO Teacher VALUES (@Name, @Description, @id)
	End
End
Go