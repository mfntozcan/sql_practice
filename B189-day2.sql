--------------------DAY'2 NT--------------------
------------------tekrar-----------------------
CREATE TABLE sairler(
id int,
name varchar(50),
email varchar(50)	
);

INSERT INTO sairler VALUES(1001,'Can Yücel','sair@mail.com');
INSERT INTO sairler VALUES(1001,'Necip Fazıl','sair@mail.com');
INSERT INTO sairler VALUES(1002,'','sair@mail.com');

INSERT INTO sairler(name) VALUES('Nazım Hikmet');

SELECT * FROM sairler;


--9-tabloya UNIQUE constrainti ekleme

CREATE TABLE it_persons(
id SERIAL,
name VARCHAR(50),
email VARCHAR(50) UNIQUE,
salary REAL,
prog_lang VARCHAR(20)	
);

INSERT INTO it_persons(name,email,salary,prog_lang) 
VALUES('Sezer Bey', 'dev@mailcom',5000, 'JAVA');

INSERT INTO it_persons(name,email,salary,prog_lang) 
VALUES('Mahmut Bey', 'qa@mailcom',5000, 'JAVA');

SELECT * FROM it_persons;


--10-tabloya NOT NULL constrainti ekleme

CREATE TABLE doctors(
id SERIAL,
name VARCHAR (50) NOT NULL,
emeil VARCHAR(50) UNIQUE,
salary REAL
);

INSERT INTO doctors(name,emeil,salary) 
VALUES('Fatma Hoca', 'dr@mail.com',7000)

INSERT INTO doctors(emeil,salary) 
VALUES( 'dir@mail.com',7000)

INSERT INTO doctors(name,emeil,salary) 
VALUES('turkan Hoca', 'dmr@mail.com',7000)

INSERT INTO doctors(name,emeil,salary) 
VALUES('', 'dhmr@mail.com',7000)

SELECT * FROM doctors;


--11- tabloya PK constrainti ekleme

--1nci yontem

CREATE TABLE students2(
	id int PRIMARY KEY,--UNIQUE, NOT NULL, baska bir tablo ile iliskilendirmek icin kullanilacak.
	name varchar (50),
	grage real,
	register_date date
);

SELECT * FROM students2;

--2nci yontem

CREATE TABLE students3(
	id int ,--UNIQUE, NOT NULL, baska bir tablo ile iliskilendirmek icin kullanilacak.
	name varchar (50),
	grage real,
	register_date date,
	CONSTRAINT std_pk PRIMARY KEY(id)
);

SELECT * FROM students3;


--composite key

CREATE TABLE students4(
	id int ,
	name varchar (50),
	grage real,
	register_date date,
	CONSTRAINT composite_pk PRIMARY KEY(id,name)
);

SELECT * FROM students4;

--12- tabloya FK constrainti ekleme

CREATE TABLE address3 (
	address_id int,
	street varchar (50),
	city varchar (20),
	student_id int,--FK olsun
CONSTRAINT add_fk FOREIGN KEY(student_id) REFERENCES students3 (id)	
);

SELECT * FROM address3;

--13- tabloya CHECK constrainti ekleme
--bir sutndaki deger tablosunu kisitlamak icin kullanilir.

CREATE TABLE personel1 (
	id int,
	name varchar (50),
	salary real CHECK(salary>5000),-- negatif deger olmamali, Bunun icin real den sonraki kisim yazilir.
	age int CHECK (age>0) -- negatif deger olmamali, Bunun icin int den sonraki kisim yazilir.
);

INSERT INTO personel1 VALUES(11,'Ali Can',2000,25);--"personel_salary_check"
INSERT INTO personel1 VALUES(11,'Ali Can',7000,55);
INSERT INTO personel1 VALUES(11,'Ali Can',7000,25);

SELECT * FROM personel1;

--odev

/*1-sqlpractice_db isminde database oluşturunuz.
2-sqlpractice_db database içinde musteri isminde tablo oluşturunuz.
      musteri_no(integer)
      isim (string,50 karakter)
      yas (int)
      cinsiyet (string 1:K/E)
      gelir(real)
      meslek(string,20 karakter)
      sehir (string,20 karakter)
constraintler:
musteri_no:primary key, otomatik olarak artırılsın
isim:not null ve not empty,yas:18 den büyük
3-musteri tablosuna kayıt ekleyiniz.
isim:ALİ, yas:35,cinsiyet:E,gelir:2500,meslek:MÜHENDİS,sehir:İSTANBUL
3-aşağıdaki kayıtları musteri tablosuna ekleyiniz.
('BURAK',   25, 'E', 3500, 'MİMAR',       'İZMİR');
('CEYHUN',  45, 'E', 2000, 'MÜHENDİS',    'ANKARA');
('DEMET',   30, 'K', 3000, 'ÖĞRETMEN',    'ANKARA');
('FERHAT',  40, 'E', 2500, 'MİMAR',       'İZMİR');
('GALİP',   55, 'E', 4000, 'ÖĞRETMEN',    'İSTANBUL');
('KÖKSAL',  25, 'E', 2000, 'AVUKAT',      'İZMİR');
('LEYLA',   60, 'K', 2500, 'MİMAR',       'İSTANBUL');
('MELEK',   30, 'K', 2500, 'ÖĞRETMEN',    'İSTANBUL');
('JALE',    40, 'K', 6000, 'İŞLETMECİ',   'ANKARA');
('TEKİN',   45, 'E', 2000, 'AVUKAT',      'ANKARA');
('SAMET',   20, 'E', 3000, 'MİMAR',       'İSTANBUL');
('ŞULE',    20, 'K', 4500, 'ÖĞRETMEN',    'İSTANBUL');
('VELİ',    40, 'E', 2500, 'ÖĞRETMEN',    'İZMİR');
('ZEYNEP',  50, 'K', 3500, 'TESİSATÇI',   'İZMİR');
('ARDA',    55, 'E', 2000, 'KUAFÖR',      'İZMİR');
('MELİS',   30, 'K', 3000, 'KUAFÖR',      'ANKARA');
musteri tablosunda;
4-Tüm kayıtları listeleyiniz.
5-Tüm kayıtlardan isim ve meslek bilgilerini görüntüleyiniz
6-sqlpractice_db databaseinde ;
“sehirler” isimli bir Table olusturun. 
Tabloda “alan_kodu”, “isim”, “nufus”  field’lari olsun.
Isim field’i null değer alamasın.
“alan_kodu” field’ini “Primary Key” yapin.
7-sqlpractice_db databaseinde;
a- “tedarikciler3” isimli bir tablo olusturun.
Tabloda “tedarikci_id”, “tedarikci_ismi”,  “iletisim_isim” field’lari olsun
“iletisim_isim”  fieldı tekrarsız olsun.
“tedarikci_id” yi Primary Key yapin.
b- “urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun
“tedarikci_id” yi Foreign Key yapin.
*/





