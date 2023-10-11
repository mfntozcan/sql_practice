--------------DAY'6---------------------
--29-GROUP BY clause:

CREATE TABLE manav
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);


SELECT * FROM manav;


--SORU
--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.\

SELECT isim,SUM(urun_miktar)
FROM manav
GROUP BY isim;


--SORU
--Manav tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını,
-- toplam urun miktarini AZALAN olarak görüntüleyiniz.

SELECT isim,SUM(urun_miktar) toplam_kg
FROM manav
GROUP BY isim
ORDER BY SUM(urun_miktar) DESC;


--SORU
--Her bir ismin aldigi her bir urunun toplam miktarini isme gore sirali goruntuleyiniz.

SELECT isim,urun_adi,SUM (urun_miktar)
FROM manav
GROUP BY isim,urun_adi
ORDER BY isim

--NOT==>group by ile gruplama yapildiginda SELECT ten sonra sadece gruplanan sutun adi veya 
--herhangi bir sutunun AGGREGATE fonksiyoru ile kullanimi mumkundur.

SELECT isim,urun_adi,SUM (urun_miktar)
FROM manav
GROUP BY isim-- hata verir

--NOT ; GROUP BY dan sonraki sutun sirasi onemli, ilk sutundan baslayarak gruplar AGGREGATE fonksiyorn 
--kullanildiginda en son ya da en icteki gurba gore hesaplanir.



--SORU
--urun ismine gore her bir urunu alan toplam kisi sayisini gosteriniz.

SELECT urun_adi, COUNT(DISTINCT isim) AS kisi_sayisi
FROM manav
GROUP BY urun_adi 



--SORU
--Isme gore alinan toplam urun miktarini ve urun cesit miktarini bulunuz.

SELECT isim, SUM(urun_miktar) AS toplam_kg, COUNT(DISTINCT urun_adi) AS urun_cesidi
FROM manav
GROUP BY isim

--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.

SELECT urun_miktar, COUNT(DISTINCT isim) AS musteri_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY musteri_sayisi




--30-HAVING clause:==> GROUP BY komutundan sonra filtrelemek icin AGGREGATE fonsiyounu ile birlikte kullanilir.



DROP TABLE personel;--daha once var olan personel tablomuzu silmek icin bu kodu yazdik. yenibir personel isimli tablo olusturacagiz.

CREATE TABLE personel  (
id int,
isim varchar(50),
sehir varchar(50), 
maas int,  
sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel;


--SORU
--Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.

SELECT sirket, MIN(maas) AS min_maas
FROM personel 
GROUP BY sirket
HAVING MIN(maas)>4000


--SORU
--Maaşı 4000 den fazla olan çalışanlardan, her bir şirketin MIN maas bilgisini görüntüleyiniz.

SELECT sirket, MIN(maas) AS min_maas
FROM personel
WHERE maas>4000
GROUP BY sirket

--NOT; gruplama yaptiktan sonra sonucleri filtrelemek icin HAVING aggregate fonk ile
--gruplamadan once mevcut kayitlari filtrelemek icin ise WHERE kullanilir.


--SORU
----Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.

SELECT isim, SUM(maas) AS toplam_gelir
FROM personel
GROUP BY isim
HAVING SUM(maas)>10000



--SORU
--Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız

SELECT sehir, COUNT(DISTINCT id ) AS personel_sayisi
FROM personel
GROUP BY sehir
HAVING COUNT(DISTINCT id)>1


--SOUR
--Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.


















--31-UNION:: ==> iki farkli sorgu sonucunu birlestirerek goruntulemeyi saglar
--				tekrar eden veriler var ise; tekrarli olanlari bir kere gosterir.
-- UNION ALL;; Union ile ayni islevi gorur, tekrarli olan kayitlar var ise bunlari da gosterir.



CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Han','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Ran','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Pak','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Tek','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Çetin','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','ummu@mail.com',4000,'C#','Bursa',29);

SELECT * FROM developers;



CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');


SELECT * FROM contact_info;


--SORU
--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini
--birlikte tekrarsız gösteren sorguyu yaziniz

--tekrarli olanlari bize gostermedi
SELECT name FROM developers WHERE age>25
UNION
SELECT prog_lang FROM developers WHERE age<30

----tekrarli olanlari gosterir
SELECT name FROM developers WHERE age>25
UNION ALL
SELECT prog_lang FROM developers WHERE age<30


--NOT; UNION/UNION ALL ile sonuclarini birlestirdigimiz sorgular ayni sayida sutunu gostermeli ve 
--bu alt alta gelecek olan bu sutunlar ayni data tipini icermeli.



--SORU
--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz

SELECT salary AS maas_yas,prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age AS maas_yas, prog_lang FROM developers WHERE prog_lang='JavaScript'


--SORU
--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.

SELECT city, salary FROM developers WHERE id=8
UNION
SELECT city, number FROM contact_info WHERE address_id=8


--SORU
--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz

SELECT city FROM developers
UNION
SELECT sehir FROM calisanlar3





--32-- INTERSECT ;; iki farkli sorgunun sonuclarindan ortak olanlari gosterir.


--SORU
--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--aynı olanlarını tekrarsız olarak listeleyiniz

SELECT city FROM developers
INTERSECT
SELECT sehir FROM calisanlar3


--SORU
--developers tablosunda Java kullananların çalıştıkları şehirler ve
--calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.

SELECT city FROM developers WHERE maas>'Java'
INTERSECT
SELECT sehir FROM calisanlar3 WHERE maas>1000


--EXCEPT ;; bir sorgunun sonuclarindan diger sorgunun sonuclari haric olarak gosterir.




--SORU
--developers tablosundaki sehirler ile calisanlar3 tablosunda sehirler haric olarak listeleyin

SELECT city FROM developers
EXCEPT
SELECT sehir FROM calisanlar3 


--SORU
-- calisanlar 3 tablosundaki sehirler ile developers tablosunda sehirler haric olarak listeleyin

SELECT sehir FROM calisanlar3 
EXCEPT
SELECT city FROM developers



--SORU
----developers tablosundaki maaşı 4000 den büyük olanların idlerinden
--contact_info tablosunda olmayanları listeleyiniz.

SELECT id FROM developers WHERE salary>4000
EXCEPT 
SELECT address_id FROM contact_info


--ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz.  
 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 

