#!/bin/bash
# Nama: Muhammad Revio
# NIM: 09011382530148
# Kelas: SKU3B

NIM="09011382530148"
SRC_DIR="$HOME/data_${NIM}"
DEST_DIR="$HOME/backup_${NIM}"
LOG_FILE="${DEST_DIR}/backup.log"
LIST_FILE="${DEST_DIR}/daftar_txt_$$.txt"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
ARCHIVE_NAME="backup_${NIM}_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${DEST_DIR}/${ARCHIVE_NAME}"

# Buat direktori tujuan jika belum ada
mkdir -p "$DEST_DIR"

# Pindah ke direktori sumber
cd "$SRC_DIR" || { echo "Direktori sumber tidak ditemukan: $SRC_DIR"; exit 1; }

# Cari semua file .txt termasuk subdirektori
find . -type f -name "*.txt" > "$LIST_FILE"

# Hitung jumlah file
JUMLAH=$(wc -l < "$LIST_FILE" | tr -d ' ')

# Jika tidak ada file .txt
if [ "$JUMLAH" -eq 0 ]; then
  echo "Tidak ada file .txt di $SRC_DIR"
  rm -f "$LIST_FILE"
  exit 1
fi

# Buat arsip .tar.gz
tar -czvf "$ARCHIVE_PATH" -T "$LIST_FILE"

# Verifikasi isi arsip
tar -tzvf "$ARCHIVE_PATH"

# Ukuran arsip
UKURAN=$(du -h "$ARCHIVE_PATH" | awk '{print $1}')

# Tambahkan tepat satu baris log
echo "$(date '+%Y-%m-%d %H:%M:%S') | $ARCHIVE_NAME | $JUMLAH | $UKURAN" >> "$LOG_FILE"

# Hapus file daftar sementara
rm -f "$LIST_FILE"

# Fitur pengembangan: rotasi arsip, simpan 5 arsip terbaru
ls -1t "$DEST_DIR"/backup_${NIM}_*.tar.gz 2>/dev/null | tail -n +6 | while IFS= read -r OLD_ARCHIVE; do
  rm -f "$OLD_ARCHIVE"
done

echo "Backup selesai: $ARCHIVE_PATH"
