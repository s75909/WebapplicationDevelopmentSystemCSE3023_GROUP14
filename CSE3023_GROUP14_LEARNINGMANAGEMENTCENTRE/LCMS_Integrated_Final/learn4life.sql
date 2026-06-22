CREATE DATABASE learn4life;
USE learn4life;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


CREATE TABLE `attendance_records` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `status` enum('Present','Absent') NOT NULL,
  `time_in` varchar(20) DEFAULT NULL,
  `record_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `attendance_records` (`id`, `student_id`, `status`, `time_in`, `record_date`) VALUES
(4, 5, 'Present', '15:36', '2026-06-19'),
(5, 6, 'Present', '15:36', '2026-06-19'),
(6, 7, 'Present', '15:02', '2026-06-19'),
(7, 8, 'Present', '15:02', '2026-06-19'),
(8, 9, 'Present', '15:02', '2026-06-19'),
(9, 11, 'Absent', '', '2026-06-19'),
(10, 10, 'Absent', '', '2026-06-19');



CREATE TABLE `classrooms` (
  `class_id` int(11) NOT NULL,
  `class_name` varchar(100) NOT NULL,
  `class_level` varchar(100) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `classrooms` (`class_id`, `class_name`, `class_level`, `teacher_id`, `capacity`) VALUES
(1, 'Kelas K4-A', 'Kindergarten 4', NULL, 25),
(2, 'Kelas K5-A', 'Kindergarten 5', 2, 25),
(10, 'Anak baik', 'K4-B', 2, 25),
(11, '6 Delima', 'K6-A', 3, 20),
(12, '6 Intan', 'K6-A', 2, 20),
(13, '6 Delima', 'K6-A', 2, 20),
(14, '5 Cempaka', 'K5', 3, 4);




CREATE TABLE `daily_attendance_view` (
`id` int(11)
,`student_id` int(11)
,`student_name` varchar(201)
,`class_name` varchar(100)
,`status` enum('Present','Absent')
,`time_in` varchar(20)
,`record_date` date
);



CREATE TABLE `managers` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `managers` (`id`, `username`, `password`, `email`) VALUES
(1, 'admin', 'admin123', 'admin@learn4life.com'),
(2, 'manager', 'manager123', 'manager@learn4life.com');



CREATE TABLE `parents` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `ic` varchar(20) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `parents` (`id`, `username`, `ic`, `password`, `email`, `phone`, `age`, `occupation`, `address`) VALUES
(2, 'izwan', NULL, 'parent123', 'izwan@gmail.com', '+60143245568', 42, 'Teacher', 'Kuala Nerus'),
(4, 'saidah', '671104085000', 'saidah', 'saidah@gmail.com', '012345678', 56, 'Doctor', 'Taiping'),
(5, 'dini', 'abc', 'dini', 'dini@gmail.com', 'abc', 43, 'doctor', 'kelantan');



CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `child_name` varchar(150) NOT NULL,
  `payment_for` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `receipt_path` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Paid','Rejected') NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `payment` (`payment_id`, `child_name`, `payment_for`, `amount`, `payment_date`, `receipt_path`, `status`) VALUES
(1, 'Izza Hazira', 'Monthly Fee', 300.00, '2026-05-13', 'uploads/sample1.jpg', 'Paid'),
(3, 'Muhammad Ikhwan', 'Activity Fee', 100.00, '2026-06-10', 'uploads/sample3.jpg', 'Rejected'),
(4, 'izaty halila', 'Activity Fee', 100.00, '2026-06-19', 'uploads/Screenshot 2026-01-20 115618.png', 'Paid'),
(5, 'izman haiqal', 'Activity Fee', 100.00, '2026-06-19', 'uploads/Screenshot 2026-01-20 121154.png', 'Pending'),
(6, 'ikhwan muhammad', 'Monthly Fee', 300.00, '2026-06-19', 'uploads/Screenshot 2026-01-20 112738.png', 'Paid');



CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `guardian` varchar(150) DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `students` (`id`, `first_name`, `last_name`, `dob`, `gender`, `guardian`, `relationship`, `phone`, `email`, `parent_id`, `class_id`) VALUES
(5, 'Muhammad', 'Gunwoo', '2026-06-03', 'male', 'Ikhwan', 'Papa', '1234567', 'gaku@gmail.com', 2, 14),
(6, 'Muhd', 'Fairuz', '2026-06-04', 'female', 'Ikhwan', 'Papa', '1234567', 'muhdikhwan31102005@gmail.com', 2, 14),
(7, 'Muhd', 'Fairuz', '2026-06-04', 'female', 'Ikhwan', 'Papa', '1234567', 'muhdikhwan31102005@gmail.com', 2, 13),
(8, 'Muhd', 'Fairuz', '2026-06-04', 'female', 'Ikhwan', 'Papa', '1234567', 'muhdikhwan31102005@gmail.com', 2, 13),
(9, 'Muhd', 'Fairuz', '2026-06-03', 'female', 'Ikhwan', 'Papa', '1234567', 'muhdikhwan31102005@gmail.com', 2, 13),
(10, 'izaty', 'halila', '2026-06-01', 'female', 'saidah', 'Mother', '01234567', 'saidah@gmail.com', 4, 14),
(11, 'daud', 'halila', '2026-06-01', 'male', 'saidah', 'Mother', '01234567', 'saidah@gmail.com', 4, 14),
(12, 'izman', 'haiqal', '2026-06-22', 'male', 'saidah', 'Mother', '01234567', 'saidah@gmail.com', 4, 14),
(13, 'ikhwan', 'muhammad', '2026-06-15', 'male', 'saidah', 'Mother', '01234567', 'saidah@gmail.com', 4, 14);


CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `ic_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `qualification` varchar(150) DEFAULT NULL,
  `teaching_experience` varchar(100) DEFAULT NULL,
  `subject` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `teachers` (`id`, `username`, `password`, `full_name`, `ic_number`, `email`, `phone`, `qualification`, `teaching_experience`, `subject`) VALUES
(2, 'teacher2', 'teacher123', 'Siti Nurhaliza Binti Ali', '920202-11-5678', 'teacher2@learn4life.com', '+60198765432', 'Diploma in Early Childhood Education', '3 years', 'Reading, Bahasa Melayu'),
(3, 'teacher3', 'teacher123', 'cikgu abu', '050917-03-0099', 'yoshin@gmail.com', '01234567', 'bachelor of edu', '1', 'math');


DROP TABLE IF EXISTS `daily_attendance_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daily_attendance_view`  AS SELECT `ar`.`id` AS `id`, `ar`.`student_id` AS `student_id`, concat(`s`.`first_name`,' ',coalesce(`s`.`last_name`,'')) AS `student_name`, `c`.`class_name` AS `class_name`, `ar`.`status` AS `status`, `ar`.`time_in` AS `time_in`, `ar`.`record_date` AS `record_date` FROM ((`attendance_records` `ar` join `students` `s` on(`ar`.`student_id` = `s`.`id`)) left join `classrooms` `c` on(`s`.`class_id` = `c`.`class_id`)) ;


ALTER TABLE `attendance_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

ALTER TABLE `classrooms`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `teacher_id` (`teacher_id`);


ALTER TABLE `managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);


ALTER TABLE `parents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);


ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`);


ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `class_id` (`class_id`);


ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);


ALTER TABLE `attendance_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;


ALTER TABLE `classrooms`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;


ALTER TABLE `managers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;


ALTER TABLE `parents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;


ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;


ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;


ALTER TABLE `attendance_records`
  ADD CONSTRAINT `attendance_records_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `classrooms`
  ADD CONSTRAINT `classrooms_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parents` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classrooms` (`class_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

