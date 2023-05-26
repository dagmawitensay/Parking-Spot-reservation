/*
  Warnings:

  - You are about to alter the column `role` on the `compound_owner` table. The data in that column could be lost. The data in that column will be cast from `VarChar(150)` to `Enum(EnumId(1))`.
  - You are about to alter the column `role` on the `spot_user` table. The data in that column could be lost. The data in that column will be cast from `VarChar(150)` to `Enum(EnumId(1))`.

*/
-- AlterTable
ALTER TABLE `compound_owner` MODIFY `role` ENUM('owner', 'parker') NOT NULL DEFAULT 'owner';

-- AlterTable
ALTER TABLE `spot_user` MODIFY `role` ENUM('owner', 'parker') NOT NULL DEFAULT 'owner';
