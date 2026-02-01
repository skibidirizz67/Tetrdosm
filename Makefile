AS = riscv64-linux-gnu-as
CC = riscv64-linux-gnu-gcc
LD = riscv64-linux-gnu-ld

SRCDIR = src
BLDDIR = build
BINDIR = bin

SRC_AS = $(wildcard $(SRCDIR)/*.s)
SRC_C = $(wildcard $(SRCDIR)/*.c)
OBJ = $(SRC:$(SRCDIR)/%.s=$(BLDDIR)/%.o)

ASFLAGS = 
LDFLAGS =

TARGET = $(BINDIR)/tetrdosm

all: $(TARGET)

$(TARGET): $(OBJ) | $(BINDIR)
	$(LD) $(LDFLAGS) $^ -o $@
$(BLDDIR)/%.o: $(SRCDIR)/%.s| $(BLDDIR)
	$(AS) $(ASFLAGS) $(@:$(BLDDIR)/%.o=$(SRCDIR)/%.s) -o $@

$(BLDDIR) $(BINDIR):
	mkdir $@

run: $(TARGET)
	qemu-riscv64 ./$(TARGET)

debug: $(TARGET)
	qemu-riscv64 -g 1234 ./$(TARGET)

clean:
	rm -rf $(BLDDIR)
