-- AlterTable
ALTER TABLE `spot_user` MODIFY `role` ENUM('owner', 'parker') NOT NULL DEFAULT 'parker';
