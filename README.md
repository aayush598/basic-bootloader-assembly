# 🧠 Simple x86 Bootloader with BIOS Sector Read

This project is a simple 16-bit bootloader written in x86 Assembly that demonstrates how to read a specific disk sector using BIOS interrupt `INT 13h`. It is designed for floppy disk emulation (e.g., in QEMU) and uses BIOS services to print messages and load data from the disk.

---

## 📁 Project Structure

```

.
├── asm/
│   ├── disk\_read.asm        # Reads one disk sector using BIOS INT 13h
│   ├── print.asm            # BIOS-based print functions (char, string)
│   └── stage1\_bootloader.asm # Main bootloader (runs at 0x7C00)
├── build/
│   └── bootloader.bin       # Compiled bootloader binary
├── README.md                # Project documentation

````

---

## 🧾 Features

- Reads sector 2 from a floppy disk using BIOS interrupt `INT 13h`.
- Loads the sector into memory at `0x0000:0500`.
- Displays custom messages using BIOS interrupt `INT 10h`.
- Demonstrates modular assembly structure with reusable print and disk functions.

---

## 🚀 Getting Started

### 🔧 Prerequisites

Ensure the following tools are installed:

- **NASM** – Assembler for x86 architecture  
  Install with: `sudo apt install nasm` (Linux) or from [https://www.nasm.us/](https://www.nasm.us/)
- **QEMU** – Emulator to run the bootloader  
  Install with: `sudo apt install qemu-system-x86` or from [https://www.qemu.org/](https://www.qemu.org/)
- Unix-like terminal (Linux, macOS, WSL, or Git Bash on Windows)

---

### ⚙️ Build Instructions

```bash
# 1. Assemble the bootloader
nasm -f bin asm/stage1_bootloader.asm -o build/bootloader.bin

# 2. Create a 1.44MB floppy disk image
dd if=/dev/zero of=build/os_image.img bs=512 count=2880

# 3. Write the bootloader to sector 1 (boot sector)
dd if=build/bootloader.bin of=build/os_image.img conv=notrunc

# 4. Write test data to sector 2 (512-byte sector)
echo -n ">> Sector 2 loaded!" | dd of=build/os_image.img bs=512 seek=1 conv=notrunc
````

---

### 🧪 Run with QEMU

```bash
qemu-system-x86_64 -fda build/os_image.img
```

You should see the following output in the QEMU window:

```
Reading sector 2...
>> Sector 2 loaded!
```

---

## 🧠 How It Works

### Bootloader Flow:

1. **BIOS loads boot sector (512 bytes) to `0x7C00` and jumps to it.**
2. **Bootloader initializes segment registers (DS, ES).**
3. **Displays message `"Reading sector 2..."`**
4. **Calls `read_sector`, which uses BIOS `INT 13h` to read sector 2**
5. **If read succeeds, it prints the content of memory at `0x0500`**

### Key BIOS Calls:

* `INT 10h / 0Eh`: Print character in text mode
* `INT 13h / 02h`: Read sectors from disk

---

## 🛠️ Modular Assembly

* `print.asm`: Provides reusable routines to print characters and strings.
* `disk_read.asm`: Abstracts BIOS sector read into a callable subroutine.
* `stage1_bootloader.asm`: Main bootloader logic, includes the other modules.

---

## 📌 Notes

* This project assumes the boot device is a floppy (`DL = 0x00`).
  Change `DL` to `0x80` if using hard disk emulation.
* The sector read logic is minimal and may fail silently if BIOS returns an error.
* BIOS limits restrict this to CHS access; advanced support (e.g., LBA) is not included here.

---

## 📚 References

* [Ralf Brown's Interrupt List](http://www.ctyme.com/intr/int.htm)
* [Intel 8086 Reference Manual](https://pastraiser.com/cpu/i8086/i8086_opcodes.html)
* [Writing a Simple Bootloader](https://wiki.osdev.org/Bootloader)

---

## 📄 License

This project is open-source and licensed under the MIT License.

---

## 👨‍💻 Author

**Aayush Gid**
Electronics & Communication Engineering
Driven by systems programming, embedded systems, and OS dev.
