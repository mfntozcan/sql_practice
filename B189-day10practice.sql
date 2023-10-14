/******************DAY 10 SQL practice***********************
******************* ON-DELETE-CASCADE  **********************
*************************************************************
CHILD TABLODA ON DELETE CASCADE KOMUTU YAZILMAZSA
1-) Child tablo silinmeden Parent tablo silinmeye calisildiginda 
        PgAdmin Eror verir. Yani Child tablo silinmeden Parent 
        tablo silinemez
		
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye 
        calisildiginda Pg Admin Eror verir. yani Child tablodaki 
        veri silinmeden Parent tablodaki veri silinemez
		
CHILD TABLODA ON DELETE CASCADE KOMUTU YAZILIRSA
1-) Child tablo silinmeden Parent tablo silinebilir.
    PgAdmin Eror vermez
	
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye 
        calisildiginda PgAdmin Eror vermez  Parent tablodaki veriyi 
        siler.Fakat bu durumda Child tablodaki veride silinir.
*/


CREATE TABLE parent2
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO parent2 VALUES (101, 'Sony', 'Kim Lee');
INSERT INTO parent2 VALUES (102, 'Asus', 'George Clooney');
INSERT INTO parent2 VALUES (103, 'Monster', 'Johnny Deep');
INSERT INTO parent2 VALUES (104, 'Apple', 'Mick Jackson') ;

SELECT * FROM parent2

CREATE TABLE child2
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk FOREIGN KEY (ted_vergino) REFERENCES parent2(vergi_no)
ON DELETE CASCADE   
);

INSERT INTO child2 VALUES(101, 1001,'PC', 'Habip Sanli');
INSERT INTO child2 VALUES(102, 1002,'Kamera', 'Zehra 0z');
INSERT INTO child2 VALUES(102, 1003,'Saat', 'Mesut Kaya');
INSERT INTO child2 VALUES(102, 1004,'PC', 'Vehbi Koc');
INSERT INTO child2 VALUES(103, 1005,'Kamera', 'Cemal Sala');
INSERT INTO child2 VALUES(104, 1006,'Saat', 'Behlil Dana');
INSERT INTO child2 VALUES(104, 1007,'Kamera', 'Eymen Ozden');

SELECT * FROM child2;


-- SORU-1 : parent2 tablosundaki tum verileri siliniz

DELETE FROM parent2;
SELECT * FROM parent2;
SELECT * FROM child2;


-- SORU-2 : Parent2 tablosunu silinz

DROP TABLE parent2;
DROP TABLE parent2 CASCADE;


--SORU-3: child2 tablosunu siliniz

DROP TABLE child2;







CREATE TABLE toptancilar
(
vergi_no int PRIMARY KEY,
sirket_ismi VARCHAR(40),
irtibat_ismi VARCHAR(30)
);

INSERT INTO toptancilar VALUES (201, 'IBM', 'Kadir Şen'); 
INSERT INTO toptancilar VALUES (202, 'Huawei', 'Çetin Hoş');
INSERT INTO toptancilar VALUES (203,'Erikson', 'Mehmet Gör'); 
INSERT INTO toptancilar VALUES (204, 'Apple', 'Adem Coş');


CREATE TABLE malzemeler  --> child
(
ted_vergino int,
malzeme_id int,
malzeme_isim VARCHAR(20),
musteri_isim VARCHAR(25),
CONSTRAINT FK FOREIGN KEY (ted_vergino) REFERENCES toptancilar (vergi_no) on delete cascade
);


INSERT INTO malzemeler VALUES (201, 1001, 'Laptop', 'Asli Can'); 
INSERT INTO malzemeler VALUES (202, 1002, 'Telefon', 'Fatih Ak'); 
INSERT INTO malzemeler VALUES (202, 1003, 'TV', 'Ramiz Özmen');
INSERT INTO malzemeler VALUES (202, 1004, 'Laptop', 'Veli Tan');


--SORU-4: Malzemeler tablosundaki musteri_isim'i Asli Can olan kaydin malzeme_isim'ini,
--toptancılar tablosunda irtibat_ismi 'Adem Coş' olan kaydin sirket_ismi ile güncelleyiniz.







