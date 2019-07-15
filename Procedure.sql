USE OnlineSchool
GO

CREATE or alter PROCEDURE [dbo].[sp_Reg]
	@Login NVARCHAR(50)=null,
	@Password NVARCHAR(50)=null,
	@Level NVARCHAR(50)
AS
	declare @id int;
BEGIN
	if (SELECT Login
	FROM dbo.Registration
	Where Login = @Login)=@Login
	return 1
	set @id = (Select ID_level
	From User_access_level
	Where Type_of_access = @Level)
	Begin try
	Begin transaction;
	Insert into Registration VALUES ( @Login, @Password, @id)
	Commit transaction;
	End try
	Begin catch
	Rollback transaction;
		print N'Error.'; 
	End catch
END
GO

Create or alter procedure [dbo].[sp_LK]
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

		Begin try
		Begin transaction;
		IF (@access = 1)
		Insert into Pupils VALUES (@Passport, @Name, @Balance, @id)
		Else
		INSERT INTO Teacher VALUES (@Name, @Description, @id)
		Commit transaction;
		End try
		Begin catch
		Rollback transaction;
		print N'Error.'; 
		End catch
	End
End
Go

Create or alter procedure [dbo].[sp_List_pupil]
	@Passport nvarchar(20),
	@Language nvarchar(20),
	@Language_level nvarchar(20)
AS
	declare @id_pupil int;
	declare @id_language int;
Begin
	Begin
		set @id_pupil = (Select ID_pupil
		From Pupils
		Where Passport = @Passport)

		set @id_language = (Select ID_language
		From Language
		Where Name = @Language)

		Begin try
		Begin transaction;
		Insert into List_pupil VALUES (@id_pupil, @id_language, @Language_level)
		Commit transaction;
		End try
		Begin catch
		Rollback transaction;
		print N'Error.'; 
		End catch
	End
End
Go

Create or alter procedure [dbo].[sp_List_teacher]
	@Name nvarchar(20),
	@Language nvarchar(20),
	@Experience nvarchar(20),
	@Cost Decimal
AS
	declare @id_teacher int;
	declare @id_language int;
Begin
	Begin
		set @id_teacher = (Select ID_teacher
		From Teacher
		Where Name = @Name)

		set @id_language = (Select ID_language
		From Language
		Where Name = @Language)

		Begin try
		Begin transaction;
		Insert into List_teacher VALUES (@id_teacher, @id_language, @Experience, @Cost)
		Commit transaction;
		End try
		Begin catch
		Rollback transaction;
		print N'Error.'; 
		End catch
	End
End
Go

Create or alter procedure [dbo].[sp_Lesson]	
	@Language nvarchar(20),
	@Subject_matter nvarchar(20)
AS
	declare @id_language int;
Begin
	Begin

		set @id_language = (Select ID_language
		From Language
		Where Name = @Language)

		Begin try
		Begin transaction;
		Insert into Lesson VALUES (@id_language, @Subject_matter)
		Commit transaction;
		End try
		Begin catch
		Rollback transaction;
		print N'Error.'; 
		End catch
	End
End
Go

Create or alter procedure [dbo].[sp_Shedule]	
	@Name nvarchar(20),
	@Passport nvarchar(20),
	@Language nvarchar(20),
	@Subject_matter nvarchar(20),
	@Lesson_status nvarchar(20)=null,
	@Date Date,
	@Time Time
AS
	declare @id_lesson int;
	declare @id_teacher int;
	declare @id_language int;
	declare @id_pupil int;
Begin
	Begin

		set @id_teacher = (Select ID_teacher
		From Teacher
		Where Name = @Name)

		set @id_pupil = (Select ID_pupil
		From Pupils
		Where Passport = @Passport)

		set @id_language = (Select ID_language
		From Language
		Where Name = @Language)

		set @id_lesson = (Select ID_lesson
		From Lesson
		Where ID_language = @id_language AND Subject_matter = @Subject_matter)

		Begin try
		Begin transaction;
		Insert into Shedule VALUES (@id_lesson, @id_teacher, @id_pupil, @Lesson_status, @Date, @Time)
		Commit transaction;
		End try
		Begin catch
		Rollback transaction;
		print N'Error.'; 
		End catch
	End
End
Go

Create or alter procedure [dbo].[sp_Zapros]	
	@Name_p nvarchar(20)
AS

Begin
	Begin

		Begin
		Select Distinct t.Name, t1.Date , t2.Name, t4.Name, t5.Cost
		From Pupils t inner join Shedule t1 on t.ID_pupil = t1.ID_pupil Inner join Teacher t2 on t1.ID_teacher = t2.ID_teacher Inner join Lesson t3 on t1.ID_lesson = t3.ID_lesson inner join Language t4 on 
		t3.ID_language = t4.ID_language Inner join List_teacher t5 on t1.ID_teacher = t5.ID_teacher
		Where t.Name = @Name_p 
		Order by t.Name 
		End  
	End
End
Go