CC = arm-linux-gnueabihf-gcc
CFLAGS = -Wall -Wextra -O2 -pthread -march=armv7-a -mtune=cortex-a9 -mfpu=vfpv3-d16 -mfloat-abi=hard

SRCS := $(wildcard *.c)
OBJS := $(SRCS:.c=.o)
TARGET := app

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ 
   
	
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


clean:
	rm -f $(OBJS) $(TARGET)
    
