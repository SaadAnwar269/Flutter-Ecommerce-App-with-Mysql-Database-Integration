-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 06, 2024 at 03:27 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `is_favourite` tinyint(1) DEFAULT 0,
  `is_popular` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `description`, `image_url`, `price`, `is_favourite`, `is_popular`) VALUES
(1, 'Wireless Controller for PS4™', 'Enjoy long gaming hours with a longer battery', 'assets/images/z.png', 64.99, 0, 0),
(2, 'Nike Sport White - Man Pant', 'Makes you look extra niKe ;)', 'assets/images/Image Popular Product 2.png', 50.5, 0, 1),
(3, 'Gloves XC Omega - Polygon', 'Streetwear style and practicality fused together', 'assets/images/glap.png', 36.55, 1, 1),
(4, 'Logitech Head', 'An ideal headphone for long gaming and productivity sessions', 'assets/images/wireless headset.png', 20.2, 1, 1),
(5, 'Wireless Mouse', 'Ergonomic design for comfortable use during long working hours', 'assets/images/a.png', 19.99, 0, 0),
(6, 'Running Shoes', 'Designed for superior comfort and performance during your runs', 'assets/images/b.png', 69.99, 0, 1),
(7, 'Leather Wallet', 'Stylish and durable wallet crafted from premium leather', 'assets/images/c.png', 45.99, 1, 1),
(8, 'Stainless Steel Watch', 'Elegant timepiece with a classic design suitable for any occasion', 'assets/images/d.png', 99.99, 1, 1),
(9, 'Portable Bluetooth Speaker', 'Enjoy high-quality sound on the go with this compact speaker', 'assets/images/e.png', 39.99, 0, 0),
(10, 'Yoga Mat', 'Non-slip surface for a comfortable and stable yoga practice', 'assets/images/f.png', 29.99, 0, 1),
(11, 'Digital Camera', 'Capture your memories in stunning detail with this advanced camera', 'assets/images/g.png', 249.99, 1, 1),
(12, 'Backpack', 'Spacious and durable backpack for daily commutes or outdoor adventures', 'assets/images/h.png', 59.99, 1, 0),
(13, 'Gaming Keyboard', 'Mechanical keyboard with customizable RGB lighting for immersive gaming experience', 'assets/images/i.png', 79.99, 0, 1),
(14, 'Wireless Earbuds', 'True wireless earbuds with noise-canceling technology for crystal-clear audio', 'assets/images/j.png', 129.99, 1, 1),
(15, 'Smartphone Stand', 'Adjustable stand to keep your smartphone at the perfect viewing angle', 'assets/images/k.png', 14.99, 0, 0),
(16, 'Cycling Helmet', 'Safety-certified helmet designed for comfortable and secure cycling', 'assets/images/l.png', 49.99, 1, 0),
(17, 'Coffee Maker', 'Brew delicious coffee at home with this easy-to-use coffee maker', 'assets/images/m.png', 79.99, 0, 1),
(18, 'Travel Mug', 'Insulated mug to keep your beverages hot or cold while on the go', 'assets/images/n.png', 19.99, 0, 0),
(19, 'Resistance Bands', 'Versatile fitness bands for strength training and rehabilitation exercises', 'assets/images/o.png', 24.99, 1, 1),
(20, 'Wireless Charger', 'Charge your compatible devices wirelessly with this sleek charging pad', 'assets/images/p.png', 34.99, 0, 1),
(21, 'Desk Lamp', 'Adjustable LED lamp for studying or working late into the night', 'assets/images/q.png', 39.99, 1, 0),
(22, 'Gaming Mousepad', 'Large mousepad with smooth surface for precise gaming control', 'assets/images/r.png', 14.99, 0, 1),
(23, 'Running Jacket', 'Lightweight and water-resistant jacket for running in all weather conditions', 'assets/images/s.png', 79.99, 1, 1),
(24, 'Portable Power Bank', 'High-capacity power bank to keep your devices charged on the go', 'assets/images/t.png', 49.99, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `Id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `Daddress` varchar(255) NOT NULL,
  `Baddress` varchar(255) NOT NULL,
  `gender` enum('Male','Female') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reg`
--

CREATE TABLE `reg` (
  `Id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `userId` (`userId`),
  ADD KEY `User` (`userId`);

--
-- Indexes for table `reg`
--
ALTER TABLE `reg`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `profile`
--
ALTER TABLE `profile`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `reg`
--
ALTER TABLE `reg`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `reg` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `profile`
--
ALTER TABLE `profile`
  ADD CONSTRAINT `User` FOREIGN KEY (`userId`) REFERENCES `reg` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
