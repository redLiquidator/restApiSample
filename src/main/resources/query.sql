use api;
show databases;
-- drop table orders;

CREATE TABLE menu (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  price INT NOT NULL,
  createdate TIMESTAMP DEFAULT NOW()
  );

 
 CREATE TABLE orders (
  tableno INT NOT NULL,
  orderdate TIMESTAMP DEFAULT NOW(),
  itemId INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  price INT NOT NULL,
  PRIMARY KEY (tableno, orderdate) 
  );
//what could be the best way to set primary key with this case? once u order, multiple fileds could be created because you could //order more than 2 food/beverages.  
//This means that single primary key doesn't work. 
  
select * from menu;
select * from orders;

insert into menu values (1,"Kalguksu",8000,now());
insert into menu values (2,"MeatballPasta",12000,now());
insert into menu values (3,"friedKimchiRice",9000,now());
insert into menu values (4,"KKanpunggi",20000,now());
insert into menu (name,price,orderdate) values ("BibimNoodle",8000,now()); 


ALTER TABLE quiz MODIFY question VARCHAR(100);

select id,name,price,orderDate from menu where id = 1;



   
   
SELECT LAST_INSERT_ID();   
/* find and insert next value */
create table NextIdDemo (id int auto_increment,
    primary key(id)
    );
select * from NextIdDemo;  
insert into NextIdDemo values(1);
insert into NextIdDemo values(2);

 SELECT AUTO_INCREMENT
 FROM information_schema.TABLES
 WHERE TABLE_SCHEMA = "business"
 AND TABLE_NAME = "NextIdDemo";
 
 	