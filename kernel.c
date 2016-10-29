#ifndef	_REAL_MODE_
#define	_REAL_MODE_
__asm__(".code16gcc\t\n");
__asm__(".globl	main_kernel\t\n");
__asm__("jmpl	$0, $main_kernel\t\n");
#endif

void print(const char *string)
{
	unsigned int i = 0;
	unsigned char *videomem = (unsigned char *) 0xB8000;
	while (*string != 0) {
		videomem[i] = *string;
		i++;
		videomem[i] = 0x0E;
		i++;
		string++;
	}
	return;
}

__attribute__((noreturn)) void main_kernel(void)
{
	print("Hello World.");
	while(1);
}
