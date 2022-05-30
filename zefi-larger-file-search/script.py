import mmap

FILE="allvancisinventoryfiles.txt"
print("allvancisinventoryfiles")

with open(FILE, "r") as f:
    mm = mmap.mmap(f.fileno(), 0, prot=mmap.PROT_READ)
    i = 0
    for line in iter(mm.readline, b""):
        l = line.decode('utf-8').strip()
        if i < 10:
            print(l)
            i += 1
        else:
            break
    mm.close()
