USE `QuizApp`;
LOCK TABLES `QUIZ` WRITE;
INSERT INTO `QUIZ` VALUES ('73001',
                                            'IT001',
                                            'BEGINER_1',
                                            '2023-01-01 00:00:00',
                                            '2023-01-15 00:00:12',
                                            '30',
                                            '1',
                                            '0');
INSERT INTO `QUIZ` VALUES ('73002',
                                            'IT001',
                                            'BEGINER_2',
                                            '2023-01-01 00:00:00',
                                            '2023-01-15 12:12:12',
                                            '30',
                                            '1',
                                            '0');
INSERT INTO `QUIZ` VALUES ('73003',
                                            'IT002',
                                            'BASIC_1',
                                            '2023-01-15 00:00:00',
                                            '2023-01-20 06:10:12',
                                            '30',
                                            '2',
                                            '0');
INSERT INTO `QUIZ` VALUES ('73004',
                                            'IT003',
                                            'ADV_1',
                                            '2023-01-16 00:00:00',
                                            '2023-01-20 05:30:00',
                                            '30',
                                            '1',
                                            '0');
INSERT INTO `QUIZ` VALUES ('73005',
                                            'IT004',
                                            'DB_1',
                                            '2023-01-24 00:00:00',
                                            '2023-02-01 08:00:00',
                                            '30',
                                            '2',
                                            '0');
INSERT INTO `QUIZ` VALUES ('73006',
                                            'IT004',
                                            'DB_2',
                                            '2023-01-24 00:00:00',
                                            '2023-02-01 09:00:00',
                                            '30',
                                            '1',
                                            '0');
INSERT INTO `QUIZ` VALUES ('73007',
                                            'IT005',
                                            'INTERN_1',
                                            '2023-02-05 00:00:00',
                                            '2023-02-12 10:00:00',
                                            '30',
                                            '2',
                                            '0');
INSERT INTO `QUIZ` VALUES ('73008',
                                            'IT006',
                                            'JUNIOR_1',
                                            '2023-02-13 00:00:00',
                                            '2023-05-06 11:00:00',
                                            '30',
                                            '2',
                                            '0');
UNLOCK TABLES;
