/*
  Warnings:

  - You are about to drop the column `tgl` on the `setup_denda` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `setup_denda` DROP COLUMN `tgl`,
    ADD COLUMN `tgl1` SMALLINT NULL,
    ADD COLUMN `tgl2` SMALLINT NULL;
