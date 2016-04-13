SDCCOPTS  ?= --iram-size 256 --Werror --disable-warning 158
PORT      ?= /dev/ttyUSB0
STCGAL    ?= stcgal
FLASHFILE ?= ledcube444.hex
SYSCLK    ?= 11059
MCU       ?= stc12

SRC = ledcube444.c

OBJ=$(patsubst %.c,build/%.rel, $(SRC))

all: ledcube444

build/%.rel: %.c
		mkdir -p $(dir $@)
		sdcc $(SDCCOPTS) -o $@ -c $<

ledcube444: $(OBJ)
		sdcc -o build/ $(SRC) $(SDCCOPTS)
		cp build/$@.ihx $@.hex

flash:
		$(STCGAL) -p $(PORT) -P $(MCU) -t $(SYSCLK) $(FLASHFILE)

clean:
		rm -f *.ihx *.hex *.bin
		rm -rf build/
