USE [master]
GO
/****** Object:  Database [LMS]    Script Date: 14/06/2024 18:14:55 ******/
CREATE DATABASE [LMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LMS] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [LMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LMS] SET RECOVERY FULL 
GO
ALTER DATABASE [LMS] SET  MULTI_USER 
GO
ALTER DATABASE [LMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LMS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LMS', N'ON'
GO
ALTER DATABASE [LMS] SET QUERY_STORE = ON
GO
ALTER DATABASE [LMS] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LMS]
GO
/****** Object:  UserDefinedFunction [dbo].[AvgRatingOfABook]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AvgRatingOfABook](@book_id INT)
RETURNS INT
AS
BEGIN
  DECLARE @AvgRating INT
  SELECT @AvgRating = AVG(rating)
  FROM BookReviews
  WHERE book_id = @book_id
  RETURN @AvgRating
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetBookAvailabilityStatus]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetBookAvailabilityStatus] (@book_id INT)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @book_status VARCHAR(20);
    SELECT @book_status = book_status
    FROM Books
    WHERE book_id = @book_id;
    RETURN @book_status;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetBooksIssuedToStudent]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetBooksIssuedToStudent] (@student_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @books_issued INT;
    SELECT @books_issued = COUNT(*)
    FROM BooksIssued
    WHERE student_id = @student_id AND issue_status = 'Issued';
    RETURN @books_issued;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GetTotalFines]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetTotalFines] (@student_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total_fines DECIMAL(10, 2);
    SELECT @total_fines = SUM(fine_amount)
    FROM Fines
    WHERE student_id = @student_id;
    RETURN @total_fines;
END;
GO
/****** Object:  Table [dbo].[Publishers]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publishers](
	[publisher_id] [int] NOT NULL,
	[publisher_name] [varchar](50) NOT NULL,
	[address] [text] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[website] [varchar](50) NOT NULL,
	[description] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[publisher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[book_id] [int] NOT NULL,
	[book_name] [varchar](50) NOT NULL,
	[book_description] [text] NOT NULL,
	[book_available] [int] NOT NULL,
	[book_status] [varchar](20) NOT NULL,
	[publisher_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPublisherInfoAndBooks]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPublisherInfoAndBooks] (@publisher_id INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        p.publisher_id,
        p.publisher_name,
        p.address,
        p.email,
        p.phone,
        p.website,
        b.book_id,
        b.book_name,
        b.book_description,
        b.book_status
    FROM Publishers p
    JOIN Books b ON p.publisher_id = b.publisher_id
    WHERE p.publisher_id = @publisher_id
);
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[author_id] [int] NOT NULL,
	[author_name] [varchar](50) NOT NULL,
	[author_description] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookAuthors]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookAuthors](
	[book_id] [int] NOT NULL,
	[author_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[book_id] ASC,
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BooksByAuthorCount]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BooksByAuthorCount] AS
SELECT a.author_id, a.author_name, COUNT(ba.book_id) AS book_count
FROM Authors a
JOIN BookAuthors ba ON a.author_id = ba.author_id
JOIN Books b ON ba.book_id = b.book_id
GROUP BY a.author_id, a.author_name;
GO
/****** Object:  Table [dbo].[Students]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[student_id] [int] NOT NULL,
	[student_name] [varchar](50) NOT NULL,
	[student_password] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BooksIssued]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BooksIssued](
	[book_issued_id] [int] NOT NULL,
	[book_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[issue_date] [date] NOT NULL,
	[request_date] [date] NOT NULL,
	[return_date] [date] NULL,
	[issue_status] [varchar](20) NOT NULL,
	[valid_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[book_issued_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CurrentBooksIssued]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CurrentBooksIssued] AS
SELECT bi.book_issued_id, s.student_id, s.student_name, b.book_id, b.book_name,
       bi.issue_date, bi.return_date, bi.issue_status
FROM BooksIssued bi
JOIN Students s ON bi.student_id = s.student_id
JOIN Books b ON bi.book_id = b.book_id
WHERE bi.issue_status = 'Issued';
GO
/****** Object:  Table [dbo].[Fines]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fines](
	[fine_id] [int] NOT NULL,
	[books_issued_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[fine_status] [varchar](20) NOT NULL,
	[fine_accrued_date] [date] NOT NULL,
	[fine_cleared_date] [date] NULL,
	[fine_amount] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fine_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[StdPendingFines]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StdPendingFines] AS
SELECT f.fine_id,  s.student_name, f.fine_amount
FROM Fines f
JOIN Students s ON f.student_id = s.student_id
AND fine_status = 'Pending'
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] NOT NULL,
	[category_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookCategories]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategories](
	[category_id] [int] NULL,
	[book_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[booksWithCategories]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[booksWithCategories] AS
 SELECT c.category_name, b.book_id
FROM Categories c
JOIN BookCategories boc on c.category_id = boc.category_id
JOIN Books b on boc.book_id = b.book_id 
GO
/****** Object:  Table [dbo].[BookReviews]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookReviews](
	[review_id] [int] NOT NULL,
	[book_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[rating] [int] NULL,
	[review_text] [text] NULL,
	[review_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[BooksWithRatingAbove3]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BooksWithRatingAbove3] AS
SELECT b.book_name, b.book_description, b.book_status, br.rating
FROM books b
JOIN BookReviews br ON b.book_id = br.book_id
AND br.rating > 3
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[admin_id] [int] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BooksAvailabilityAudit]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BooksAvailabilityAudit](
	[audit_id] [int] NOT NULL,
	[book_id] [int] NOT NULL,
	[old_books_available] [int] NOT NULL,
	[new_books_available] [int] NOT NULL,
	[audit_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[audit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MyBooks]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MyBooks](
	[reservation_id] [int] NULL,
	[student_id] [int] NULL,
	[book_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MyFines]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MyFines](
	[fine_id] [int] NULL,
	[student_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[reservation_id] [int] NOT NULL,
	[book_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReservationsNew]    Script Date: 14/06/2024 18:14:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsNew](
	[reservation_id] [int] IDENTITY(1,1) NOT NULL,
	[book_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Admin] ([admin_id], [username], [password]) VALUES (1, N'Abiha', N'adminpassword1')
INSERT [dbo].[Admin] ([admin_id], [username], [password]) VALUES (2, N'Sakeena', N'adminpassword2')
INSERT [dbo].[Admin] ([admin_id], [username], [password]) VALUES (3, N'Soban', N'adminpassword3')
GO
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (1, N'Paulo Coelho', N'Brazilian author best known for his novel The Alchemist.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (2, N'Harper Lee', N'American novelist widely known for To Kill a Mockingbird.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (3, N'George Orwell', N'English novelist, essayist, journalist, and critic.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (4, N'Khaled Hosseini', N'Afghan-American novelist and physician.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (5, N'Dan Brown', N'American author best known for his thriller novels.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (7, N'Franz Kafka', N'German-speaking Bohemian writer.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (8, N'Herman Melville', N'American novelist, short story writer, and poet.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (10, N'F. Scott Fitzgerald', N'American novelist and short story writer.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (11, N'Leo Tolstoy', N'Russian writer known for his novels War and Peace and Anna Karenina.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (12, N'Fyodor Dostoevsky', N'Russian novelist, short story writer, essayist, and journalist.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (13, N'Gabriel Garcia Marquez', N'Colombian novelist, short-story writer, screenwriter, and journalist.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (14, N'J.D. Salinger', N'American writer known for his widely read novel, The Catcher in the Rye.')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (15, N'Sobi', N'Bruh')
INSERT [dbo].[Authors] ([author_id], [author_name], [author_description]) VALUES (16, N'A', N'B')
GO
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (1, 1)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (2, 2)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (4, 4)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (5, 5)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (7, 7)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (8, 8)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (10, 10)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (11, 11)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (12, 12)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (13, 13)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (14, 11)
INSERT [dbo].[BookAuthors] ([book_id], [author_id]) VALUES (15, 14)
GO
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (1, 1)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (2, 2)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (4, 4)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (5, 5)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (6, 6)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (7, 7)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (8, 8)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (9, 9)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (10, 10)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (1, 11)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (2, 12)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (3, 13)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (4, 14)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (5, 15)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (6, 16)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (7, 17)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (8, 18)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (9, 19)
INSERT [dbo].[BookCategories] ([category_id], [book_id]) VALUES (10, 20)
GO
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (1, 1, 1, 4, N'A timeless classic.', CAST(N'2024-06-01' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (2, 2, 2, 5, N'Captivating and thought-provoking.', CAST(N'2024-06-02' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (4, 4, 4, 5, N'Heart-wrenching and beautifully written.', CAST(N'2024-06-04' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (5, 5, 5, 4, N'A thrilling adventure with historical intrigue.', CAST(N'2024-06-05' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (6, 6, 6, 5, N'Delightful and witty portrayal of society.', CAST(N'2024-06-06' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (7, 7, 7, 3, N'A challenging read with deep philosophical themes.', CAST(N'2024-06-07' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (8, 8, 8, 4, N'Epic and filled with maritime adventure.', CAST(N'2024-06-08' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (9, 9, 9, 3, N'Provocative dystopian vision of the future.', CAST(N'2024-06-09' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (10, 10, 10, 5, N'A brilliant portrayal of the Jazz Age.', CAST(N'2024-06-10' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (11, 11, 11, 4, N'A monumental work of historical fiction.', CAST(N'2024-06-11' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (12, 12, 12, 5, N'Psychologically intense and morally complex.', CAST(N'2024-06-12' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (13, 13, 13, 4, N'Magical realism at its finest.', CAST(N'2024-06-13' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (14, 14, 14, 5, N'Captivating characters in a tragic love story.', CAST(N'2024-06-14' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (15, 15, 15, 3, N'An insightful exploration of teenage angst.', CAST(N'2024-06-15' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (16, 16, 16, 4, N'Fantasy masterpiece with rich mythology.', CAST(N'2024-06-16' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (17, 17, 17, 5, N'The beginning of a magical journey.', CAST(N'2024-06-17' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (18, 18, 18, 3, N'Intense survival adventure in a dystopian world.', CAST(N'2024-06-18' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (19, 19, 19, 4, N'Fun and imaginative children''s story.', CAST(N'2024-06-19' AS Date))
INSERT [dbo].[BookReviews] ([review_id], [book_id], [student_id], [rating], [review_text], [review_date]) VALUES (20, 20, 20, 5, N'Empowering story of a young girl''s intelligence.', CAST(N'2024-06-20' AS Date))
GO
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (1, N'The Alchemist', N'A novel by Paulo Coelho', 10, N'Available', 1)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (2, N'To Kill a Mockingbird', N'A novel by Harper Lee', 8, N'Available', 2)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (4, N'Thousand Splendid Suns', N'Best Seller Book By Khaled Hosseini', 0, N'Not Available', 5)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (5, N'The Da Vinci Code', N'A novel by Dan Brown', 9, N'Available', 5)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (6, N'Pride and Prejudice', N'A novel by Jane Austen', 7, N'Available', 6)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (7, N'The Trial', N'A novel by Franz Kafka', 4, N'Available', 7)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (8, N'Moby Dick', N'A novel by Herman Melville', 6, N'Available', 8)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (9, N'Brave New World', N'A novel by Aldous Huxley', 11, N'Available', 1)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (10, N'The Great Gatsby', N'A novel by F. Scott Fitzgerald', 10, N'Available', 2)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (11, N'War and Peace', N'A novel by Leo Tolstoy', 3, N'Available', 3)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (12, N'Crime and Punishment', N'A novel by Fyodor Dostoevsky', 5, N'Available', 4)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (13, N'One Hundred Years of Solitude', N'A novel by Gabriel Garcia Marquez', 8, N'Available', 5)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (14, N'Anna Karenina', N'A novel by Leo Tolstoy', 7, N'Available', 6)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (15, N'The Catcher in the Rye', N'A novel by J.D. Salinger', 6, N'Available', 7)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (16, N'The Lord of the Rings', N'A novel by J.R.R. Tolkien', 15, N'Available', 11)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (17, N'Harry Potter and the Philosopher''s Stone', N'A novel by J.K. Rowling', 14, N'Available', 12)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (18, N'The Hunger Games', N'A novel by Suzanne Collins', 13, N'Available', 13)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (19, N'The Cat in the Hat', N'A children''s book by Dr. Seuss', 11, N'Available', 14)
INSERT [dbo].[Books] ([book_id], [book_name], [book_description], [book_available], [book_status], [publisher_id]) VALUES (20, N'Matilda', N'A children''s book by Roald Dahl', 10, N'Available', 15)
GO
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (1, 1, 12, 10, CAST(N'2024-01-10' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (2, 2, 10, 8, CAST(N'2024-02-12' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (4, 4, 6, 5, CAST(N'2024-04-18' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (5, 5, 11, 9, CAST(N'2024-05-20' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (6, 6, 9, 7, CAST(N'2024-06-22' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (7, 7, 5, 4, CAST(N'2024-07-25' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (8, 8, 8, 6, CAST(N'2024-08-27' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (9, 9, 14, 11, CAST(N'2024-09-30' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (10, 10, 12, 10, CAST(N'2024-10-05' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (11, 11, 5, 3, CAST(N'2024-11-10' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (12, 12, 7, 5, CAST(N'2024-12-15' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (13, 13, 10, 8, CAST(N'2025-01-20' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (14, 14, 9, 7, CAST(N'2025-02-25' AS Date))
INSERT [dbo].[BooksAvailabilityAudit] ([audit_id], [book_id], [old_books_available], [new_books_available], [audit_date]) VALUES (15, 15, 8, 6, CAST(N'2025-03-30' AS Date))
GO
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (2, 4, 8, CAST(N'2024-05-02' AS Date), CAST(N'2024-04-26' AS Date), CAST(N'2024-05-31' AS Date), N'Issued', CAST(N'2024-06-02' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (3, 1, 10, CAST(N'2024-05-03' AS Date), CAST(N'2024-04-27' AS Date), CAST(N'2024-06-01' AS Date), N'Issued', CAST(N'2024-06-03' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (4, 6, 12, CAST(N'2024-05-04' AS Date), CAST(N'2024-04-28' AS Date), CAST(N'2024-06-02' AS Date), N'Issued', CAST(N'2024-06-04' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (5, 8, 14, CAST(N'2024-05-05' AS Date), CAST(N'2024-04-29' AS Date), CAST(N'2024-06-03' AS Date), N'Issued', CAST(N'2024-06-05' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (6, 2, 5, CAST(N'2024-05-06' AS Date), CAST(N'2024-04-30' AS Date), CAST(N'2024-06-04' AS Date), N'Issued', CAST(N'2024-06-06' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (7, 5, 7, CAST(N'2024-05-07' AS Date), CAST(N'2024-05-01' AS Date), CAST(N'2024-06-05' AS Date), N'Issued', CAST(N'2024-06-07' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (8, 7, 9, CAST(N'2024-05-08' AS Date), CAST(N'2024-05-02' AS Date), CAST(N'2024-06-06' AS Date), N'Issued', CAST(N'2024-06-08' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (9, 10, 11, CAST(N'2024-05-09' AS Date), CAST(N'2024-05-03' AS Date), CAST(N'2024-06-07' AS Date), N'Issued', CAST(N'2024-06-09' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (10, 12, 13, CAST(N'2024-05-10' AS Date), CAST(N'2024-05-04' AS Date), CAST(N'2024-06-08' AS Date), N'Issued', CAST(N'2024-06-10' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (11, 16, 16, CAST(N'2024-06-11' AS Date), CAST(N'2024-06-01' AS Date), NULL, N'Issued', CAST(N'2024-06-12' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (12, 17, 17, CAST(N'2024-06-12' AS Date), CAST(N'2024-06-02' AS Date), CAST(N'2024-07-02' AS Date), N'Returned', CAST(N'2024-06-13' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (13, 18, 18, CAST(N'2024-06-13' AS Date), CAST(N'2024-06-03' AS Date), NULL, N'Issued', CAST(N'2024-06-14' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (14, 19, 19, CAST(N'2024-01-25' AS Date), CAST(N'2024-01-15' AS Date), CAST(N'2024-03-20' AS Date), N'Returned', CAST(N'2024-03-20' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (15, 15, 15, CAST(N'2024-06-10' AS Date), CAST(N'2024-05-31' AS Date), NULL, N'Overdue', CAST(N'2024-06-11' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (16, 1, 6, CAST(N'2024-06-16' AS Date), CAST(N'2024-06-06' AS Date), NULL, N'Issued', CAST(N'2024-06-17' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (17, 2, 7, CAST(N'2024-06-17' AS Date), CAST(N'2024-06-07' AS Date), NULL, N'Issued', CAST(N'2024-06-18' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (19, 4, 9, CAST(N'2024-06-19' AS Date), CAST(N'2024-06-09' AS Date), NULL, N'Overdue', CAST(N'2024-06-20' AS Date))
INSERT [dbo].[BooksIssued] ([book_issued_id], [book_id], [student_id], [issue_date], [request_date], [return_date], [issue_status], [valid_date]) VALUES (20, 5, 10, CAST(N'2024-06-20' AS Date), CAST(N'2024-06-10' AS Date), NULL, N'Overdue', CAST(N'2024-06-21' AS Date))
GO
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (1, N'Fiction')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (2, N'Non-Fiction')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (3, N'Literature')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (4, N'Science Fiction')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (5, N'Fantasy')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (6, N'Mystery')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (7, N'Thriller')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (8, N'Romance')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (9, N'History')
INSERT [dbo].[Categories] ([category_id], [category_name]) VALUES (10, N'Biography')
GO
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (1, 2, 1, N'Pending', CAST(N'2024-05-15' AS Date), CAST(N'2024-05-30' AS Date), CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (2, 3, 2, N'Paid', CAST(N'2024-05-20' AS Date), CAST(N'2024-05-25' AS Date), CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (3, 4, 3, N'Pending', CAST(N'2024-05-25' AS Date), CAST(N'2024-06-02' AS Date), CAST(75.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (4, 5, 4, N'Pending', CAST(N'2024-06-01' AS Date), CAST(N'2024-06-03' AS Date), CAST(120.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (5, 6, 5, N'Paid', CAST(N'2024-06-05' AS Date), CAST(N'2024-06-07' AS Date), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (6, 7, 6, N'Pending', CAST(N'2024-06-10' AS Date), CAST(N'2024-06-15' AS Date), CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (7, 8, 7, N'Paid', CAST(N'2024-06-15' AS Date), CAST(N'2024-06-20' AS Date), CAST(60.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (8, 9, 8, N'Pending', CAST(N'2024-06-18' AS Date), CAST(N'2024-06-22' AS Date), CAST(110.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (9, 10, 9, N'Pending', CAST(N'2024-06-02' AS Date), NULL, CAST(85.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (10, 11, 10, N'Pending', CAST(N'2024-06-05' AS Date), NULL, CAST(95.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (11, 12, 1, N'Pending', CAST(N'2024-06-10' AS Date), NULL, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (12, 13, 2, N'Paid', CAST(N'2024-06-15' AS Date), CAST(N'2024-06-18' AS Date), CAST(55.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (13, 14, 3, N'Pending', CAST(N'2024-06-20' AS Date), NULL, CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (14, 15, 4, N'Pending', CAST(N'2024-06-25' AS Date), NULL, CAST(125.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (15, 16, 5, N'Cleared', CAST(N'2024-06-28' AS Date), CAST(N'2024-05-25' AS Date), CAST(85.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (16, 17, 16, N'Pending', CAST(N'2024-06-26' AS Date), NULL, CAST(95.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (17, 19, 17, N'Paid', CAST(N'2024-06-27' AS Date), CAST(N'2024-06-29' AS Date), CAST(65.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (18, 20, 18, N'Pending', CAST(N'2024-06-28' AS Date), NULL, CAST(115.00 AS Decimal(10, 2)))
INSERT [dbo].[Fines] ([fine_id], [books_issued_id], [student_id], [fine_status], [fine_accrued_date], [fine_cleared_date], [fine_amount]) VALUES (21, 7, 5, N'Pending', CAST(N'2024-02-01' AS Date), NULL, CAST(200.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[MyBooks] ([reservation_id], [student_id], [book_id]) VALUES (NULL, 1, 1)
INSERT [dbo].[MyBooks] ([reservation_id], [student_id], [book_id]) VALUES (NULL, 4, 4)
INSERT [dbo].[MyBooks] ([reservation_id], [student_id], [book_id]) VALUES (NULL, 10, 10)
INSERT [dbo].[MyBooks] ([reservation_id], [student_id], [book_id]) VALUES (NULL, 2, 2)
GO
INSERT [dbo].[MyFines] ([fine_id], [student_id]) VALUES (1, 1)
GO
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (1, N'Oxford University Press', N'Karachi, Pakistan', N'info@oup.com', N'021-111-222-333', N'www.oup.com', N'Leading publisher of academic and educational materials.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (2, N'Ferozsons', N'Lahore, Pakistan', N'contact@ferozsons.com', N'042-111-444-555', N'www.ferozsons.com', N'Publishes a wide range of books across various genres.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (3, N'Sang-e-Meel Publications', N'Lahore, Pakistan', N'info@sangemeel.com', N'042-222-666-777', N'www.sangemeel.com', N'Specializes in publishing Urdu literature and cultural works.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (4, N'Penguin Random House', N'New York, USA', N'info@penguinrandomhouse.com', N'+1-212-555-5555', N'www.penguinrandomhouse.com', N'One of the largest English-language trade book publishers in the world.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (5, N'HarperCollins', N'New York, USA', N'contact@harpercollins.com', N'+1-212-555-6666', N'www.harpercollins.com', N'Publishes a diverse range of fiction and non-fiction books.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (6, N'Simon & Schuster', N'New York, USA', N'info@simonandschuster.com', N'+1-212-555-7777', N'www.simonandschuster.com', N'Known for publishing bestselling authors and quality fiction.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (7, N'Macmillan Publishers', N'London, UK', N'info@macmillan.com', N'+44-20-555-8888', N'www.macmillan.com', N'Publishes educational content and academic books.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (8, N'Hachi', N'Paris, France', N'contact@hachette.com', N'+33-1-555-9999', N'www.hachette.com', N'One of the worlds largest publishing groups.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (9, N'Liberty Books', N'Karachi, Pakistan', N'info@libertybooks.com', N'021-333-444-555', N'www.libertybooks.com', N'Popular chain of bookstores and publishers in Pakistan.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (11, N'Bloomsbury Publishing', N'London, UK', N'info@bloomsbury.com', N'+44-20-777-8888', N'www.bloomsbury.com', N'A leading independent publishing house.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (12, N'Macmillan Education', N'London, UK', N'info@macmillaneducation.com', N'+44-20-999-8888', N'www.macmillaneducation.com', N'Specializes in educational books and materials.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (13, N'Random House', N'New York, USA', N'info@randomhouse.com', N'+1-212-777-8888', N'www.randomhouse.com', N'Publishes fiction and non-fiction books.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (14, N'Puffin Books', N'London, UK', N'info@puffinbooks.com', N'+44-20-666-8888', N'www.puffinbooks.com', N'Focuses on children''s literature.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (15, N'Scholastic Corporation', N'New York, USA', N'info@scholastic.com', N'+1-212-999-8888', N'www.scholastic.com', N'Publishes educational materials and children''s books.')
INSERT [dbo].[Publishers] ([publisher_id], [publisher_name], [address], [email], [phone], [website], [description]) VALUES (16, N'aa', N'bb', N'cc', N'112233', N'www.com', N'aqwerty')
GO
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (5, 5, 5)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (6, 6, 6)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (7, 7, 7)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (8, 8, 8)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (9, 9, 9)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (11, 11, 1)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (12, 12, 2)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (13, 13, 3)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (14, 14, 4)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (15, 15, 5)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (16, 16, 1)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (17, 17, 2)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (18, 18, 3)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (19, 19, 4)
INSERT [dbo].[Reservations] ([reservation_id], [book_id], [student_id]) VALUES (20, 20, 5)
GO
SET IDENTITY_INSERT [dbo].[ReservationsNew] ON 

INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (1, 2, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (2, 5, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (3, 6, 6)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (4, 7, 7)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (5, 8, 8)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (6, 9, 9)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (7, 10, 10)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (8, 11, 1)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (9, 12, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (10, 13, 3)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (11, 14, 4)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (12, 15, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (13, 16, 1)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (14, 17, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (15, 18, 3)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (16, 19, 4)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (17, 20, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (18, 2, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (19, 5, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (20, 6, 6)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (21, 7, 7)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (22, 8, 8)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (23, 9, 9)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (24, 10, 10)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (25, 11, 1)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (26, 12, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (27, 13, 3)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (28, 14, 4)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (29, 15, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (30, 16, 1)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (31, 17, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (32, 18, 3)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (33, 19, 4)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (34, 20, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (35, 2, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (36, 5, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (37, 6, 6)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (38, 7, 7)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (39, 8, 8)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (40, 9, 9)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (41, 10, 10)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (42, 11, 1)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (43, 12, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (44, 13, 3)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (45, 14, 4)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (46, 15, 5)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (47, 16, 1)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (48, 17, 2)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (49, 18, 3)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (50, 19, 4)
INSERT [dbo].[ReservationsNew] ([reservation_id], [book_id], [student_id]) VALUES (51, 20, 5)
SET IDENTITY_INSERT [dbo].[ReservationsNew] OFF
GO
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (1, N'Ali', N'Ali123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (2, N'Sara', N'Sara123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (3, N'Ahmed', N'Ahmed123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (4, N'Zainab', N'Zainab123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (5, N'Hassan', N'Hassan123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (6, N'Ayesha', N'Ayesha123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (7, N'Umar', N'Umar123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (8, N'Fatima', N'Fatima123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (9, N'Bilal', N'Bilal123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (10, N'Maryam', N'Maryam123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (11, N'Usman', N'Usman123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (12, N'Khadija', N'Khadija123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (13, N'Raza', N'Raza123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (14, N'Hina', N'Hina123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (15, N'Salman', N'Salman123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (16, N'Amna', N'Amna123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (17, N'Khalid', N'Khalid123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (18, N'Amina', N'Amina123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (19, N'Imran', N'Imran123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (20, N'Sadia', N'Sadia123')
INSERT [dbo].[Students] ([student_id], [student_name], [student_password]) VALUES (21, N'Arham', N'Arham123')
GO
ALTER TABLE [dbo].[BookAuthors]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[Authors] ([author_id])
GO
ALTER TABLE [dbo].[BookAuthors]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[BookCategories]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[BookCategories]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[BookReviews]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[BookReviews]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD FOREIGN KEY([publisher_id])
REFERENCES [dbo].[Publishers] ([publisher_id])
GO
ALTER TABLE [dbo].[BooksAvailabilityAudit]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[BooksIssued]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[BooksIssued]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[Fines]  WITH CHECK ADD FOREIGN KEY([books_issued_id])
REFERENCES [dbo].[BooksIssued] ([book_issued_id])
GO
ALTER TABLE [dbo].[Fines]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[MyBooks]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[MyBooks]  WITH CHECK ADD FOREIGN KEY([reservation_id])
REFERENCES [dbo].[Reservations] ([reservation_id])
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
ALTER TABLE [dbo].[ReservationsNew]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Books] ([book_id])
GO
ALTER TABLE [dbo].[ReservationsNew]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[BookReviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[AddFine]    Script Date: 14/06/2024 18:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddFine]
    @fine_id INT,
    @books_issued_id INT,
    @student_id INT,
    @fine_status VARCHAR(20),
    @fine_accrued_date DATE,
    @fine_amount DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Fines (fine_id,books_issued_id, student_id, fine_status, fine_accrued_date, fine_amount)
    VALUES (@fine_id,@books_issued_id, @student_id, @fine_status, @fine_accrued_date, @fine_amount);
END;
GO
/****** Object:  StoredProcedure [dbo].[AddStd]    Script Date: 14/06/2024 18:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddStd]
    @student_id INT,
    @student_name VARCHAR(50),
    @student_password VARCHAR(50)
	
AS
BEGIN
    INSERT INTO Students (student_id,student_name, student_password)
    VALUES (@student_id, @student_name, @student_password);
END;
GO
/****** Object:  StoredProcedure [dbo].[BookReturned]    Script Date: 14/06/2024 18:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BookReturned]
@book_issued_id INT,
@return_date DATE
AS
BEGIN
Update BooksIssued
set issue_status = 'Returned', return_date = @return_date
where book_issued_id = @book_issued_id

END
GO
/****** Object:  StoredProcedure [dbo].[ClearFine]    Script Date: 14/06/2024 18:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClearFine]
    @fine_id INT,
    @fine_cleared_date DATE
AS
BEGIN
    UPDATE Fines
    SET fine_status = 'Cleared',
        fine_cleared_date = @fine_cleared_date
    WHERE fine_id = @fine_id;
END;


exec ClearFine 20,'2024-12-06'
GO
/****** Object:  StoredProcedure [dbo].[UpdateBook]    Script Date: 14/06/2024 18:14:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBook]
    @book_id INT,
    @book_name VARCHAR(50),
    @book_description TEXT,
    @book_available INT,
    @book_status VARCHAR(20),
    @publisher_id INT
AS
BEGIN
    UPDATE Books
    SET book_name = @book_name,
        book_description = @book_description,
        book_available = @book_available,
        book_status = @book_status,
        publisher_id = @publisher_id
    WHERE book_id = @book_id;
END;
GO
USE [master]
GO
ALTER DATABASE [LMS] SET  READ_WRITE 
GO
