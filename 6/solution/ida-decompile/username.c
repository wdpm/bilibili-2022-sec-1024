__int64 __fastcall de5a0ba5285bf7e6(const char *a1)
{
//rsp:64位的栈顶指针，相较于rbp处于低地址
//rbp:64位的栈底指针，相较于rsp处于高地址
  int v2; // [rsp+10h] [rbp-60h]
  int v3[11]; // [rsp+14h] [rbp-5Ch]
  __int64 v4[5]; // [rsp+40h] [rbp-30h] BYREF
  int v5; // [rsp+68h] [rbp-8h]
  int i; // [rsp+6Ch] [rbp-4h]

  // 8 bytes x5 = 40 bytes
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
  if ( v5 != 11 )
    return 0LL;
  for ( i = 0; i <= 4; ++i )
  {
    LODWORD(v4[i]) = 22 * a1[i] + 33 * a1[i + 5];
    HIDWORD(v4[i]) = 22 * a1[i + 5] + 33 * a1[i];
    if ( LODWORD(v4[i]) != v3[2 * i - 1] || HIDWORD(v4[i]) != v3[2 * i] )
      return 0LL;
  }
  return 1LL;
}