include build_config/config.mk

.PHONY: all run boot-image clean Kernel

all: boot-image

run:
	qemu-system-x86_64 -drive format=raw,file=target/x86_64-KiselOS/debug/bootimage-KiselOS.bin $(QEMU_FLAGS)

boot-image:
	cargo bootimage

clean:
	cargo clean

Kernel:
	cargo build
