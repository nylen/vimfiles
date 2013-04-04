# Copy this file to system.mk and edit as needed.

# Your Arduino environment.
ARD_REV = 103
ARD_HOME = $(HOME)/arduino-1.0.3/
ARD_BIN = $(ARD_HOME)/hardware/tools/avr/bin
AVRDUDE = $(ARD_HOME)/hardware/tools/avrdude
AVRDUDE_CONF = $(AVRDUDE).conf
CUSTOM_LIBS_DIR = $(HOME)/sketchbook/libraries

# Your favorite serial monitor.
MON_CMD = screen
MON_CMD_PKILL = SCREEN
MON_SPEED = 9600
