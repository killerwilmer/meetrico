DROP TABLE IF EXISTS "item_categories_coworking_spaces";
CREATE TABLE "item_categories_coworking_spaces" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "coworking_space_id" integer DEFAULT 0, "green" integer, "yellow" integer, "red" integer, "created_at" datetime, "updated_at" datetime, "item_category_id" integer, "num_tables" integer DEFAULT 0, "available" INTEGER);
INSERT INTO "item_categories_coworking_spaces" VALUES(1,12,10,20,30,'2012-08-02 21:26:20.396146','2012-08-02 21:26:20.396146',5,1,777);
INSERT INTO "item_categories_coworking_spaces" VALUES(7,14,101,102,103,'2013-03-05 10:05:15.958165','2013-03-05 10:05:15.958165',6,100,123);
INSERT INTO "item_categories_coworking_spaces" VALUES(8,14,98,989,898,'2013-03-05 10:05:16.401392','2013-03-05 10:05:16.401392',7,98,1234);
