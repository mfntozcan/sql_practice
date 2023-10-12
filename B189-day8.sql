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
INNER JOIN personeller AS m
ON p.yonetici_id=m.id



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

SELECT * FROM developers WHERE name='Enes Can';-- bildigimiz bir kaydi gostermek icin bu kodu yazariz.

--wildcard(tr.de joker anlami tasir. Sembolu;% dir.)-->0 veya daha fazla karater anlamina gelir.


--SORU
--developers tablosunda ismi E ile baslayanlari listeleyelim.

SELECT *
FROM developers
WHERE name LIKE 'E%'
--birebir degeri hatirlayamadigimizda mesela Enes i hatirliyor ama soyadini bilmedigimizde LIKE komutunu kullaniriz.
--birebir degeri hatirlayamadigimizda mesela Enes i hatirliyor ama soyadini bilmedigimizde LIKE komutunu kullaniriz.

--SORU
--developers tablosunda ismi E ile baslayanlari listeleyelim.(burada bas harfinin buyuk/kucuk hangi harfle basladigini bilmedigimiz durumda)

SELECT *
FROM developers
WHERE name ILIKE 'e%'


--SORU
--a harfi ile biten sehirde calisan dev isimlerini be sehirlerini yazdiran QUERY yazin

SELECT name,city
FROM developers
WHERE city ILIKE '%a'


--SORU
--Ismi T ile başlayıp n harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary
FROM developers
WHERE name ILIKE 't%n'



--SORU
--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin

SELECT name,salary
FROM developers
WHERE name ILIKE '%an%'


--SORU
--Ismi içinde e ve a harfi olan dev isimlerini yazdiran QUERY yazin
--1nci yol
SELECT *
FROM developers
WHERE name ILIKE '%e%a%' OR name ILIKE '%a%e%'

--2nci yol
SELECT *
FROM developers
WHERE name ILIKE '%e%' AND name ILIKE '%a%'



--underscore(_); bilinmeyen bir tane karekteri temsil eder.


--SORU
--Isminin ikinci harfi u olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM developers
WHERE name ILIKE '_u%'


--SORU
--Kullandigi prog dili 4 harfli ve ucuncu harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM developers
WHERE prog_lang ILIKE '__v_'



--Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.ÖDEVVV
--HINT:sadece JavaScript olacak
--Isminin 2. harfi e,4. harfi i olan devlerin tum bilgilerini yazdiran QUERY yazin. ÖDEVV
--ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV



--37--REGEXP_LIKE(~); belirli bir karakter deseninin iceren datalari regex 
--kullanarak filtrelememizi saglar.

--


--words tablosu uzerinden calisalim


--SORU
--h harfinden sonra a veya i harfini sonra ise t harfini
--iceren kelimerin tum bilgilerin iyazdiran QUERY kodunu yaziniz

--bu soruda ==>[] sembolu kullanilir. Bu sembolun icerisindeki harflerden en az birini temsil eder.
--bu kod kucuk buyuk harfe karsi duyarlidir
SELECT *
FROM words
WHERE word ~'h[ai]t'


--bu kod ise kucuk buyuk harfe karsi duyarli degildir
SELECT *
FROM words
WHERE word ~*'h[ai]t'



--SORU
--h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin tum bilgilerini  yazdiran QUERY yaziniz.

SELECT *
FROM words
WHERE word ~* 'h[a-k]t'



--SORU
-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '[mi]' 


--SORU
--  a ile baslayan kelimelerin tum  bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^a' 



--SORU
--  a veya s ile baslayan kelimelerin tum  bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^[as]' 


--SORU
--  m ile biten kelimelerin tum  bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* 'm$' 



--SORU
--  m ile baslayip f ile biten kelimelerin tum  bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^y(.*)f$' -- (.*) ifadesi y ve f arasinda birden fazla karakter yada hic karakter bulunup bulunmadigini ifade eder.


--SORU
--y ile başlayıp f ile biten 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words
WHERE word ~* '^y.f$'





--SORU
-- ilk harfi h veya H olmayan kelimelerin  tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words 
WHERE word NOT ILIKE 'h%'




--SORU
-- ilk harfi h veya H olmayan kelimelerin  tum bilgilerini yazdiran QUERY yazin

SELECT *
FROM words 
WHERE word !~* '^h'



--2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.ÖDEV





