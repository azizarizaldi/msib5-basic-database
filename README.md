# msib5-basic-database
Repo ini digunakan untuk latihan basic database (Penggunaan Trigger, View, Function &amp; Stored Procedure)

## Pengenalan
Pada repo ini terdapat satu file sql [(example_database.sql)](example_database.sql) yang berisikan:
- tabel rents
- tabel rooms
- tabel users

Selain itu, terdapat trigger, view, function &amp; Stored Procedure yang telah saya buat.
Untuk contoh pembuatannya, akan saya berikan contoh dibawah ini:

### Pembuatan Trigger
Silahkan buat database terlebih dahulu atau import file database yang ada di repo ini [(example_library.sql)](example_library.sql), lalu copy/paste query dibawah ini untuk membuat trigger:

**Query dibawah ini bertujuan untuk membuat trigger penambahan data**
```bash
DELIMITER &&

CREATE TRIGGER update_rooms_rented_count
AFTER INSERT ON rents
FOR EACH ROW
BEGIN
    UPDATE rooms
    SET rented_count = rented_count + 1
    WHERE id = NEW.room_id;
END;

&&

DELIMITER ;
```

**Query dibawah ini bertujuan untuk membuat trigger pengurangan data**
```bash
DELIMITER &&

CREATE TRIGGER decrease_rooms_rented_count
AFTER DELETE ON rents
FOR EACH ROW
BEGIN
    UPDATE rooms
    SET rented_count = rented_count - 1
    WHERE id = OLD.room_id;
END;

&&

DELIMITER ;
```

### Pembuatan View
**Query dibawah ini bertujuan untuk membuat view data pengurangan data (Menampilkan data sewa, tampilkan nama penyewa, nama ruangan dan durasi sewa)**
```bash
CREATE OR REPLACE VIEW rental_view AS
SELECT users.name AS nama_penyewa, rooms.name AS nama_ruangan, rents.duration AS durasi_sewa
FROM rents
JOIN users ON rents.user_id = users.id
JOIN rooms ON rents.room_id = rooms.id;
```
### Pembuatan Function
Function ini berfungsi untuk menghitungan jumlah ruangan terbanyak, dan berikan keteragan jika ruangan disewa lebih dari
4, maka keterangan 'PALING LAKU' jika tidak 'KURANG LAKU'
```bash
DELIMITER $$

DROP FUNCTION IF EXISTS `room_popularity`$$

CREATE FUNCTION `room_popularity`(params INT) RETURNS VARCHAR(50)
BEGIN        
    IF params > 4 THEN
        RETURN 'PALING LAKU';
    ELSE
        RETURN 'KURANG LAKU';
    END IF;
END$$

DELIMITER ;
```

### Pembuatan Stored Procedure
```bash
DELIMITER $$

DROP PROCEDURE IF EXISTS `rental_report`$$

CREATE PROCEDURE `rental_report`()
BEGIN
    SELECT *, room_popularity(rooms.`rented_count`) AS room_status
    FROM rooms;
END$$

DELIMITER ;
```
