/*
  Warnings:

  - Added the required column `password` to the `compound_owner` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `spot_user` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `compound_owner` ADD COLUMN `password` VARCHAR(150) NOT NULL;

-- AlterTable
ALTER TABLE `spot_user` ADD COLUMN `password` VARCHAR(150) NOT NULL;
