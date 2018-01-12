CREATE DATABASE /*!32312 IF NOT EXISTS*/`doc_db` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `doc_db`;

/*Table structure for table `doc_doctor` */

DROP TABLE IF EXISTS `doc_doctor`;

CREATE TABLE `doc_doctor` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `image` varchar(190) DEFAULT NULL,
  `SEX` int(11) DEFAULT '1',
  `EMAIL` varchar(50) DEFAULT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `CREATE_DATE` date DEFAULT NULL,
  `PART_CODE` varchar(100) DEFAULT NULL,
  `dept` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `DOC_PART_CODE` (`PART_CODE`),
  CONSTRAINT `DOC_PART_CODE` FOREIGN KEY (`PART_CODE`) REFERENCES `doc_part` (`PART_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `doc_doctor` */

insert  into `doc_doctor`(`ID`,`NAME`,`info`,`price`,`image`,`SEX`,`EMAIL`,`PHONE`,`ADDRESS`,`CREATE_DATE`,`PART_CODE`,`dept`) values (1,'罗佐杰','专长：糖尿病、甲状腺、肾上腺、性腺、生长发育异常等疾病。',5,'lzj.jpg',1,NULL,NULL,NULL,NULL,'00010001','主任医师'),(2,'秦映芬','专长：糖尿病、甲状腺、肾上腺、性腺、儿童生长发育异常等疾病。',5,'qyf.jpg',1,NULL,NULL,NULL,NULL,'00010001','主任医师'),(3,'蒙碧辉','专长：痛风，糖尿病，甲亢，高血压，肥胖，矮小症，性早熟等内分泌代谢性疾病。',5,'mbh.jpg',1,NULL,NULL,NULL,NULL,'00010001','主任医师'),(4,'赖永榕','专长：血液肿瘤的诊断治疗，研究方向为造血干细胞移植基础及临床研究、地中海贫血的诊断及治疗。',5,'lyr.jpg',1,NULL,NULL,NULL,NULL,'00010002','教授'),(5,'赵卫华','专长：血液肿瘤的诊断治疗，研究方向为血液肿瘤的甲基化研究。',5,'zwh.jpg',1,NULL,NULL,NULL,NULL,'00010002','副主任医师'),(6,'徐磊34','主任医生主任医生',123,'ad244d4c-8200-4b85-a229-f844ab0399b4.jpg',0,'dlei0009@163.com.cv','13360026135','广州',NULL,'00010001','主任医生'),(7,'张大夫','',12,'1d35a3d3-f270-413c-bf43-1bf034d58151.jpg',0,'dlei0009@163.com3333','13360026135','广州',NULL,'00010001','主任医生'),(9,'徐磊344','',123,'3d678f2e-266e-40f9-9379-3be6ec01ebd1.jpg',0,'dlei0009@163.com3333','13360026135','广州',NULL,'00010002','主任医生');

/*Table structure for table `doc_part` */

DROP TABLE IF EXISTS `doc_part`;

CREATE TABLE `doc_part` (
  `PART_CODE` varchar(100) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `REMARK` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`PART_CODE`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `doc_part` */

insert  into `doc_part`(`PART_CODE`,`NAME`,`REMARK`) values ('0001','内科','内科'),('00010001','----内分泌科','内分泌科'),('00010002','----血液内科','血液内科'),('00010003','----心血管内科','心血管内科'),('00010004','----神经内科','神经内科'),('00010005','----肾内科','肾内科'),('00010006','----老年病内科','老年病内科'),('00010007','----内分科','partCode'),('00010008','----内科新科室','内科新科室'),('0002','外科','外科'),('00020001','----骨关节科','骨关节科'),('00020002','----心胸外科','心胸外科'),('00020003','----肝胆外科','肝胆外科'),('00020004','----整形美容外科','整形美容外科'),('00020005','----泌尿外科','泌尿外科'),('00020006','----创伤骨科','创伤骨科'),('0003','妇儿','妇儿'),('00030001','----小儿外科','小儿外科'),('00030002','----妇科','妇科'),('00030003','----儿科','儿科'),('00030004','----产前诊断科与遗传病诊断','产前诊断科与遗传病诊断'),('000300040001','--------肿瘤一科','肿瘤一科'),('00030005','----产科','产科'),('00030006','----计划生育科','计划生育科'),('0004','其他','其他'),('00040001','----男性学科','男性学科'),('00040002','----耳鼻咽喉头颈外科','耳鼻咽喉头颈外科'),('00040003','----眼科','眼科'),('00040004','----中医科','中医科'),('00040005','----感染性疾病科','感染性疾病科'),('0005','肿瘤科','肿瘤科'),('00050001','----肿瘤一科','nextSonCode'),('000500010001','--------小科室','nextSonCode'),('0006','科科','partCode'),('00060001','----部门一','部门一'),('000600010001','--------部门一一','部门一一'),('000600010002','--------部门一二',''),('00060002','----部门二','测试');

/*Table structure for table `doc_register` */

DROP TABLE IF EXISTS `doc_register`;

CREATE TABLE `doc_register` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_ID` int(11) DEFAULT NULL,
  `doctor_Id` int(11) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `doc_user_ID` (`user_ID`),
  KEY `doc_register_doctor_Id` (`doctor_Id`),
  CONSTRAINT `doc_register_doctor_Id` FOREIGN KEY (`doctor_Id`) REFERENCES `doc_doctor` (`ID`),
  CONSTRAINT `doc_user_ID` FOREIGN KEY (`user_ID`) REFERENCES `doc_user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `doc_register` */

/*Table structure for table `doc_schedule` */

DROP TABLE IF EXISTS `doc_schedule`;

CREATE TABLE `doc_schedule` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_Id` int(11) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `doc_doctor_Id` (`doctor_Id`),
  CONSTRAINT `doc_doctor_Id` FOREIGN KEY (`doctor_Id`) REFERENCES `doc_doctor` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `doc_schedule` */

/*Table structure for table `doc_user` */

DROP TABLE IF EXISTS `doc_user`;

CREATE TABLE `doc_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(50) DEFAULT NULL,
  `PASS_WORD` varchar(50) DEFAULT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `SEX` int(11) DEFAULT '1',
  `EMAIL` varchar(50) DEFAULT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `ROLE` int(11) DEFAULT '1',
  `CREATE_DATE` date DEFAULT NULL,
  `ACTIVE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `LOGIN_NAME` (`LOGIN_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `doc_user` */

insert  into `doc_user`(`ID`,`LOGIN_NAME`,`PASS_WORD`,`NAME`,`SEX`,`EMAIL`,`PHONE`,`ADDRESS`,`ROLE`,`CREATE_DATE`,`ACTIVE`) values (1,'admin','123456','徐磊',1,'dlei0009@163.com','18665616529','广州天河区车陂',1,'2017-12-04','0');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
