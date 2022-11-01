import copy

from z3 import Solver, BitVec, sat

v3 = [0] * 28

v3[0] = 21
v3[1] = 247
v3[2] = 242
v3[3] = 2
v3[4] = 62
v3[5] = 253
v3[6] = 44
v3[7] = 34
v3[8] = 49
v3[9] = 30
v3[10] = 234
v3[11] = 255
v3[12] = 43
v3[13] = 45
v3[14] = 249
v3[15] = 89
v3[16] = 30
v3[17] = 246
v3[18] = 87
v3[19] = 46
v3[20] = 33
v3[21] = 93
v3[22] = 6
v3[23] = 230
v3[24] = 53
v3[25] = 246

v4 = copy.deepcopy(v3)

dest = ''

# char dest[8]; // [rsp+120h] [rbp-40h] BYREF
# *(_QWORD *)dest = 0LL;

# a1
username = "superadmin"

# strncat(dest, a2, 0xAuLL);
ncat = 10
dest += username[:ncat]


def parse_DWORD_chars(number, reverse=False):
    str_1 = [0, 0, 0, 0]
    str_1[0] = (number >> 24) & 0xff
    str_1[1] = (number >> 16) & 0xff
    str_1[2] = (number >> 8) & 0xff
    str_1[3] = number & 0xff
    result = ""
    if reverse:
        for s in reversed(str_1):
            if s:
                result += chr(s)
    else:
        for s in str_1:
            if s:
                result += chr(s)
    return result


# 注意：字节存储顺序分为大端序（Big-endian）和小端序（Little-endian）。
# 操作系统一般都是小端（需要反转顺序），通讯协议一般是大端（标准对齐）。

# *(_DWORD *) & dest[strlen(dest)] = 0x74656C;
# => 6C 65 74 00 => let\0，\0在后续字符拼贴中会被非空字符覆盖掉
# *(_DWORD *)&dest[strlen(dest)] = 7628140;

str_1 = 'let'
number_1 = 7628140
# str_1 = parse_DWORD_chars(number_1, reverse=True)
print(f'str_1={str_1};len={len(str_1)}')
dest += str_1

dest += "us"
dest += "have"

# *(_DWORD *) & dest[strlen(dest)] = 0x6E7566;
# => 66 75 6E 00 => fun\0
# *(_DWORD *)&dest[strlen(dest)] = 7239014;

str_2 = 'fun'
number_2 = 7239014
# str_2 = parse_DWORD_chars(number_2, reverse=True)
print(f'str_2={str_2};len={len(str_2)}')
dest += str_2

print(f'dest len= {len(dest)}')
print(f'dest={dest}')

s = Solver()
known_len = 27
a1 = [BitVec('p%d' % i, 8) for i in range(0, known_len)]

v12 = len(a1)
v11 = len(dest)
for i in range(0, v12 - 2 + 1):
    v10 = i % v11
    if not (i % 3 == 0):
        if i % 3 == 1:
            s.add(v4[i] == (ord(dest[v10]) ^ (a1[i] + 22)))
        if i % 3 == 2:
            s.add(v4[i] == (ord(dest[v10]) ^ (a1[i] + 33)))
    else:
        s.add(v4[i] == (a1[i] ^ ord(dest[v10])))

if s.check() == sat:
    m = s.model()
    # print("Get result=" + str(m))
    nicer = sorted([(key, m[key]) for key in m], key=lambda x: int(str(x[0])[1:]))
    print(nicer)
    res = ""
    for idx, item in enumerate(nicer):
        code = item[1]
        res += chr(code.as_long())
    print(res)
else:
    print('not found.')
