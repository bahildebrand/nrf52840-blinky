.SECONDARY:

TOOLCHAIN := arm-none-eabi-
CC := $(TOOLCHAIN)gcc
LD := $(TOOLCHAIN)ld
OBJCPY := $(TOOLCHAIN)objcopy
SRC_DIR := src
BUILD_DIR := build

.PHONY: all
all: nrf52840-blinky

.PHONY: nrf52840-blinky
nrf52840-blinky: $(BUILD_DIR)/nrf52840-blinky.bin

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

INCLUDES += -Iinclude

LDFLAGS += -Map=$(BUILD_DIR)/output.map \
		   -T link/link.ld

CFLAGS += -nostdlib \
		  -mcpu=cortex-m4 \
		  $(INCLUDES) \
		  -g \
		  -Wall \
		  -Werror

SRC := $(wildcard $(SRC_DIR)/*)
OBJS := $(patsubst %.c, $(BUILD_DIR)/%.o, $(SRC))

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf
	$(OBJCPY) $< $@ -O binary

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) -c -o $@ $< $(CFLAGS)

$(BUILD_DIR)/%.elf: $(OBJS)
	$(LD) -o $@ $^ $(LDFLAGS)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)