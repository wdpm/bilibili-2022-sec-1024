from z3 import *

username_len = 11
u = [BitVec('u%d' % i, 8) for i in range(0, username_len)]

s = Solver()

for i in range(0, username_len):
    expr = And(u[i] >= 32, u[i] < 127)
    s.add(expr)

    s.add(u[i] & 0x0000FFFF == 90)

if s.check() == sat:
    m = s.model()
    print("Model: " + str(m))