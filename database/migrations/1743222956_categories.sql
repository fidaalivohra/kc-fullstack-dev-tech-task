-- up
CREATE TABLE `categories` (
    `id` CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `parent_id` VARCHAR(255),
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`parent_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
);

INSERT INTO `categories` (`id`, `name`, `description`, `parent_id`, `created_at`, `updated_at`) VALUES
('2daf04e1-0d61-11f0-8760-cc47405f3f4f', 'Technology', NULL, NULL, '2025-03-30 12:19:07', '2025-03-30 12:19:07'),
('9b8ff6bb-0d62-11f0-8760-cc47405f3f4f', 'Software Development', NULL, '2daf04e1-0d61-11f0-8760-cc47405f3f4f', '2025-03-30 12:29:21', '2025-03-30 12:29:30'),
('9b9021f0-0d62-11f0-8760-cc47405f3f4f', 'Hardware Engineering', NULL, '2daf04e1-0d61-11f0-8760-cc47405f3f4f', '2025-03-30 12:29:21', '2025-03-30 15:32:36'),
('9b908c1f-0d62-11f0-8760-cc47405f3f4f', 'Hardware Engineering', NULL, '9b9021f0-0d62-11f0-8760-cc47405f3f4f', '2025-03-30 12:29:21', '2025-03-30 12:29:48');

-- down
DROP TABLE `categories`;