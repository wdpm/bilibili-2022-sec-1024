from z3 import *


# Int
# Bool
# Array
# BitVec('a',8) / BitVec('a',32) 位数组

# API
# Solver() 求解器实例化
# add() 添加约束
# check() 检测
# model() 交集

def solve_1():
    s = Solver()
    x = Int('x')
    y = Int('y')
    s.add(x + y == 4)
    s.add(And(x >= 0, y >= 0))

    while s.check() == sat:
        model = s.model()
        print(model)
        s.add(Or(x != s.model()[x], y != s.model()[y]))


def solve_2():
    s = Solver()
    x = Int('x')
    y = Int('y')
    s.add(x + y == 5)
    s.add(2 * x + 3 * y == 14)
    if s.check() == sat:
        result = s.model()
        print(result)
    else:
        print('unsolvable.')


solve_1()
