/*
  Warnings:

  - Added the required column `Kebele` to the `parking_compound` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Region` to the `parking_compound` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Wereda` to the `parking_compound` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Zone` to the `parking_compound` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `parking_compound` ADD COLUMN `Kebele` VARCHAR(250) NOT NULL,
    ADD COLUMN `Region` VARCHAR(250) NOT NULL,
    ADD COLUMN `Wereda` VARCHAR(250) NOT NULL,
    ADD COLUMN `Zone` VARCHAR(250) NOT NULL;
