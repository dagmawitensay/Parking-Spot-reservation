/*
  Warnings:

  - You are about to drop the column `location` on the `parking_compound` table. All the data in the column will be lost.
  - Added the required column `Kebele` to the `parking_compound` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Region` to the `parking_compound` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Wereda` to the `parking_compound` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Zone` to the `parking_compound` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `parking_compound` DROP COLUMN `location`,
    ADD COLUMN `Kebele` INTEGER NOT NULL,
    ADD COLUMN `Region` VARCHAR(200) NOT NULL,
    ADD COLUMN `Wereda` VARCHAR(200) NOT NULL,
    ADD COLUMN `Zone` VARCHAR(200) NOT NULL;
