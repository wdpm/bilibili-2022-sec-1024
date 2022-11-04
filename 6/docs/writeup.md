# 第六题：反编译



## IDA+Z3 solver

> 这里使用的是 IDA 7.6.210427 Windows x64 版本。

- 使用 IDA 64bit 反编译。
- 阅读反编译后的源码，使用 python 复现逻辑，并且使用 Z3 求解。

需要重点关注的函数：

- main
- e5f309fb784e68064d5e118153359789
- de5a0ba5285bf7e6

F5 审查源代码。



## main

```c
int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  char *v3; // [rsp+0h] [rbp-10h]
  void *s; // [rsp+8h] [rbp-8h]

  s = malloc(0x10uLL);
  v3 = (char *)malloc(0x20uLL);
  memset(s, 0, 0x10uLL);
  memset(v3, 0, 0x20uLL);
  printf("Ready to enter system? Please enter your username:");
  fgets((char *)s, 15, stdin);
  if ((unsigned __int8)de5a0ba5285bf7e6(s) != 1 )
    exit(0);
  printf("right! Please enter your password:");
  fgets(v3, 31, stdin);
  if ((unsigned __int8)e5f309fb784e68064d5e118153359789(v3, s) != 1 )
    exit(0);
  printf("welcome!");
  exit(0);
}
```

对于 char *fgets(char *str, int n, FILE *stream) 函数：

```
str -- 这是指向一个字符数组的指针，该数组存储了要读取的字符串。
n -- 这是要读取的最大字符数（包括最后的空字符）。通常是使用以 str 传递的数组长度。
stream -- 这是指向 FILE 对象的指针，该 FILE 对象标识了要从中读取字符的流。
```

这里明显是用户登陆逻辑，涉及 username 和 password。

我们继续梳理线索：

- 根据 fgets((char *)s, 15, stdin); 得知调用 de5a0ba5285bf7e6(s) 进行判断，判定用户名是否存在；
- 根据 fgets(v3, 31, stdin); 得知调用 e5f309fb784e68064d5e118153359789(v3, s) 判定密码是否正确。



## username

我们先处理 username 的逻辑。

```c
__int64 __fastcall de5a0ba5285bf7e6(const char *a1)
{
  int v2; // [rsp+10h] [rbp-60h]
  int v3[11]; // [rsp+14h] [rbp-5Ch]
  __int64 v4[5]; // [rsp+40h] [rbp-30h] BYREF
  int v5; // [rsp+68h] [rbp-8h]
  int i; // [rsp+6Ch] [rbp-4h]

  memset(v4, 0, sizeof(v4));
  v5 = strlen(a1);
  v2 = 5731;
  v3[0] = 5929;
  v3[1] = 5874;
  v3[2] = 6061;
  v3[3] = 6061;
  v3[4] = 6094;
  v3[5] = 5687;
  v3[6] = 5643;
  v3[7] = 6138;
  v3[8] = 6182;
  if (v5 != 11)
    return 0LL;
  for (i = 0; i <= 4; ++i)
  {
    LODWORD(v4[i]) = 22 * a1[i] + 33 * a1[i + 5];
    HIDWORD(v4[i]) = 22 * a1[i + 5] + 33 * a1[i];
    if (LODWORD(v4[i]) != v3[2 * i - 1] || HIDWORD(v4[i]) != v3[2 * i] )
      return 0LL;
  }
  return 1LL;
}
```

> 注意：i=0 时，v3[2*i-1] 为 v3[-1]。单从这点信息来，v3[-1] 的值不确定，需要考查汇编地址。

在这里，可以结合汇编地址的注释。 
```
int v2; // [rsp+10h] [rbp-60h]
int v3[11]; // [rsp+14h] [rbp-5Ch]
...
v2 = 5731;
v3[0] = 5929;
```
可以得知 v3[-1] 刚好是 v2。
因为 [rsp+14h] - [rsp+10h] = 4h。h代表十六进制，4h代表4 bytes。
v3 是 int类型，刚好往前偏移一个int长度的地址，也就是回到int v2。


我们继续梳理代码逻辑：

- a1 是输入的用户名，也就是要求解的 username 字符串。
- v5 =11, 而 v5 为 a1 的长度，因此 a1 长度为 11。
- 后面的代码对 a1 进行一些算术操作，然后赋值给 v4 的高 / 低双字节的特定位置。
- 这个判断：LODWORD(v4[i]) != v3[2 * i - 1] || HIDWORD(v4[i]) != v3[2 * i] 就是约束条件。
- v3 数组大部分元素已知，因此可以缩小 v4[i] 的解范围，v4 和 a1 有关，因此可以求 a1 的解集。

开始行动：
- 将上面逻辑翻译成 python 代码并且简化。
- 使用 Z3 对目标值进行求解。

solve_user.py

```py
from z3 import *

s = Solver()

v5 = 11
u = [Int("u[%d]" % a, )for a in range(v5)]

# 注意这里是 5731，别复制错了
v2 = 5731

v3 = [Int(f'v3[{i}]', )for i in range(11)]
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
    
# s.add(22 * u[0] + 33 * u[5] == v3[2 * 0 - 1], 22 * u[5] + 33 * u[0] == v3[2 * 0])
s.add(22 * u[0] + 33 * u[5] == v2, 22 * u[5] + 33 * u[0] == v3[2 * 0])
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

```



## password

```c
__int64 __fastcall e5f309fb784e68064d5e118153359789(const char *a1, const char *a2)
{
  int v3[28]; // [rsp+10h] [rbp-150h]
  int v4[40]; // [rsp+80h] [rbp-E0h] BYREF
  char dest[8]; // [rsp+120h] [rbp-40h] BYREF
  __int64 v6; // [rsp+128h] [rbp-38h]
  __int64 v7; // [rsp+130h] [rbp-30h]
  __int64 v8; // [rsp+138h] [rbp-28h]
  __int64 v9; // [rsp+140h] [rbp-20h]
  int v10; // [rsp+150h] [rbp-10h]
  int v11; // [rsp+154h] [rbp-Ch]
  int v12; // [rsp+158h] [rbp-8h]
  int i; // [rsp+15Ch] [rbp-4h]

  *(_QWORD *)dest = 0LL;
  v6 = 0LL;
  v7 = 0LL;
  v8 = 0LL;
  v9 = 0LL;
  memset(v4, 0, sizeof(v4));
  v3[0] = 21;
  v3[1] = 247;
  v3[2] = 242;
  v3[3] = 2;
  v3[4] = 62;
  v3[5] = 253;
  v3[6] = 44;
  v3[7] = 34;
  v3[8] = 49;
  v3[9] = 30;
  v3[10] = 234;
  v3[11] = 255;
  v3[12] = 43;
  v3[13] = 45;
  v3[14] = 249;
  v3[15] = 89;
  v3[16] = 30;
  v3[17] = 246;
  v3[18] = 87;
  v3[19] = 46;
  v3[20] = 33;
  v3[21] = 93;
  v3[22] = 6;
  v3[23] = 230;
  v3[24] = 53;
  v3[25] = 246;
  strncat(dest, a2, 0xAuLL);
  *(_DWORD *)&dest[strlen(dest)] = 7628140;
  strcat(dest, "us");
  strcat(dest, "have");
  *(_DWORD *)&dest[strlen(dest)] = 7239014;
  v12 = strlen(a1);
  v11 = strlen(dest);
  if (v12 != 27)
    return 0LL;
  for (i = 0; v12 - 2 >= i; ++i)
  {
    v10 = i % v11;
    if (i % 3)
    {
      if (i % 3 == 1)
      {
        v4[i] = dest[v10] ^ (a1[i] + 22);
      }
      else if (i % 3 == 2)
      {
        v4[i] = dest[v10] ^ (a1[i] + 33);
      }
    }
    else
    {
      v4[i] = (char)(a1[i] ^ dest[v10]);
    }
    if (v4[i] != v3[i] )
      return 0LL;
  }
  return 1LL;
}
```

这里说明上面代码的关键流程：

- strncat(dest, a2, 0xAuLL); 将 a2 复制 10 个长度的字符到 dest。
- *(_DWORD *)&dest[strlen(dest)] = 7628140; 这里一定要注意字符序的问题，大端还是小端？这里是小端，需要反转。
- if (v12 != 27) 得知 v12=27，结合 v12 = strlen(a1); 可知 a1 长度。
- 后续的 for 循坏，只需要翻译为等价的 z3 求解约束表达式即可。

完整源码可以参阅相关 github 仓库。



## 参考

- [字节序 Endianness](https://en.wikipedia.org/wiki/Endianness)
- [Applied Reverse Engineering: Accelerated Assembly [P1]](https://revers.engineering/applied-re-accelerated-assembly-p1/)