FLASHFILE ?= ledcube444.hex
MCU       ?= stc12
SDCCOPTS  ?= --iram-size 256 --Werror --disable-warning 158
STCGAL    ?= stcgal
PORT      ?= /dev/ttyUSB0

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
		$(STCGAL) -a -l 2400 -b 115200 -p $(PORT) -P $(MCU) $(FLASHFILE)

clean:
		rm -f *.ihx *.hex *.bin
		rm -rf build/
