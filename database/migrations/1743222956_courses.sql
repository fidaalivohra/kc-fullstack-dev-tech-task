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

INSERT INTO `courses` (`name`, `description`, `image_preview`, `category_id`)
VALUES ('PHP', '', NULL, '91aad7bb-5885-4a25-bbdc-046dd4b2a9e6'),
       ('MySQL', '', NULL, 'c4064741-d191-49c5-b141-7943d063cfc3'),
       ('JavaScript', '', NULL, '91aad7bb-5885-4a25-bbdc-046dd4b2a9e6'),
       ('HTML', '', NULL, '91aad7bb-5885-4a25-bbdc-046dd4b2a9e6'),
       ('CSS', '', NULL, '91aad7bb-5885-4a25-bbdc-046dd4b2a9e6'),
       ('Java', '', NULL, '91aad7bb-5885-4a25-bbdc-046dd4b2a9e6'),
       ('C++', '', NULL, '91aad7bb-5885-4a25-bbdc-046dd4b2a9e6'),
       ('Python', '', NULL, '91aad7bb-5885-4a25-bbdc-046dd4b2a9e6');

-- down
DROP TABLE `courses`;