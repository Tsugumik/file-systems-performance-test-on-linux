#!/bin/bash

dd if=/dev/urandom of=file3_8gb.bin bs=1M count=3900

mkdir files_100
for i in {1..100}; do dd if=/dev/urandom of=files_100/file_$i.bin bs=1M count=10; done

mkdir files_30000
for i in {1..30000}; do dd if=/dev/urandom of=files_30000/$i.bin bs=1K count=8; done