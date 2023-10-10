------------DAY'5 NT-10.10.2023------------


--CREATE:INSERT 
--READ:SELECT
--UPDATE: (hangi tablo old. yaz) SET (sutunun adi)=yeni deger		==> seklinde kod yazilir.(Guncelleme islemi)
--DELETE:DELETE(tablolari silmek icinde DROP kullanilir.)


--26-UPDATE

--SET sutunadi=yeni deger
--WHERE kosul 			:kosulu saglayan satirlardaki datalari degistirir, gunceller.



--SORU==idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.

UPDATE calisanlar3
SET isyeri='Trendyol'
WHERE id=123456789;

SELECT * FROM calisanlar3;


--SORU==>
-- id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve
--sehirini 'Bursa' olarak güncelleyiniz.

UPDATE calisanlar3
SET isim='Veli Yildirim',sehir='Bursa'
WHERE id=567890123;

SELECT * FROM calisanlar3;


--SORU
--  markalar tablosundaki marka_id değeri 102 ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.

UPDATE markalar
SET marka_id=marka_id*2
WHERE marka_id>=102;

SELECT * FROM markalar;


-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.

UPDATE markalar 
SET calisan_sayisi=calisan_sayisi+marka_id

SELECT * FROM markalar;

--SORU
--calisanlar3 tablosundan Ali Seker'in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.

UPDATE calisanlar3
SET isyeri=(SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yildirim')
WHERE isim='Ali Seker';

SELECT * FROM calisanlar3;


--SORU
--calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

UPDATE calisanlar3
SET isyeri=(SELECT marka_isim FROM markalar WHERE calisan_sayisi>20000)
WHERE maas=1500;

SELECT * FROM calisanlar3;


--SORU
--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.

UPDATE calisanlar3
SET sehir=(sehir || ' subesi')
WHERE isyeri='Vakko'

SELECT * FROM calisanlar3;

--concanitaion yapmak icin alternatif yazim

UPDATE calisanlar3
SET sehir=CONCAT(sehir,' subesi')
WHERE isyeri='Vakko'

SELECT * FROM calisanlar3;




--27-IS NULL condition



CREATE TABLE people
(
ssn char(9),
name varchar(50),
address varchar(50)
);

INSERT INTO people VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO people VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO people (ssn, address) VALUES(456789012, 'Bursa');
INSERT INTO people (ssn, address) VALUES(567890123, 'Denizli');
INSERT INTO people (ssn, name) VALUES(567890123, 'Veli Han');

SELECT * FROM people;



--SORU
--people tablosundaki name sütununda NULL olan değerleri listleyiniz.

SELECT *
FROM people 
WHERE name IS NULL 



--SORU
--people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.

SELECT *
FROM people 
WHERE address IS NOT NULL 



--SORU
--people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE people
SET name='MISSING...'
WHERE name IS NULL 

SELECT * FROM people 



--SORU
--people tablosunda address sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE people
SET address='MISSING...'
WHERE address IS NULL 

SELECT * FROM people 






--28-ORDER BY(tablolardaki kayitlari belirli bir veya daha fazla sutuna gore defaultta varsayilan olarak
--NATURAL (artan, ASCENDING) sirali olarak siralamamizi saglar.)


CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir');
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa');
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara');

SELECT * FROM person;



--SORU
--person tablosundaki tum kayitlari adrese gore (artan) siralayarak listeleyiniz.

SELECT *
FROM person
ORDER BY adres;--default:ASC:artan

SELECT *
FROM person 
ORDER BY adres ASC;-- bu sekilde yazarsak okunabilirligi daha iyi olur. 
					--iki kodda bize ayni sonucu veriri.
					
					

--SORU
--person tablosundaki tum kayitlari soyisme gore (azalan) siralayarak listeleyiniz.

SELECT *
FROM person
ORDER BY soyisim DESC; DESCENDING:azalan


--SORU
--person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.

--1nci yol
SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC; 

--2nci yol
SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY 2 DESC; --not recommended--sutunun ismini yazmak yerine index yazmak tavsiye edilmez.



--SORU
--person tablosundaki tum kayitlari is8imler NATURAL sirali, Soyisimler ters sirali olarak listeleyiniz.

SELECT * 
FROM person
ORDER BY isim ASC, soyisim DESC--azalan


--SORU
--isim ve soyisim degerlerini, soyisim kelime uzunluklarina gore siralayarak listeleyiniz.

SELECT isim,soyisim
FROM person
ORDER BY LENGTH(soyisim)



--SORU
--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT isim || ' '|| soyisim ad_soyad
FROM person
ORDER BY LENGTH(isim)+LENGTH (soyisim)

SELECT isim || ' '|| soyisim ad_soyad, LENGTH (isim||soyisim) karekter_sayisi
FROM person
ORDER BY LENGTH (isim||soyisim)


--calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz.

SELECT isim,sehir,maas
FROM calisanlar3
WHERE maas>(SELECT AVG(maas)FROM calisanlar3)
ORDER BY maas ASC;



					


