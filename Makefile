TARGET      := zip_loader
BUILD       := build
SOURCE      := source

SOURCES     := $(wildcard $(SOURCE)/*.c)
OBJECTS     := $(SOURCES:$(SOURCE)/%.c=$(BUILD)/%.o)

CFLAGS      := -O2 -Wall -mword-relocations -ffunction-sections -fdata-sections
CFLAGS      += -I$(DEVKITPRO)/libctru/include

LDFLAGS     := -specs=3dsx.specs -g
LIBS        := -lctru -lm

CC          := arm-none-eabi-gcc

OUTPUT      := $(TARGET).3dsx

all: $(OUTPUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.o: $(SOURCE)/%.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(OUTPUT): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) $(LIBS) -o $@

clean:
	rm -rf $(BUILD) $(OUTPUT)
