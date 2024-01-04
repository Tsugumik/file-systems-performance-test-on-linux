# Summary (SSD)
The summary includes a brief conclusion and a chart made in Microsoft Excel

## Read speed
![Read speed chart](./charts/read_speed.png)

## Copy time

### 1 file 3.8 GB
![Copy time of 1 file 3.8 GB chart](./charts/copy_time_of_1_file_3_8_GB.png)

### 100 files of 10 MB each
![Copy time of 100 files of 10 MB each chart](./charts/copy_time_of_100_files_of_10_MB_each.png)

### 30000 files of 8 KB each
![Copy time of 30000 files of 8 KB each chart](./charts/copy_time_of_30000_files_of_8_KB_each.png)

## Compression time

### 1 file 3.8 GB
![Compression time of 1 file 3.8 GB chart](./charts/compression_time_of_one_file_3_8_GB.png)

### 100 files of 10 MB each
![Compression time of 100 files of 10 MB each chart](./charts/compression_time_of_100_files_of_10_MB_each.png)

### 30000 files of 8 KB each
![Compression time of 30000 files of 8 KB each chart](./charts/copy_time_of_30000_files_of_8_KB_each.png)

## Decompression time

### 1 file 3.8 GB
![Decompression time of 1 file 3.8 GB chart](./charts/decompression_time_1_file_3_8_GB.png)

### 100 files of 10 MB each
![Decompression time of 100 files of 10 MB each chart](./charts/decompression_time_of_100_files_of_10_MB_each.png)

### 30000 files of 8 KB each

#### Limit x to 250
![Decompression time of 30000 files of 8 KB each chart](./charts/decompression_time_of_30000_files_of_8_KB_each_limited_x_to_250.png)

#### Limit x to 700
![Decompression time of 30000 files of 8 KB each chart](./charts/decompression_time_of_30000_files_of_8_KB_each_limited_x_to_700.png)

## Conclusion
The results are expected, although at some points I am surprised that the performance of NTFS and FAT32 is so bad. I was positively surprised by the performance of HFS+.

It is impossible to say which file system on Linux is the best. Often the differences are so small that they are probably due more to measurement error than actual file system performance.