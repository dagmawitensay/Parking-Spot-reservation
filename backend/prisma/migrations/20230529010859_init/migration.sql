/*
  Warnings:

  - Added the required column `name` to the `parking_compound` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `parking_compound` ADD COLUMN `name` VARCHAR(250) NOT NULL;

-- AddForeignKey
ALTER TABLE `compound_owner` ADD CONSTRAINT `compound_owner_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `spot_user` ADD CONSTRAINT `spot_user_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
