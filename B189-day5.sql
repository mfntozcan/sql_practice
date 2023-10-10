--------------DAY'4 NT-------------------
--23-ALIASES--(Etiket/Rumuz diyebiliriz. yani tablo ve ya sutunlara gecici olarak verdigimiz isimdir.)

CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM workers;

SELECT calisan_id FROM workers;

--Rumuz ekleme asagida ki olur.
--1nci yol
SELECT calisan_id AS id FROM workers;--Okunabilirlik acisindan bu tercih edilir.

--2nci yol
SELECT calisan_id id FROM workers;--Ama cogunlukla bu sekilde kullanilir.


--Concanation yapabilmek icin asagidaki gibi yazariz.

SELECT calisan_id ||' - ' || calisan_isim FROM workers;-- iki sutunu arasina - koyarak birlestiren kod.

SELECT calisan_id ||' - ' || calisan_isim  AS id_isim FROM workers;--Sutun ismini bu sekilde gecici bir isim verebiliriz.


SELECT * id FROM workers AS calisanlar;--tablonun ismini bu kod ile degistiririz.
										-- Genelde tablo ismi degisirken tablo isminin bas harfini kucuk olarak yazariz. (orn:w)

--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

SELECT * FROM calisanlar3;
SELECT * FROM markalar;

--SORU1--marka_id si 100 olan markada çalışanları listeleyiniz.
--1nci yol;

SELECT marka_isim FROM markalar WHERE marka_id=100;--once markanin ne oldugunu bulduk
SELECT * FROM calisanlar3 WHERE isyeri='Vakko';

--2nci yol-- Best Practice olan yazilim budur. Baska bir deyisle Dinamik olan kod yazimidir.
SELECT *
FROM calisanlar3
WHERE isyeri=(	SELECT marka_isim
			 	FROM markalar
			 	WHERE marka_id=100);


--INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 

SELECT * 
FROM calisanlar3
WHERE maas= (SELECT MAX (maas) FROM calisanlar3)


--Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.

SELECT MAX(maas)
FROM calisanlar3
WHERE maas<(SELECT MAX(maas) FROM calisanlar3)


--calisanlar3 tablosunda ikinci en yüksek maaşı alan çalışanı gösteriniz.
SELECT *
FROM calisanlar3
WHERE maas=(SELECT MAX(maas)
            FROM calisanlar3
            WHERE maas<(SELECT MAX(maas)
						FROM calisanlar3))







--calisanlar3 tablosunda max veya min maaşı alan çalışanların
-- tüm fieldlarını gösteriniz.

SELECT *
FROM calisanlar3
WHERE maas=(SELECT MAX (maas) FROM calisanlar3) OR maas=(SELECT MIN (maas) FROM calisanlar3)


-- SORU -- Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
--1nci yol
SELECT marka_id, calisan_sayisi
FROM markalar
WHERE marka_isim IN ('Pierre Cardin', 'Vakko', 'Adidas')

--2nci yol(dinamik cozum)
SELECT marka_id, calisan_sayisi
FROM markalar
WHERE marka_isim IN (SELECT isyeri FROM calisanlar3 WHERE sehir='Ankara')


--SORU - marka_id'si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.

SELECT isim,maas,sehir
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101)

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.

SELECT isim,maas,isyeri
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000)



--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

-- SORU-- Her markanin id'sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

SELECT marka_id, marka_isim, (SELECT COUNT (DISTINCT(sehir))
							 FROM calisanlar3
							 WHERE isyeri=marka_isim)
FROM markalar;	


--count ifadesine isim verme

SELECT marka_id, marka_isim, (SELECT COUNT (sehir)
							 FROM calisanlar3
							 WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;	-- correlated subquery	


SELECT DISTINCT (sehir) FROM calisanlar3;--sadece farkli olan sehirleri siralar


--VIEW OLUSTURMA 

CREATE VIEW marka_sehir_sayisi AS
SELECT marka_id, marka_isim, (SELECT COUNT(DISTINCT(sehir)) 
							  FROM calisanlar3 
							  WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar


-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim,calisan_sayisi, (SELECT MAX(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS max_maas
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve mimum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim,calisan_sayisi, (SELECT MAX(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS max_maas,
									(SELECT MIN(maas) FROM calisanlar3 WHERE isyeri=marka_isim)AS min_maas
FROM markalar;



--25-EXISTS Cond.

--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.


CREATE TABLE mart
(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;



--Mart ayinda 'Toyota' satilmis ise Nisan ayindaki tum urunlerin bilgilerini gonder.

SELECT *
FROM nisan 
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Toyota');



--Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız.

SELECT urun_id, musteri_isim 
FROM mart
WHERE EXISTS (SELECT urun_isim FROM nisan WHERE nisan.urun_isim=mart.urun_isim)





---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız


SELECT urun_isim,musteri_isim
FROM nisan n
WHERE EXISTS (SELECT urun_isim FROM mart m WHERE m.urun_isim=n.urun_isim)


--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_isim,musteri_isim
FROM mart m
WHERE NOT EXISTS (SELECT urun_isim FROM nisan n WHERE n.urun_isim=m.urun_isim)


















