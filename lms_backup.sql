USE [master]
GO
/****** Object:  Database [LMS_backup]    Script Date: 14/06/2024 18:15:58 ******/
CREATE DATABASE [LMS_backup]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LMS_backup', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LMS_backup.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LMS_backup_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LMS_backup_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LMS_backup] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LMS_backup].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LMS_backup] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LMS_backup] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LMS_backup] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LMS_backup] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LMS_backup] SET ARITHABORT OFF 
GO
ALTER DATABASE [LMS_backup] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LMS_backup] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LMS_backup] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LMS_backup] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LMS_backup] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LMS_backup] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LMS_backup] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LMS_backup] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LMS_backup] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LMS_backup] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LMS_backup] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LMS_backup] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LMS_backup] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LMS_backup] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LMS_backup] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LMS_backup] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LMS_backup] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LMS_backup] SET RECOVERY FULL 
GO
ALTER DATABASE [LMS_backup] SET  MULTI_USER 
GO
ALTER DATABASE [LMS_backup] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LMS_backup] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LMS_backup] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LMS_backup] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LMS_backup] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LMS_backup] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LMS_backup', N'ON'
GO
ALTER DATABASE [LMS_backup] SET QUERY_STORE = ON
GO
ALTER DATABASE [LMS_backup] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LMS_backup]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[author_id] [int] IDENTITY(1,1) NOT NULL,
	[author_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookAuthors]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookAuthors](
	[book_id] [int] NULL,
	[author_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookCategories]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategories](
	[category_id] [int] NULL,
	[book_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookReviews]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookReviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[book_id] [int] NOT NULL,
	[rating] [int] NULL,
	[review_text] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[book_id] [int] IDENTITY(1,1) NOT NULL,
	[publisher_id] [int] NULL,
	[book_name] [varchar](50) NOT NULL,
	[book_status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fines]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fines](
	[fine_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[fine_status] [varchar](20) NOT NULL,
	[fine_amount] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fine_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MyBooks]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MyBooks](
	[book_id] [int] NULL,
	[student_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MyFines]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MyFines](
	[fine_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fine_id] ASC,
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publishers]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishers](
	[publisher_id] [int] IDENTITY(1,1) NOT NULL,
	[publisher_name] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[phone] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[publisher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[reservation_id] [int] IDENTITY(1,1) NOT NULL,
	[book_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 14/06/2024 18:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[student_name] [varchar](50) NOT NULL,
	[student_password] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([admin_id], [username], [password]) VALUES (1, N'soban', N'111')
INSERT [dbo].[Admin] ([admin_id], [username], [password]) VALUES (2, N'sakeena', N'222')
INSERT [dbo].[Admin] ([admin_id], [username], [password]) VALUES (3, N'abiha', N'333')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Authors] ON 

INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (1, N'F. Scott Fitzgerald')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (3, N'George Orwell')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (5, N'J.D. Salinger')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (7, N'Ray Bradbury')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (8, N'Nicholas Vela')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (9, N'Aldous Huxley')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (10, N'Herman Melville')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (11, N'Bro')
INSERT [dbo].[Authors] ([author_id], [author_name]) VALUES (12, N'haha')
SET IDENTITY_INSERT [dbo].[Authors] OFF
GO
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (1, 1)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (5, 5)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (10, 10)
GO
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (1, 1)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (2, 2)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (4, 4)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (5, 5)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (6, 6)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (10, 10)
GO
SET IDENTITY_INSERT [dbo].[BookReviews] ON 

INSERT [dbo].[BookReviews] ([review_id], [book_id], [rating], [review_text]) VALUES (1, 1, 5, N'An amazing read. Highly recommended.')
INSERT [dbo].[BookReviews] ([review_id], [book_id], [rating], [review_text]) VALUES (2, 2, 4, N'Great book but some parts were slow.')
INSERT [dbo].[BookReviews] ([review_id], [book_id], [rating], [review_text]) VALUES (4, 4, 3, N'Good book but not my taste.')
INSERT [dbo].[BookReviews] ([review_id], [book_id], [rating], [review_text]) VALUES (5, 5, 4, N'Interesting story with deep characters.')
INSERT [dbo].[BookReviews] ([review_id], [book_id], [rating], [review_text]) VALUES (6, 6, 5, N'A timeless classic.')
INSERT [dbo].[BookReviews] ([review_id], [book_id], [rating], [review_text]) VALUES (10, 10, 5, N'Absolutely loved it.')
SET IDENTITY_INSERT [dbo].[BookReviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (1, 1, N'The Great Gatsby', N'Available')
INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (2, 2, N'To Kill a Mockingbird', N'Checked Out')
INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (3, 7, N'2004', N'Available')
INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (4, 4, N'Pride and Prejudice', N'Available')
INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (5, 5, N'The Catcher in the Rye', N'Checked Out')
INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (6, 6, N'The Hobbit', N'Available')
INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (10, 10, N'Moby-Dick', N'Available')
INSERT [dbo].[Books] ([book_id], [publisher_id], [book_name], [book_status]) VALUES (12, 6, N'Book', N'Available')
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (1, N'Fiction')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (2, N'Classic')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (3, N'Science ')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (4, N'Fantasy')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (5, N'Drama')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (6, N'Adventure')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (7, N'Mystery')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (10, N'Self-Help')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (11, N'Fun')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (12, N'Naam')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Fines] ON 

INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (1, 1, N'Unpaid', CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (2, 2, N'Paid', CAST(3.50 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (3, 3, N'Unpaid', CAST(4.75 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (4, 4, N'Unpaid', CAST(3.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (5, 5, N'Unpaid', CAST(6.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (12, 5, N'Unpaid', CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (13, 11, N'Pending', CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [student_id], [fine_status], [fine_amount]) VALUES (15, 12, N'Unpaid', CAST(15.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Fines] OFF
GO
INSERT [dbo].[MyBooks] ([book_id], [student_id]) VALUES (1, 1)
INSERT [dbo].[MyBooks] ([book_id], [student_id]) VALUES (2, 2)
INSERT [dbo].[MyBooks] ([book_id], [student_id]) VALUES (10, 11)
INSERT [dbo].[MyBooks] ([book_id], [student_id]) VALUES (4, 4)
INSERT [dbo].[MyBooks] ([book_id], [student_id]) VALUES (5, 5)
INSERT [dbo].[MyBooks] ([book_id], [student_id]) VALUES (6, 11)
GO
INSERT [dbo].[MyFines] ([fine_id], [student_id]) VALUES (4, 4)
INSERT [dbo].[MyFines] ([fine_id], [student_id]) VALUES (5, 5)
INSERT [dbo].[MyFines] ([fine_id], [student_id]) VALUES (13, 11)
INSERT [dbo].[MyFines] ([fine_id], [student_id]) VALUES (15, 12)
GO
SET IDENTITY_INSERT [dbo].[Publishers] ON 

INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (1, N'Penguin Random House', N'contact@penguin.com', N'1234567890')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (2, N'HarperCollins', N'info@harpercollins.com', N'0987654321')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (4, N'Macmillan Publishers', N'hello@macmillan.com', N'2233445566')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (5, N'Hachette Livre', N'service@hachette.com', N'3344556677')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (6, N'Pearson Education', N'help@pearson.com', N'4455667788')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (7, N'Scholasty', N'info@scholasty.com', N'5566778899')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (9, N'Wiley', N'contact@wiley.com', N'7788990011')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (10, N'Cengage', N'service@cengage.com', N'8899001122')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (11, N'Nigz House', N'brooo@email.com', N'08726352')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [email], [phone]) VALUES (12, N'House of Hilal', N'emai@email.com', N'1122334455')
SET IDENTITY_INSERT [dbo].[Publishers] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservations] ON 

INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (2, 2, 2)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (4, 4, 4)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (18, 12, 11)
SET IDENTITY_INSERT [dbo].[Reservations] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (1, N'Alice', N'123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (2, N'Bob', N'456')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (3, N'Charlie', N'789')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (4, N'Nathan', N'101')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (5, N'Deva', N'888')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (9, N'Noman', N'106')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (11, N'Xiao', N'777')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (12, N'Sakina', N'345')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (13, N'Haris', N'102')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (14, N'Dbms', N'4567')
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
ALTER TABLE [dbo].[BookAuthors]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[Authors] ([author_id])
GO
ALTER TABLE [dbo].[BookAuthors]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[BookCategories]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[BookCategories]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[BookReviews]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD FOREIGN KEY([publisher_id])
REFERENCES [dbo].[Publishers] ([publisher_id])
GO
ALTER TABLE [dbo].[Fines]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[MyBooks]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[MyBooks]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[MyFines]  WITH CHECK ADD FOREIGN KEY([fine_id])
REFERENCES [dbo].[Fines] ([fine_id])
GO
ALTER TABLE [dbo].[MyFines]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[BookReviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [LMS_backup] SET  READ_WRITE 
GO
