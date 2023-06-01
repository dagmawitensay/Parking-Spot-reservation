/*
  Warnings:

  - You are about to drop the column `phone_no` on the `compound_owner` table. All the data in the column will be lost.
  - You are about to drop the column `phone_no` on the `spot_user` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `compound_owner` DROP COLUMN `phone_no`;

-- AlterTable
ALTER TABLE `spot_user` DROP COLUMN `phone_no`;

-- AddForeignKey
ALTER TABLE `compound_owner` ADD CONSTRAINT `compound_owner_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `spot_user` ADD CONSTRAINT `spot_user_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
