TARGET := zip_loader
BUILD  := build
SRC    := source

CFILES := $(wildcard $(SRC)/*.c)
OFILES := $(CFILES:$(SRC)/%.c=$(BUILD)/%.o)

INCLUDE := -I$(DEVKITPRO)/libctru/include
LIBS    := -lctru -lm

CFLAGS  := -O2 -Wall $(INCLUDE)
LDFLAGS := -specs=3dsx.specs

CC      := arm-none-eabi-gcc

all: $(TARGET).3dsx

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.o: $(SRC)/%.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET).3dsx: $(OFILES)
	$(CC) $(OFILES) $(LDFLAGS) $(LIBS) -o $@

clean:
	rm -rf $(BUILD) $(TARGET).3dsx
