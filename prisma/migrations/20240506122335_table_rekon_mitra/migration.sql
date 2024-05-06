-- CreateTable
CREATE TABLE `rekon_mitra` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `startdate` DATE NULL,
    `enddate` DATE NULL,
    `user_id` INTEGER NOT NULL,
    `namauser` VARCHAR(50) NOT NULL,
    `data` JSON NOT NULL,
    `flagverifikasi` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
