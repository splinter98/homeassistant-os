#!/bin/bash
# shellcheck disable=SC2155

function hassos_pre_image {
    local BOOT_DATA="$(path_boot_dir)"
    local SPL_IMG="$(path_spl_img)"
    local SPL_BIN="${BINARIES_DIR}/sunxi-spl.bin"
    local UBOOT="${BINARIES_DIR}/u-boot.itb"

    cp "${BINARIES_DIR}/boot.scr" "${BOOT_DATA}/boot.scr"
    cp "${BINARIES_DIR}/sun50i-h5-nanopi-neo-plus2.dtb" "${BOOT_DATA}/sun50i-h5-nanopi-neo-plus2.dtb"

    echo "console=ttyS0,115200" > "${BOOT_DATA}/cmdline.txt"

    create_spl_image

    dd if="${SPL_BIN}" of="${SPL_IMG}" conv=notrunc bs=512 seek=16
    dd if="${UBOOT}" of="${SPL_IMG}" conv=notrunc bs=512 seek=80
}


function hassos_post_image() {
    convert_disk_image_xz
}
