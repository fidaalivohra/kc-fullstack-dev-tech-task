-- up
CREATE TABLE `courses` (
    `id` CHAR(36) PRIMARY KEY DEFAULT (CONCAT('L', UUID_SHORT())),
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `image_preview` VARCHAR(255),
    `category_id` CHAR(36),
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
);

INSERT INTO `courses` (`id`, `name`, `description`, `image_preview`, `category_id`, `created_at`, `updated_at`) VALUES
('fc569093-0d62-11f0-8760-cc47405f3f4f', 'Full Stack Development (Laravel,PHP,MySQL)', 'dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd ', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373349028/800--v112240.jpg', '9b908c1f-0d62-11f0-8760-cc47405f3f4f', '2025-03-30 12:32:03', '2025-03-30 14:16:07'),
('fc569093-0d62-11f0-8760-cc42505f3f4f', 'Full Stack Development (Laravel,PHP,MySQL)', 'dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd dfd dsds sf sdf sdf sd ', 'https://cdn0.knowledgecity.com/opencontent/courses/previews/L373349028/800--v112240.jpg', '9b8ff6bb-0d62-11f0-8760-cc47405f3f4f', '2025-03-30 12:32:03', '2025-03-30 15:32:46');

-- down
DROP TABLE `courses`;