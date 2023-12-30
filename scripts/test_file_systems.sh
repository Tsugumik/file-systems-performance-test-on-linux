#!/bin/bash

# Check if the script is run with administrator privileges
if [ "$EUID" -ne 0 ]; then
    echo "Run the script with administrator privileges!"
    exit 1
fi

# List of file systems
file_systems=("ntfs" "fat32" "exfat" "ext4" "ext3" "ext2" "btrfs" "hfsplus" "xfs" "jfs" "reiserfs")

# Configuration variables
partition=""        # Path to the partition. Ex. /dev/nvme1n1p6 or /dev/sda1
mount_path=""       # Mount point for the partition. Ex. /mnt/test
data_path=""        # Path to test data generated by create_test_data.sh. Ex. /home/waltuh/test_data
results_path=""     # Path for test results. Ex. /home/waltuh/results

# Get the current username
username=$(whoami)

# Unmount the test partition (if mounted)
sudo umount -q /mnt/test

# Loop through each file system for processing
for fs in "${file_systems[@]}"; do
    echo "=== PROCESSING FILE SYSTEM: $fs ==="

    # Format the partition based on the file system
    echo "# FORMATTING PARTITION #"
    case $fs in
        "ntfs")
            sudo mkfs.$fs -F $partition
            ;;
        "fat32")
            sudo mkfs.fat -F 32 $partition
            ;;
        "ext4"|"ext3"|"ext2")
            sudo mkfs.$fs -F -q $partition
            ;;
        "btrfs"|"xfs"|"reiserfs")
            sudo mkfs.$fs -f $partition
            ;;
        "reiser4")
            sudo mkfs.$fs -y $partition
            ;;
        "jfs")
            sudo mkfs.$fs -q $partition
            ;;
        "exfat"|"hfsplus")
            sudo mkfs.$fs $partition
            ;;
        *)
            echo "Unknown file system: $fs"
            continue
            ;;
    esac

    # Mount the partition and set permissions
    if [ $fs == "ext4" ] || [ $fs == "ext3" ] || [ $fs == "ext2" ] || [ $fs == "btrfs" ] || [ $fs == "xfs" ] || [ $fs == "reiserfs" ];  then
        sudo mount -t "$fs" $partition $mount_path
        sudo chown -R $username:$username $mount_path
        sudo chmod -R 755 $mount_path
    else
        sudo mount -o uid=$(id -u $username),gid=$(id -g $username) $partition $mount_path
    fi

    # Change directory to the test data path
    cd $data_path

    # Perform copy operations and test read speed
    echo "# PERFORMING COPY OPERATIONS AND TESTING READ SPEED #"
    (echo "# Read speed test"
    sudo hdparm -t $partition
    echo "# Copying a 3.8 GB file test"
    time -p cp file3_8gb.bin $mount_path
    echo "# Copying a directory with 100 files test"
    time -p cp -r files_100 $mount_path
    echo "# Copying a directory with 30000 files test"
    time -p cp -r files_30000 $mount_path) > "${results_path}/${fs}_operations_result.txt" 2>&1

    # Change directory to the mounted partition
    cd $mount_path

    # Perform file compression operations
    echo "# PERFORMING FILE COMPRESSION OPERATIONS"
    (echo "# Compressing a 3.8 GB file test"
    time -p zip -q zip1 file3_8gb.bin
    echo "# Compressing a directory with 100 files test"
    time -p zip -q -r zip2 files_100
    echo "# Compressing a directory with 30000 files test"
    time -p zip -q -r zip3 files_30000) > "${results_path}/${fs}_zip_operations_result.txt" 2>&1

    # Perform file decompression operations
    echo "# PERFORMING FILE DECOMPRESSION OPERATIONS"
    (echo "# Decompressing a 3.8 GB file test"
    time -p unzip -q zip1.zip -d e_file
    echo "# Decompressing a directory with 100 files test"
    time -p unzip -q zip2.zip -d e_files_100
    echo "# Decompressing a directory with 30000 files test"
    time -p unzip -q zip3.zip -d e_files_30000) > "${results_path}/${fs}_unzip_operations_results.txt" 2>&1

    # Change directory back to the test data path
    cd $data_path

    # Unmount the partition
    sudo umount $mount_path
done
