# ----------------------------
# Projeto 3DS - ZIP Loader
# ----------------------------

TARGET      := zip_loader
BUILD       := build
SOURCE      := source
INCLUDES    := include

# Toolchain do devkitPro
DEVKITPRO   ?= $(DEVKITPRO)
DEVKITARM   ?= $(DEVKITARM)

CC          := arm-none-eabi-gcc
CXX         := arm-none-eabi-g++

ARCH        := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft

CFLAGS      := -O2 -Wall -mword-relocations \
               -ffunction-sections -fdata-sections \
               $(ARCH) \
               -I$(INCLUDES)

CXXFLAGS    := $(CFLAGS) -fno-rtti -fno-exceptions

LDFLAGS     := -specs=3dsx.specs -g $(ARCH) \
               -Wl,--gc-sections

LIBS        := -lctru -lm

# Arquivos fonte
SOURCES     := $(wildcard $(SOURCE)/*.c)
OBJECTS     := $(SOURCES:$(SOURCE)/%.c=$(BUILD)/%.o)

# Output
OUTPUT      := $(TARGET).3dsx

# ----------------------------
# Regras
# ----------------------------

all: $(OUTPUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.o: $(SOURCE)/%.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(OUTPUT): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) $(LIBS) -o $@

clean:
	rm -rf $(BUILD) $(OUTPUT)

run: all
	citra $(OUTPUT) || true
