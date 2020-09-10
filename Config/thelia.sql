
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- custom_shipping_zone_fees_zip
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `custom_shipping_zone_fees_zip`;

CREATE TABLE `custom_shipping_zone_fees_zip`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `custom_shipping_zone_fees_id` INTEGER NOT NULL,
    `country_id` INTEGER NOT NULL,
    `zip_code` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `FI_custom_shipping_zone_fees_id` (`custom_shipping_zone_fees_id`),
    INDEX `FI_country_id` (`country_id`),
    CONSTRAINT `fk_custom_shipping_zone_fees_id`
        FOREIGN KEY (`custom_shipping_zone_fees_id`)
        REFERENCES `custom_shipping_zone_fees` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE,
    CONSTRAINT `fk_country_id`
        FOREIGN KEY (`country_id`)
        REFERENCES `country` (`id`)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- custom_shipping_zone_fees
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `custom_shipping_zone_fees`;

CREATE TABLE `custom_shipping_zone_fees`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fee` FLOAT,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- custom_shipping_zone_fees_modules
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `custom_shipping_zone_fees_modules`;

CREATE TABLE `custom_shipping_zone_fees_modules`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `custom_shipping_zone_fees_id` INTEGER NOT NULL,
    `module_id` INTEGER NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `FI_custom_shipping_zone_fees_module_id` (`module_id`),
    INDEX `FI_module_custom_shipping_zone_fees_id` (`custom_shipping_zone_fees_id`),
    CONSTRAINT `fk_custom_shipping_zone_fees_module_id`
        FOREIGN KEY (`module_id`)
        REFERENCES `module` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE,
    CONSTRAINT `fk_module_custom_shipping_zone_fees_id`
        FOREIGN KEY (`custom_shipping_zone_fees_id`)
        REFERENCES `custom_shipping_zone_fees` (`id`)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- custom_shipping_zone_fees_i18n
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `custom_shipping_zone_fees_i18n`;

CREATE TABLE `custom_shipping_zone_fees_i18n`
(
    `id` INTEGER NOT NULL,
    `locale` VARCHAR(5) DEFAULT 'en_US' NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY (`id`,`locale`),
    CONSTRAINT `custom_shipping_zone_fees_i18n_FK_1`
        FOREIGN KEY (`id`)
        REFERENCES `custom_shipping_zone_fees` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
