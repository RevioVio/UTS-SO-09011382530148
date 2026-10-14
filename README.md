# UTS Sistem Operasi

## Identitas
- Nama: Muhammad Revio
- NIM: 09011382530148
- Kelas: SKU3B

## Deskripsi
Script `backup.sh` mencari semua file `.txt` di `~/data_09011382530148` termasuk subdirektori menggunakan `find`, lalu membuat arsip `.tar.gz` di `~/backup_09011382530148` dengan nama memuat NIM dan timestamp. Setiap eksekusi menambahkan satu baris ke `backup.log`, menampilkan isi arsip dengan `tar -tzvf`, dan merotasi arsip sehingga hanya 5 arsip terbaru yang disimpan.

`backup_loop.sh` menjalankan `backup.sh` berulang dengan `while true` dan `sleep` sesuai variabel `INTERVAL` (default 60 detik). Script ini bisa dijalankan di background dengan `&` dan dihentikan dengan `kill`.

`alias.sh` mendefinisikan alias `bk148` sesuai 3 digit terakhir NIM untuk menjalankan `backup.sh`.

## Cara Menjalankan
```bash
cd ~/uts-so-09011382530148
chmod +x script/*.sh
./script/backup.sh
INTERVAL=10 ./script/backup_loop.sh &
jobs -l
kill %1
source script/alias.sh
bk148
