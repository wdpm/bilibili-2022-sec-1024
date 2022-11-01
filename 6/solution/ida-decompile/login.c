int __cdecl __noreturn main(int argc, const char **argv, const char **envp)
{
  char *v3; // [rsp+0h] [rbp-10h]
  void *s; // [rsp+8h] [rbp-8h]

  s = malloc(0x10uLL);
  v3 = (char *)malloc(0x20uLL);
  memset(s, 0, 0x10uLL);
  memset(v3, 0, 0x20uLL);
  printf("Ready to enter system? Please enter your username: ");
  fgets((char *)s, 15, stdin);
  if ( (unsigned __int8)de5a0ba5285bf7e6((const char *)s) != 1 )
    exit(0);
  printf("right! Please enter your password: ");
  fgets(v3, 31, stdin);
  if ( (unsigned __int8)e5f309fb784e68064d5e118153359789(v3, (const char *)s) != 1 )
    exit(0);
  printf("welcome!");
  exit(0);
}