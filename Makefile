CC = fasm
TARGET = print

build: $(TARGET).asm
	$(CC) $(TARGET).asm
	ld $(TARGET).o $(LIBS) -o $(TARGET)

once: $(TARGET).asm
	$(CC) $(TARGET).asm
	ld $(TARGET).o -o $(TARGET)

dump: $(TARGET)
	objdump -S -M intel -d $(TARGET) > obj.dump
	cat obj.dump

run: $(TARGET)
	./$(TARGET)

clean:
	rm $(TARGET) *.o