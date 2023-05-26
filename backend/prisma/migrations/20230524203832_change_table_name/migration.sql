/*
  Warnings:

  - You are about to drop the column `email` on the `compound_owner` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `compound_owner` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `compound_owner` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `spot_user` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `spot_user` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `spot_user` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX `compound_owner_email_key` ON `compound_owner`;

-- DropIndex
DROP INDEX `spot_user_email_key` ON `spot_user`;

-- AlterTable
ALTER TABLE `compound_owner` DROP COLUMN `email`,
    DROP COLUMN `password`,
    DROP COLUMN `role`;

-- AlterTable
ALTER TABLE `spot_user` DROP COLUMN `email`,
    DROP COLUMN `password`,
    DROP COLUMN `role`;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_name` VARCHAR(200) NOT NULL,
    `hash` VARCHAR(200) NOT NULL,
    `refresh_token` VARCHAR(200) NULL,
    `role` ENUM('owner', 'reserver') NOT NULL DEFAULT 'reserver',
    `email` VARCHAR(250) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
