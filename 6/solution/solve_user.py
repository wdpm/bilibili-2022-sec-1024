from z3 import *

s = Solver()

v5 = 11
u = [Int("u[%d]" % a, ) for a in range(v5)]

v2 = 5371

v3 = [Int(f'v3[{i}]', ) for i in range(11)]
v3[0] = 5929
v3[1] = 5874
v3[2] = 6061
v3[3] = 6061
v3[4] = 6094
v3[5] = 5687
v3[6] = 5643
v3[7] = 6138
v3[8] = 6182

for i in range(0, len(u)):
    s.add(And(32 <= u[i], u[i] < 127))

# what v3[-1] is in c compiler. a[-1] => *(a-1)
# print(v3[-1])

# v3[-1] 是一种数组越界的行为，这种行为非常不确定：可能得到正常的值，也可能得到意外的值。
# array[-1] 这种行为定义存在，但不代表它指向的内存空间合法，值不确定。
# 我们想要限制 u0和 u5的取值，但是v3[-1]的值却是不确定的，因此先去掉这个约束：22 * u[0] + 33 * u[5] == v3[-1]

s.add(22 * u[0] + 33 * u[5] == v3[2 * 0 - 1], 22 * u[5] + 33 * u[0] == v3[2 * 0])
s.add(22 * u[1] + 33 * u[6] == v3[2 * 1 - 1], 22 * u[6] + 33 * u[1] == v3[2 * 1])
s.add(22 * u[2] + 33 * u[7] == v3[2 * 2 - 1], 22 * u[7] + 33 * u[2] == v3[2 * 2])
s.add(22 * u[3] + 33 * u[8] == v3[2 * 3 - 1], 22 * u[8] + 33 * u[3] == v3[2 * 3])
s.add(22 * u[4] + 33 * u[9] == v3[2 * 4 - 1], 22 * u[9] + 33 * u[4] == v3[2 * 4])

count = 0
while s.check() == sat:
    m = s.model()
    count += 1

    memo = []
    username = ""
    for i in range(10):
        username += chr(int(f"{m[u[i]]}"))
        memo.append(u[i] != int(f"{m[u[i]]}"))
    print(username)
    s.add(Or(memo))
else:
    print('end.')

print(f'count: {count}')
