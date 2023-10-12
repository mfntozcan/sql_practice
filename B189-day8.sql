--------------DAY'7---------------------

--JOINS--BİRLEŞTİRME
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.


CREATE TABLE sirketler(
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');



CREATE TABLE siparis(
siparis_id int,
sirket_id int,
siparis_tarihi date
);

INSERT INTO siparis VALUES(11, 101, ' 2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');



--33-INNER JOIN:baz aldığımız sütundaki sadece ortak değerleri gösterir.


--SORU
--iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.

SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler
INNER JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id

--veya 

SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM siparis
INNER JOIN sirketlet
ON sirketler.sirket_id=siparis.sirket_id
--seklinde yazsak da; iki tablolardaki ortak kayitlar birlestigi icin tablo sirasi farketmez.




--34-LEFT JOIN:Sol tablodaki(ilk tablodaki) tüm verileri getirir.
   --RIGHT JOIN:Sağ tablodaki(ikinci tablodaki) tüm verileri getirir.



--SORU
--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.
   
SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler LEFT JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id  


--SORU
--sadece siparis tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.
   
SELECT sirketler.sirket_id,sirket_isim,siparis_id,siparis_tarihi
FROM sirketler RIGHT JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id 

--LEFT/RIGHT JOIN tablo sirasi degistirilerek birbirinin yerine kullanilabilir.
   
   
   
--35-FULL JOIN:iki tablodaki baz alınan sütundaki tüm kayıtları getirir.


--SORU
--her iki tablodaki tum kayitlarin tum bilgilerini listeleyiniz.
   
SELECT sirketler.sirket_id AS sirketler_id,sirket_isim,
		siparis.sirket_id AS siparis_sirket_id,siparis_id,siparis_tarihi
FROM siparis FULL JOIN sirketler
ON sirketler.sirket_id=siparis.sirket_id 




--36-SELF JOIN : tablonun kendi içindeki bir sütunu baz alarak INNER JOIN yapılmasını sağlar. 



CREATE TABLE personeller  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);


INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    null);

SELECT * FROM personeller;



--SORU
--Herbir personelin ismi ile birlikte yoneticisinin ismini de veren bir sorgu olusturunuz.

SELECT p.isim AS personel, m.isim AS yonetici
FROM personeller AS p
INNER JOIN yonetici AS m
ON pyonetici_id=m.id




--37-LIKE Cond.:WHERE komutu ile kullanılır, 
--Sorgular belirli bir karakter dizisini(desen-pattern) kullanarak filtreleme yapmamızı sağlar
--ILIKE:LIKE gibi ancak CASE INSENSITIVE dir.


CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);

SELECT * FROM words;