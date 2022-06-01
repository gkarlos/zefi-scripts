import mmap, re, csv

FILE="allvancisinventoryfiles.txt"

LINES_PER_CSV=1000

# PATTERNS
# 3005 => .*3005[0-9]{10}.*
# 10   => .*10[0-9]{6}.*
# N10  => .*N10[0-9]{6}.*
# ZO   => .*ZO[0-9]{5}.* # re.IGNORECASE
# ZK   => .*ZK[0-9]{5}.* # re.IGNORECASE
#ZDK   => .*ZDK[0-9]{5}.* # re.IGNORECASE
# ZF   => .*ZF[0-9]{5}.* # re.IGNORECASE
#ZDF   => .*ZDF[0-9]{5}.* # re.IGNORECASE

PATTERN=".*ZDF[0-9]{5}.*"
PREFIX="ZDF"

csv_file_id=1
with open(FILE, "r") as f:
    csv_file_name = "{}.matches.{}.csv".format(PREFIX, csv_file_id)
    print("new csv file:", csv_file_name)
    csv_lines = 0
    csv_file = open(csv_file_name, "w")
    writer = csv.writer(csv_file)

    # mm = mmap.mmap(f.fileno(), 0, prot=mmap.PROT_READ)
    for line in f:
        # l = line.decode('utf-8').strip()
        l = line.strip()
        if re.search(PATTERN, l, re.IGNORECASE):
            writer.writerow(l[1:].split('/'))
            csv_lines += 1
            if csv_lines == LINES_PER_CSV:
                csv_lines = 0
                csv_file_id += 1
                csv_file_name = "{}.matches.{}.csv".format(PREFIX, csv_file_id)
                # print("new csv file:", csv_file_name)
                csv_file.close()
                csv_file = open(csv_file_name, "w")
                writer = csv.writer(csv_file)
    # mm.close()
