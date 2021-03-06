
-- ---------------------------------------------------------------------------
--
-- Fabricate transition table
--
DROP   TABLE  IF EXISTS `taks_rawk`.`student_trans`
; 
CREATE TABLE  `taks_rawk`.`student_trans` (
  `y1`   	SMALLINT(4) 	UNSIGNED 	  NOT NULL	COMMENT '',
  `id` 		MEDIUMINT 	UNSIGNED ZEROFILL NOT NULL	COMMENT '',
  `campus_id1` 	INT(9) 		UNSIGNED ZEROFILL DEFAULT NULL	COMMENT '',
  `grade1` 	TINYINT(2) 	UNSIGNED 	  DEFAULT NULL	COMMENT '',
  `m_bin1` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'binned raw;    NULL, 0, 1, .. 9',
  `m_met1` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'met standards  NULL, 0, 1', 
  `m_com1` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'commended      NULL, 0, 1', 
  `m_scode1` 	CHAR(1) 		 	  DEFAULT NULL	COMMENT 'status code',
  `ethnic1` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'Ethnicity;     NULL, 0, 1, .. 5',
  `disadv1` 	TINYINT(1)	UNSIGNED 	  DEFAULT NULL	COMMENT 'Disadvantaged',
  `sex1` 	CHAR(1) 		 	  DEFAULT NULL	COMMENT 'Sex',
  `migsta1` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'Migrant status',
  `titlei1` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'Title I status',
  `campus_id2` 	INT(9) 		UNSIGNED ZEROFILL DEFAULT NULL	COMMENT '',
  `grade2` 	TINYINT(2) 	UNSIGNED 	  DEFAULT NULL	COMMENT '',
  `m_bin2` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'binned raw;    NULL, 0, 1, .. 9',
  `m_met2` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'met standards  NULL, 0, 1', 
  `m_com2` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'commended      NULL, 0, 1', 
  `m_scode2` 	CHAR(1) 		 	  DEFAULT NULL	COMMENT 'status code',
  `ethnic2` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'Ethnicity;     NULL, 0, 1, .. 5',
  `disadv2` 	TINYINT(1)	UNSIGNED 	  DEFAULT NULL	COMMENT 'Disadvantaged',
  `sex2` 	CHAR(1) 		 	  DEFAULT NULL	COMMENT 'Sex',
  `migsta2` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'Migrant status',
  `titlei2` 	TINYINT(1) 	UNSIGNED 	  DEFAULT NULL	COMMENT 'Title I status',
  PRIMARY KEY 		(`y1`,`id`),
  KEY `campus_id1` 	(`campus_id1`),
  KEY `grade1` 		(`grade1`),
  KEY `m_bin1` 		(`m_bin1`),
  KEY `campus_id2` 	(`campus_id2`),
  KEY `grade2` 		(`grade2`),
  KEY `m_bin2` 		(`m_bin2`),
  KEY `ethnic1` 	(`ethnic1`, `disadv1`, `sex1`)
)
ENGINE=MyISAM PACK_KEYS=1 CHARSET=ASCII  PARTITION BY LIST(y1) (
    PARTITION y2003 VALUES IN (2003),
    PARTITION y2004 VALUES IN (2004),
    PARTITION y2005 VALUES IN (2005),
    PARTITION y2006 VALUES IN (2006),
    PARTITION y2007 VALUES IN (2007)
)
;

-- ---------------------------------------------------------------------------
--
-- Copy values across
--

INSERT INTO `taks_rawk`.`student_trans` (
	`y1`,   	`id`,
	`campus_id1`,	`grade1`,
	`m_bin1`,	`m_met1`,	`m_com1`,	`m_scode1`,
	`ethnic1`,	`disadv1`,	`sex1`, 	`migsta1`,	`titlei1`,
	`campus_id2`,	`grade2`,
	`m_bin2`,	`m_met2`,	`m_com2`,	`m_scode2`,
	`ethnic2`,	`disadv2`,	`sex2`, 	`migsta2`,	`titlei2`
)
  SELECT
	sy1.year,	sy1.id,
	sy1.campus_id,	sy1.grade,
	sy1.m_bin,	sy1.m_met,	sy1.m_com,	sy1.m_scode,
	sy1.ethnic,	sy1.disadv,	sy1.sex, 	sy1.migsta,	sy1.titlei,
	sy2.campus_id,	sy2.grade,
	sy2.m_bin,	sy2.m_met,	sy2.m_com,	sy2.m_scode,
	sy2.ethnic,	sy2.disadv,	sy2.sex, 	sy2.migsta,	sy2.titlei
    FROM  	taks_rawk.students_years sy1
    LEFT JOIN	taks_rawk.students_years sy2 ON (sy1.id = sy2.id) AND (sy1.year = (sy2.year + 1))
;
