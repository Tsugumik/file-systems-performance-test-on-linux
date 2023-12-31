# File systems performance test on Linux

In this project, I wanted to measure the performance of different file systems on Linux.

Test results and charts are available in [results](./results).

## Tested file systems
- NTFS
- FAT32
- EXFAT
- EXT4
- EXT3
- EXT2
- BTRFS
- HFS+
- XFS
- JFS
- ReiserFS

## Test platform
- Lenovo Legion 5 15ARH05H

### Drives
Test partition size: 25 GB
- SSD NVMe Toshiba KBG40ZNT512G 0.5 TB
- SSD NVMe Kingston A2000 0,5 TB

### Operating system
- Manjaro Linux x86_64
- Kernel 6.6.8-2-MANJARO

### Laptop specs
- CPU AMD Ryzen 7 4800H 2.9 GHz
- GPU NVIDIA GeForce RTX 2060 Mobile
- GPU AMD ATI Radeon RX Vega 6
- RAM Kingston FURY 2 X 16 GB 3200 MHz CL20

## Testing methods
- Read speed using hdparm (MB/s)
- Data write time using time and cp (seconds)
  - 1 file 3.8 GB
  - 100 files, each 10 MB
  - 30000 files, each 8 KB
- Compression time for created files using zip command (seconds)
- Decompression time for created archives using unzip command (seconds)

For testing the Kingston A2000 SSD, data is copies to it from the Toshiba SSD, formated with the EXT4 file system.

In summary, the Toshiba SSD plays a supporting role and doesn't directly participate in the tests.

### Scripts
I wrote two scripts. One to generate test data and one to test all the file systems one by one.
- scripts/create_test_data.sh
- scripts/test_file_systems.sh

**Remember to edit the contents of the variables before running the scripts! If you don't, you may lose important data on your disk!**

**I am not responsible for the operation of the scripts on your computer!**

## Tools used
- hdparm
- cp
- time
- dd
- zip
- unzip
- Microsoft Excel

# LICENSE
The content of this project itself is licensed under the Creative Commons Attribution 4.0 International license, and the source code of bash scripts is licensed under the GNU General Public License v3.0.