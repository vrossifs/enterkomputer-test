-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 05, 2024 at 03:02 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `enterkomputer`
--

-- --------------------------------------------------------

--
-- Table structure for table `meja`
--

CREATE TABLE `meja` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meja`
--

INSERT INTO `meja` (`id`, `name`) VALUES
(1, 'MEJA NO 1'),
(2, 'MEJA NO 2'),
(3, 'MEJA NO 3');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `type` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `name`, `price`, `type`, `status`, `start_date`, `end_date`, `created_at`) VALUES
(1, 'Jeruk DINGIN', '12000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(2, 'Jeruk PANAS', '10000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(3, 'Teh MANIS', '8000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(4, 'Teh TAWAR', '5000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(5, 'Kopi DINGIN', '8000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(6, 'Kopi PANAS', '6000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(7, 'EXTRA ES BATU', '2000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(8, 'Mie GORENG', '15000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(9, 'Mie KUAH', '15000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(10, 'Nasi Goreng', '15000.00', 'Normal', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36'),
(11, 'Promo Nasi Goreng + Jeruk DINGIN', '23000.00', 'Promo', 'Available', '2024-01-01', '9999-12-31', '2024-08-04 20:04:36');

-- --------------------------------------------------------

--
-- Table structure for table `menu_detail`
--

CREATE TABLE `menu_detail` (
  `id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_detail`
--

INSERT INTO `menu_detail` (`id`, `id_menu`, `id_product`, `created_at`) VALUES
(1, 1, 1, '2024-08-04 20:16:29'),
(2, 2, 2, '2024-08-04 20:16:29'),
(3, 3, 3, '2024-08-04 20:16:29'),
(4, 4, 4, '2024-08-04 20:16:29'),
(5, 5, 5, '2024-08-04 20:16:29'),
(6, 6, 6, '2024-08-04 20:16:29'),
(7, 7, 7, '2024-08-04 20:16:29'),
(8, 8, 8, '2024-08-04 20:16:29'),
(9, 9, 9, '2024-08-04 20:16:29'),
(10, 10, 10, '2024-08-04 20:16:29'),
(11, 11, 10, '2024-08-04 20:16:29'),
(12, 11, 1, '2024-08-04 20:16:29');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `id_meja` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `id_meja`, `status`, `created_at`) VALUES
(1, 1, 'ON GOING', '2024-08-05 20:01:03');

-- --------------------------------------------------------

--
-- Table structure for table `orders_detail`
--

CREATE TABLE `orders_detail` (
  `id` int(11) NOT NULL,
  `id_orders` int(11) NOT NULL,
  `id_menu` varchar(255) NOT NULL,
  `quantity` decimal(10,0) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders_detail`
--

INSERT INTO `orders_detail` (`id`, `id_orders`, `id_menu`, `quantity`, `notes`) VALUES
(1, 1, '1', '1', ''),
(2, 1, '6', '1', 'Tambah gula sedikit'),
(3, 1, '11', '2', ''),
(4, 1, '3', '1', 'Hangat'),
(5, 1, '8', '1', 'Pedas');

-- --------------------------------------------------------

--
-- Table structure for table `printer`
--

CREATE TABLE `printer` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `station` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `printer`
--

INSERT INTO `printer` (`id`, `name`, `station`) VALUES
(1, 'Printer Kasir', 'A'),
(2, 'Printer Dapur', 'B'),
(3, 'Printer Bar', 'C');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `variant` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `variant`, `category`, `created_at`) VALUES
(1, 'Jeruk', 'DINGIN', 'Minuman', '2024-08-04 19:46:33'),
(2, 'Jeruk', 'PANAS', 'Minuman', '2024-08-04 19:46:33'),
(3, 'Teh', 'MANIS', 'Minuman', '2024-08-04 19:46:33'),
(4, 'Teh', 'TAWAR', 'Minuman', '2024-08-04 19:46:33'),
(5, 'Kopi', 'DINGIN', 'Minuman', '2024-08-04 19:46:33'),
(6, 'Kopi', 'PANAS', 'Minuman', '2024-08-04 19:46:33'),
(7, 'EXTRA ES BATU', '', 'Minuman', '2024-08-04 19:46:33'),
(8, 'Mie', 'GORENG', 'Makanan', '2024-08-04 19:46:33'),
(9, 'Mie', 'KUAH', 'Makanan', '2024-08-04 19:46:33'),
(10, 'Nasi Goreng', '', 'Makanan', '2024-08-04 19:46:33');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_menu_detail`
-- (See below for the actual view)
--
CREATE TABLE `v_menu_detail` (
`id` int(11)
,`created_at` datetime
,`id_menu` int(11)
,`name_menu` varchar(255)
,`price` decimal(10,2)
,`type` varchar(255)
,`status` varchar(255)
,`start_date` date
,`end_date` date
,`created_at_menu` datetime
,`id_product` int(11)
,`name_product` varchar(255)
,`variant` varchar(255)
,`category` varchar(255)
,`created_at_product` datetime
,`id_printer` int(11)
,`name_printer` varchar(255)
,`station` varchar(25)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_orders`
-- (See below for the actual view)
--
CREATE TABLE `v_orders` (
`id` int(11)
,`status` varchar(255)
,`created_at` datetime
,`id_meja` int(11)
,`name` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_orders_detail`
-- (See below for the actual view)
--
CREATE TABLE `v_orders_detail` (
`id` int(11)
,`quantity` decimal(10,0)
,`notes` text
,`id_orders` int(11)
,`status` varchar(255)
,`created_at` datetime
,`id_meja` int(11)
,`name` varchar(255)
,`id_menu` varchar(255)
,`name_menu` varchar(255)
,`price` decimal(10,2)
,`type` varchar(255)
,`status_menu` varchar(255)
,`start_date` date
,`end_date` date
,`created_at_menu` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_product`
-- (See below for the actual view)
--
CREATE TABLE `v_product` (
`id` int(11)
,`name` varchar(255)
,`variant` varchar(255)
,`category` varchar(255)
,`created_at` datetime
,`id_printer` int(11)
,`name_printer` varchar(255)
,`station` varchar(25)
);

-- --------------------------------------------------------

--
-- Structure for view `v_menu_detail`
--
DROP TABLE IF EXISTS `v_menu_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_menu_detail`  AS SELECT `x`.`id` AS `id`, `x`.`created_at` AS `created_at`, `x`.`id_menu` AS `id_menu`, `m`.`name` AS `name_menu`, `m`.`price` AS `price`, `m`.`type` AS `type`, `m`.`status` AS `status`, `m`.`start_date` AS `start_date`, `m`.`end_date` AS `end_date`, `m`.`created_at` AS `created_at_menu`, `x`.`id_product` AS `id_product`, `p`.`name` AS `name_product`, `p`.`variant` AS `variant`, `p`.`category` AS `category`, `p`.`created_at` AS `created_at_product`, `p`.`id_printer` AS `id_printer`, `p`.`name_printer` AS `name_printer`, `p`.`station` AS `station` FROM ((`menu_detail` `x` left join `menu` `m` on(`x`.`id_menu` = `m`.`id`)) left join `v_product` `p` on(`x`.`id_product` = `p`.`id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_orders`
--
DROP TABLE IF EXISTS `v_orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_orders`  AS SELECT `x`.`id` AS `id`, `x`.`status` AS `status`, `x`.`created_at` AS `created_at`, `x`.`id_meja` AS `id_meja`, `m`.`name` AS `name` FROM (`orders` `x` left join `meja` `m` on(`x`.`id_meja` = `m`.`id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_orders_detail`
--
DROP TABLE IF EXISTS `v_orders_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_orders_detail`  AS SELECT `x`.`id` AS `id`, `x`.`quantity` AS `quantity`, `x`.`notes` AS `notes`, `x`.`id_orders` AS `id_orders`, `o`.`status` AS `status`, `o`.`created_at` AS `created_at`, `o`.`id_meja` AS `id_meja`, `o`.`name` AS `name`, `x`.`id_menu` AS `id_menu`, `m`.`name` AS `name_menu`, `m`.`price` AS `price`, `m`.`type` AS `type`, `m`.`status` AS `status_menu`, `m`.`start_date` AS `start_date`, `m`.`end_date` AS `end_date`, `m`.`created_at` AS `created_at_menu` FROM ((`orders_detail` `x` left join `v_orders` `o` on(`x`.`id_orders` = `o`.`id`)) left join `menu` `m` on(`x`.`id_menu` = `m`.`id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `v_product`
--
DROP TABLE IF EXISTS `v_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_product`  AS SELECT `x`.`id` AS `id`, `x`.`name` AS `name`, `x`.`variant` AS `variant`, `x`.`category` AS `category`, `x`.`created_at` AS `created_at`, `p`.`id` AS `id_printer`, `p`.`name` AS `name_printer`, `p`.`station` AS `station` FROM (`product` `x` left join `printer` `p` on(case when `x`.`category` = 'Makanan' then 2 when `x`.`category` = 'Minuman' then 3 else 1 end = `p`.`id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `meja`
--
ALTER TABLE `meja`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_detail`
--
ALTER TABLE `menu_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders_detail`
--
ALTER TABLE `orders_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `printer`
--
ALTER TABLE `printer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `meja`
--
ALTER TABLE `meja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `menu_detail`
--
ALTER TABLE `menu_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders_detail`
--
ALTER TABLE `orders_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `printer`
--
ALTER TABLE `printer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
