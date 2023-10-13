--------------DAY'8-----------------

SELECT * FROM developers;

SELECT *
FROM developers
WHERE name LIKE 'A%n'


--39-String Fonksiyonlar

SELECT name,LENGTH(name)
FROM developers

--Ayşenur Han değerinde en sonda boşluk var:(

--developers tablosunda name değerlerindeki 
--başlangıç ve sondaki boşlukları kaldırınız.

UPDATE developers
SET name=TRIM(name)


--developers tablosunda name değerlerinde 'Ayşenur' kelimesini 'Ayşe' ile değiştiririnz.

UPDATE developers
SET name=REPLACE(name,'Aysenur','Ayse')


--developers tablosundaki tüm kayıtların 
--name değerlerini büyük harfe 
-- prog_lang değerlerinin küçük harfe çevirerek görüntüleyiniz.

SELECT UPPER(name), LOWER(prog_lang)
FROM developers


SELECT * FROM calisanlar3;



--calisanlar3 tablosunda isyeri='Vakko' olan kayıtlarda 
--2nci 'Şubesi' ifadesini siliniz.


UPDATE calisanlar3
SET sehir=SUBSTRING (sehir,1,LENGTH(sehir)-7)
WHERE isyeri='Vakko'


--words tablosunda tüm kelimeleri(word) ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.

SELECT INITCAP(word) FROM words;

--words tablosunda tüm kelimeleri ve tum kelimelerin (word) ilk 2 harfini görüntüleyiniz.

SELECT word, SUBSTRING(word,1,2) FROM words;


--words tablosunda tüm kelimeleri ve tum kelimelerin  2nci indeksten itibaren kalanini görüntüleyiniz.

SELECT word, SUBSTRING(word,2) FROM words;


--40--FETCH NEXT n ROW ONLY------------sadece siradaki ilk n satiri getirir
--						LIMIT n: sadece siradaki ilk n satiri getirir.
--						OFFSET n: n satiri atlayip sonrakini getirir.



--SORU--
--Developers tablosundan ekleme sirasina gore ilk 3 kaydi getiriniz
--1NCI YOL
SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY;

--2NCI YOL
SELECT * 
FROM developers
LIMIT 3;


--SORU
--developers tablosundan ekleme sırasına göre ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.

SELECT * 
FROM developers
OFFSET 2 ROW 
FETCH NEXT 3 ROW ONLY;

SELECT * 
FROM developers
OFFSET 2 ROW 
LIMIT 3;



--SORU
--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.

SELECT *
FROM developers
ORDER BY salary ASC
LIMIT 3;


--SORU
--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.

SELECT *
FROM developers
ORDER BY salary DESC
OFFSET 1
LIMIT 1


--41-ALTER TABLE;; tabloyu guncellemek icin kullanilir. (DDL)


/*
add column ==> yeni sutun ekler
drop column ==> mevcut olan sutunu siler
rename column.. to.. ==> sutunun ismini degistirir      
rename.. to.. ==> tablonun ismini degistirir*/


--SORU
--calisanlar3 tablosuna yas (int) seklinde yeni sutun ekleyiniz.

ALTER TABLE calisanlar3
ADD COLUMN yas int



--SORU
--calisanlar3 tablosuna remote (boolean) seklinde yeni sutun ekleyiniz.
--varsayılan olarak remote değeri TRUE olsun


ALTER TABLE calisanlar3
ADD COLUMN remote BOOLEAN DEFAULT TRUE




--calisanlar3 tablosunda yas sutununu siliniz.

ALTER TABLE calisanlar3
DROP COLUMN yas


--calisanlar3 tablosundaki maas sutununun data tipini real olarak güncelleyiniz.

ALTER TABLE calisanlar3
ALTER COLUMN maas TYPE REAL


--calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.

ALTER TABLE calisanlar3
RENAME COLUMN maas TO gelir


--calisanlar3 tablosunun ismini employees olarak güncelleyiniz.

ALTER TABLE calisanlar3
RENAME TO employees


--employees tablosunda id sütunun data tipini varchar olarak güncelleyiniz.

ALTER TABLE employees
ALTER COLUMN id TYPE VARCHAR(20)


--employees tablosunda id sütunun data tipini int olarak güncelleyiniz.
ALTER TABLE employees
ALTER COLUMN id TYPE INT USING id::INT


--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.

ALTER TABLE employees
ALTER COLUMN isim SET NOT NULL

SELECT * FROM employees


--NOT:içinde kayıtlar bulunan bir tabloyu güncellerken bir sütuna 
--NOT NULL,PK,FK,UNIQUE vs constraintleri ekleyebilmek için önce
--bu sütunların değerleri ilgili const.  sağlıyor olmalı.


--sirketler tablosunda sirket_id sutununa PRIMARY KEY constrainti ekleyiniz.


ALTER TABLE sirketler
ADD PRIMARY KEY(sirket_id)



--sirketler tablosunda sirket_isim sutununa UNIQUE constrainti ekleyiniz

ALTER TABLE sirketler
ADD UNIQUE (sirket_isim)


--siparis tablosunda sirket_id sutununa FK constrainti ekleyiniz

ALTER TABLE siparis
ADD FOREIGN KEY(sirket_id) REFERENCES sirketler(sirket_id)

DELETE FROM siparis WHERE sirket_id IN(104,105)


--siparis tablosunda  FK constrainti kaldiriniz

ALTER TABLE siparis
DROP CONSTRAINT siparis_sirket_id_fkey


--employees tablosunda isim sutununda NOT NULL constraintini kaldiriniz.

ALTER TABLE employees
ALTER COLUMN isim DROP NOT NULL



--42-TRANSACTION; database de en kucuk islem birimi.
--		BEGIN; bir transactioni baslatir
--		COMMIT ; bir transactionu onaylar ve sonlandirir.
--		SAVEPOINT; kayit noktasi olusturur
--		ROLLBACK; yapilan degisiklikleri iptal ederek en son kalici hale getirilen konuma geri doner ve transactionu sonlandirir.


CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);


SELECT * FROM hesaplar;


UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--sistemde hata oluştu
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
--veriler tutarsız

SELECT * FROM hesaplar;

-------------------------------------------------

BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;

BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',10000.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',5000.5);

SAVEPOINT x;

SELECT * FROM hesaplar;

--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;

--sistemde hata oluştu, catch bloğundan devam

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--bu işlem başarısız
--veriler tutarsız

COMMIT;
--}catch(hata){
ROLLBACK TO x;
--}

-----------------------------------pozitif senaryo
--try{
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı

UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı

COMMIT;

--}catch(hata){
ROLLBACK TO x;
--}

SELECT * FROM hesaplar;













