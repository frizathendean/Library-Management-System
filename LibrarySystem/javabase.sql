-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Bulan Mei 2025 pada 15.59
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `javabase`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `book_id` varchar(10) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `availability` varchar(50) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `books`
--

INSERT INTO `books` (`id`, `book_id`, `title`, `author`, `isbn`, `genre`, `tags`, `availability`, `image_url`) VALUES
(9, 'BK0009', 'Dilan: Dia adalah Dilanku Tahun 1990', 'Pidi Baiq', '9786027870407', 'Fiction', 'romance, love, fiction, novel', 'available', 'images/books/dilan.jpg'),
(12, 'BK0011', 'Atomic Habits', 'James Clear', '9780735211292', 'Self Development', 'life, self, development, novel, philosophy', 'available', 'images/books/1746243705237_atomic habits.jpg'),
(14, 'BK0038', 'Emotional Intelligence: Why It Can Matter More Than IQ', 'Daniel Goleman', '9786230456784', 'Self Development', 'mental, health, life, philosophy', 'Available', 'images/books/1746245131754_emotional intelligence.jpg'),
(15, 'BK0039', 'Filosofi Teras', 'Henry Manampiring', '9787272456784', 'Self Development', 'self, heal, life, philosophy', 'Available', 'images/books/1746245185914_filosofi teras.jpg'),
(16, 'BK0031', 'Funiculi Funicula', 'Toshikazu Kawaguchi', '9786023051927', 'Fiction', 'women, life, fiction, novel', 'Available', 'images/books/1746245820629_funiculi funicula.jpg'),
(17, 'BK0030', 'Kim Ji-Yeong Lahir Tahun 1982', 'Cho Nam-Joo', '9786020636191', 'Fiction', 'tokyo, life, fiction, novel', 'Available', 'images/books/1746245950108_kim ji yeong.jpg'),
(18, 'BK0032', 'MADA', 'Gigrey', '9786020651334', 'Fiction', 'fiction, novel, java, romance', 'Available', 'images/books/1746246002029_mada.jpg'),
(19, 'BK0033', 'Mariposa', 'Luluk HF', '9786020651927', 'Fiction', 'romance, love, fiction, novel', 'Available', 'images/books/1746246061731_mariposa.jpg'),
(20, 'BK0036', 'Nanti Juga Sembuh Sendiri', 'Helobagas', '9786022082248', 'Self Development', 'life, heal, novel, philosophy', 'Available', 'images/books/1746246129676_nanti juga sembuh.jpg'),
(21, 'BK0010', 'Sebuah Seni untuk Bersikap Bodo Amat', 'Mark Manson', '9786020523317', 'Self Development', 'life, self, development, novel, philosophy', 'Available', 'images/books/1746246199741_sebuah seni untuk bersikap bodo amat.jpg'),
(22, 'BK0040', 'Ikigai: The Japanese Secret to a Long and Happy Life', 'HÃ©ctor GarcÃ­a & Francesc Miralles', '9786444451334', 'Self Development', 'life, self, thinking, novel, philosophy', 'Available', 'images/books/1746298286468_ikigai.jpg'),
(23, 'BK0035', 'Stop Overthinking', 'Nick Trenton', '9786230409585', 'Self Development', 'life, self, thinking, novel, philosophy', 'Borrowed', 'images/books/1746298353796_stop overthinking.jpg'),
(24, 'BK0029', 'The Midnight Library', 'Matt Haig', '9786020649320', 'Fiction', 'sci-fi, adventure, fiction, novel', 'Available', 'images/books/1746298424988_the midnight library.jpg'),
(25, 'BK0037', 'The Psychology Of Money', 'Morgan Housel', '9786123452248', 'Self Development', 'money, health, novel, philosophy', 'Available', 'images/books/1746298518258_the psychology of money.jpg'),
(26, 'BK0034', 'Le Petit Prince', 'Antoine De Saint E.', '9786020323411', 'Fiction', 'kid, life, fiction, novel', 'Available', 'images/books/1746298683520_le petit prince.jpg'),
(27, 'BK0008', 'To All the Boys Iâve Loved Before', 'Jenny Han', '9781442426702', 'Fiction', 'romance, love, fiction, novel', 'Available', 'images/books/1746298757925_to all the boys ive loved before.jpg'),
(28, 'BK0018', 'The Lean Startup', ' Eric Ries', '9888892347316', 'Business', 'Business, organize, economic, development', 'Available', 'images/books/1746349231440_the lean startup.jpg'),
(29, 'BK0021', 'Start with Why', 'Simon Sinek', '9728472347316', 'Business', 'Business, organize, information, economic', 'Available', 'images/books/1746350467288_start with why.jpg'),
(30, 'BK0017', 'Rich Dad Poor Dad', 'Robert Kiyosaki', '9789792333316', 'Business', 'Business, organize, information, development', 'Available', 'images/books/1746350532181_rich dad.jpg'),
(31, 'BK0020', 'Purple Cow', 'Seth Godin', '9789792341212', 'Business', 'Business, organize, leader, economic', 'Available', 'images/books/1746350585701_purple cow.jpg'),
(32, 'BK0003', 'Marketing Revolution', 'Tung Desem Waringin', '9789792217316', 'Business', 'Business, marketing, information, development', 'Available', 'images/books/1746350650121_marketing revolution.jpg'),
(33, 'BK0005', 'Hooked: How to Build Habit-Forming Products', 'Nir Eyal', '9780135191798', 'Business', 'Business, IT, information, development', 'Available', 'images/books/1746350724801_hooked.jpg'),
(34, 'BK0022', 'Good to Great', 'Jim Collins', '9789792347316', 'Business', 'Business, organize, information, development', 'Available', 'images/books/1746350781375_good to great_.jpg'),
(35, 'BK0019', 'Zero to One', 'Peter Thiel', '9789754547316', 'Business', 'Business, organize, information, economic', 'Available', 'images/books/1746350887469_zero to one.jpg'),
(36, 'BK0014', 'My Robot Gets Me: How Social Design Can Make New Products More Human', 'Carla Diana', '9786012223850', 'Computing', 'technology, business, computing', 'Available', 'images/books/1746351172662_my robot gets me.jpg'),
(37, 'BK0004', 'Management Information Systems', 'Kenneth C. Laudon & Jane P. Laudon', '9780135191798', 'Computing', 'Business, IT, information', 'Available', 'images/books/1746351225314_management information system.jpg'),
(39, 'BK0002', 'Life 3.0: Being Human in the Age of Artificial Intelligence', 'Max Tegmark', '9781101970317', 'Computing', 'AI, philosophy, programming, technology, IT', 'Available', 'images/books/1746351582946_life 3.0.jpg'),
(40, 'BK0001', 'Algoritma dan Pemrograman dalam Bahasa Pascal & C', 'Rinaldi Munir', '9789792919975', 'Computing', 'algorithm, logic, technology, programming, IT', 'Available', 'images/books/1746351642044_algoritma pemograman.jpg'),
(41, 'BK0013', 'What To Expect When You’re Expecting Robots: The Future of Human-Robot Collaboration', 'Laura Major & Julie Shah', '9786011113058', 'Computing', 'technology, AI, computing', 'Available', 'images/books/1746351712563_what to expect.jpg'),
(42, 'BK0016', 'The Alignment Problem: Machine Learning and Human Values', 'Brian Christian', '9786012223058', 'Computing', 'technology, AI, computing', 'Available', 'images/books/1746351764340_the alignment problem_.jpg'),
(43, 'BK0012', 'Router Mikrotik: Implementasi Wireless LAN Indoor', 'Rendra Towidjojo & Muhammad Eno Farhan', '9786020823058', 'Computing', 'technology, programming, computing', 'Available', 'images/books/1746351853139_router mikrotik.jpg'),
(44, 'BK0015', 'Reality Check: How Immersive Technologies Can Transform Your Business', 'Jeremy Dalton', '9867012223058', 'Computing', 'technology, AI, computing', 'Available', 'images/books/1746351947052_reality check_.jpg'),
(45, 'BK0026', 'Ken Angrok', 'Damar Shashangka', '9786239043643', 'Historical', 'java, historical, majapahit', 'Available', 'images/books/1746352363336_ken angrok.jpg'),
(46, 'BK0024', 'Sejarah Dunia Yang Disembunyikan', 'Jonathan Black', '9786029193671', 'Historical', 'evolution, historical, earth', 'Available', 'images/books/1746352414665_sejarah dunia.jpg'),
(47, 'BK0023', 'Sapiens', 'Yuval Noah Harari', '9786024244163', 'Historical', 'evolution, historical, earth', 'Available', 'images/books/1746352468629_sapiens.jpg'),
(48, 'BK0006', 'Max Havelaar', 'Multatuli', '9786024246946', 'Historical', 'fiction, novel, historical', 'Available', 'images/books/1746352523828_max havelaar.jpg'),
(49, 'BK0007', 'Laut Bercerita', 'Leila S. Chudori', '9786024246945', 'Historical', 'fiction, novel, historical', 'Available', 'images/books/1746352583886_laut bercerita.jpg'),
(50, 'BK0028', 'Gadis Kretek', 'Ratih Kumala', '9786350008146', 'Historical', 'java, historical, dutch', 'Available', 'images/books/1746352649626_gadis kretek.jpg'),
(51, 'BK0027', 'All The Light We Cannot See', 'Anthony Doerr', '9786230008146', 'Historical', 'evolution, historical, world', 'Available', 'images/books/1746352698622_all the light.jpg'),
(52, 'BK0025', 'Sejarah Peradaban Dunia Kuno Empat Benua', 'Anisa Septianingrum, M.pd.', '9786026595645', 'Historical', 'evolution, historical, world', 'Available', 'images/books/1746352758719_sejarah peradaban.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `password` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `employee`
--

INSERT INTO `employee` (`id`, `name`, `password`) VALUES
(1, 'ADMIN', '12345');

-- --------------------------------------------------------

--
-- Struktur dari tabel `issued`
--

CREATE TABLE `issued` (
  `issue_id` int(11) NOT NULL,
  `book_id` varchar(10) DEFAULT NULL,
  `id_member` varchar(9) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `issued`
--

INSERT INTO `issued` (`issue_id`, `book_id`, `id_member`, `issue_date`, `return_date`, `status`) VALUES
(12, 'BK0011', '012024124', '2025-05-04', '2025-05-11', 'returned'),
(13, 'BK0009', '012024124', '2025-05-04', '2025-05-11', 'returned'),
(14, 'BK0009', '012024124', '2025-04-27', '2025-05-03', 'returned');

-- --------------------------------------------------------

--
-- Struktur dari tabel `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `id_member` varchar(9) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `register_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `member`
--

INSERT INTO `member` (`id`, `id_member`, `name`, `register_date`) VALUES
(2, '012024124', 'friza', '2025-05-04'),
(3, '012024133', 'theresa', '2025-05-04'),
(4, '012024135', 'athira', '2025-05-04'),
(6, '012024145', 'nannan', '2025-05-04'),
(7, '012024154', 'xiaobai', '2025-05-04'),
(10, '98765432', 'friza', NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `book_id` (`book_id`);

--
-- Indeks untuk tabel `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `issued`
--
ALTER TABLE `issued`
  ADD PRIMARY KEY (`issue_id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `id_member` (`id_member`);

--
-- Indeks untuk tabel `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_member` (`id_member`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT untuk tabel `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `issued`
--
ALTER TABLE `issued`
  MODIFY `issue_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `member`
--
ALTER TABLE `member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `issued`
--
ALTER TABLE `issued`
  ADD CONSTRAINT `issued_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `issued_ibfk_2` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
