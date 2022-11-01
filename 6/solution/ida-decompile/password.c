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
  if ( v12 != 27 )
    return 0LL;
  for ( i = 0; v12 - 2 >= i; ++i )
  {
    v10 = i % v11;
    if ( i % 3 )
    {
      if ( i % 3 == 1 )
      {
        v4[i] = dest[v10] ^ (a1[i] + 22);
      }
      else if ( i % 3 == 2 )
      {
        v4[i] = dest[v10] ^ (a1[i] + 33);
      }
    }
    else
    {
      v4[i] = (char)(a1[i] ^ dest[v10]);
    }
    if ( v4[i] != v3[i] )
      return 0LL;
  }
  return 1LL;
}