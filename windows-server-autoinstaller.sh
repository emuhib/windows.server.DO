#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows 10 21H2"
    echo "7. Windows Server 2025"  # New option added here
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows2016.img"
        iso_link="https://software-static.download.prss.microsoft.com/dbazure/983ab6f7-e3d2-45e6-bc2a-d438b7817626/server/SERVER_EVAL_x64FRE_en-us.iso"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://software-static.download.prss.microsoft.com/dbazure/983ab6f7-e3d2-45e6-bc2a-d438b7817626/server/SERVER_EVAL_x64FRE_en-us_17763.iso"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://software-static.download.prss.microsoft.com/dbazure/983ab6f7-e3d2-45e6-bc2a-d438b7817626/server/SERVER_EVAL_x64FRE_en-us_20348.iso"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 10
        img_file="windows10.img"
        iso_link="https://software-download.microsoft.com/download/pr/19044.1288.211006-0501.21h2_release_svc_refresh_CLIENT_EVAL_x64FRE_en-us.iso"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11
        img_file="windows11.img"
        iso_link="https://software-download.microsoft.com/download/pr/22621.1.220506-1250.NI_RELEASE_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_EN-US.ISO"
        iso_file="windows11.iso"
        ;;
    6)
        # Windows 10 21H2
        img_file="windows1021h2.img"
        iso_link="https://software-download.microsoft.com/download/pr/19044.1288.211006-0501.21h2_release_svc_refresh_CLIENT_EVAL_x64FRE_en-us.iso"
        iso_file="windows1021h2.iso"
        ;;
    7)
        # Windows Server 2025 (New option added here)
        img_file="windows2025.img"
        iso_link="https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso"  # Replace XXXXXX with the actual LinkID
        iso_file="windows2025.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 40G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
