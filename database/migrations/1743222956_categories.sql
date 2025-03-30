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

INSERT INTO `categories` (`id`, `name`)
VALUES ('91aad7bb-5885-4a25-bbdc-046dd4b2a9e6', 'Technology', '', NULL),
       ('c4064741-d191-49c5-b141-7943d063cfc3', 'MySQL', '', NULL);

-- down
DROP TABLE `categories`;