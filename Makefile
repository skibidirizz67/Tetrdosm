AS = riscv64-linux-gnu-as
LD = riscv64-linux-gnu-ld

SRCDIR = src
BLDDIR = build
BINDIR = bin

SRC = $(wildcard $(SRCDIR)/*.s)
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
