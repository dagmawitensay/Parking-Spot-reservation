/*
  Warnings:

  - A unique constraint covering the columns `[user_id]` on the table `compound_owner` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[user_id]` on the table `spot_user` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_id` to the `compound_owner` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `spot_user` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `compound_owner` ADD COLUMN `user_id` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `spot_user` ADD COLUMN `user_id` INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `compound_owner_user_id_key` ON `compound_owner`(`user_id`);

-- CreateIndex
CREATE UNIQUE INDEX `spot_user_user_id_key` ON `spot_user`(`user_id`);

-- AddForeignKey
ALTER TABLE `compound_owner` ADD CONSTRAINT `compound_owner_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `spot_user` ADD CONSTRAINT `spot_user_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
