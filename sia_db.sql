-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2023 at 04:19 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sia_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `ptg_cart_items`
--

CREATE TABLE `ptg_cart_items` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `cart_item_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ptg_orders`
--

CREATE TABLE `ptg_orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_status` varchar(15) NOT NULL,
  `order_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ptg_order_details`
--

CREATE TABLE `ptg_order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ptg_payments`
--

CREATE TABLE `ptg_payments` (
  `payment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_type` int(1) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `expiration_date` varchar(5) NOT NULL,
  `card_verification_code` varchar(3) NOT NULL,
  `payment_date` date NOT NULL,
  `total_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ptg_products`
--

CREATE TABLE `ptg_products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(80) NOT NULL,
  `product_price` decimal(10,2) NOT NULL,
  `product_description` varchar(255) NOT NULL,
  `product_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ptg_products`
--

INSERT INTO `ptg_products` (`product_id`, `product_name`, `product_price`, `product_description`, `product_image`) VALUES
(1, 'Corsair K95 RGB Platinum XT', '13320.00', 'The CORSAIR K95 RGB PLATINUM XT Mechanical Gaming Keyboard immerses your desktop in dynamic per-key RGB backlighting, equipped with a double-shot PBT keycap set and six dedicated macro keys with Elgato Stream Deck software integration.', 'images/corsair.jpg'),
(2, 'Logitech G Pro X', '7999.00', 'The tournament-proven PRO design, now with your choice of swappable pro-grade GX mechanical switches: Clicky, Tactile and Linear. Built to win in collaboration with the world’s top esports athletes.', 'images/logitech.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `ptg_users`
--

CREATE TABLE `ptg_users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(55) NOT NULL,
  `password` varchar(15) NOT NULL,
  `contact_number` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ptg_users`
--

INSERT INTO `ptg_users` (`user_id`, `first_name`, `last_name`, `address`, `email`, `password`, `contact_number`) VALUES
(1, 'Micoh', 'Yabut', 'angeles city', 'micoh@email.com', '1234', '09366776982');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ptg_cart_items`
--
ALTER TABLE `ptg_cart_items`
  ADD UNIQUE KEY `product_id` (`product_id`),
  ADD KEY `ptg_cart_items_ibfk_3` (`user_id`);

--
-- Indexes for table `ptg_orders`
--
ALTER TABLE `ptg_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ptg_order_details`
--
ALTER TABLE `ptg_order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `ptg_payments`
--
ALTER TABLE `ptg_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ptg_products`
--
ALTER TABLE `ptg_products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `ptg_users`
--
ALTER TABLE `ptg_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `contact_number` (`contact_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ptg_orders`
--
ALTER TABLE `ptg_orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `ptg_order_details`
--
ALTER TABLE `ptg_order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `ptg_payments`
--
ALTER TABLE `ptg_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ptg_products`
--
ALTER TABLE `ptg_products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ptg_users`
--
ALTER TABLE `ptg_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ptg_cart_items`
--
ALTER TABLE `ptg_cart_items`
  ADD CONSTRAINT `ptg_cart_items_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `ptg_users` (`user_id`),
  ADD CONSTRAINT `ptg_cart_items_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `ptg_products` (`product_id`);

--
-- Constraints for table `ptg_orders`
--
ALTER TABLE `ptg_orders`
  ADD CONSTRAINT `ptg_orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `ptg_users` (`user_id`);

--
-- Constraints for table `ptg_order_details`
--
ALTER TABLE `ptg_order_details`
  ADD CONSTRAINT `ptg_order_details_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `ptg_products` (`product_id`),
  ADD CONSTRAINT `ptg_order_details_ibfk_5` FOREIGN KEY (`order_id`) REFERENCES `ptg_orders` (`order_id`);

--
-- Constraints for table `ptg_payments`
--
ALTER TABLE `ptg_payments`
  ADD CONSTRAINT `ptg_payments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `ptg_users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
