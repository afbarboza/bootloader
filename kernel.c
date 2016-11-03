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

char read(void)
{
	char letter;
	__asm__ __volatile__
	(
		"movb	$0x0, %%ah;\t\n"
		"int	$0x16;\t\n"
		"movb	$0x0E, %%ah;\t\n"
		"int	$0x10;\t\n"
		: "=a"(letter)
	);
	return letter;
}

__attribute__((noreturn)) void main_kernel(void)
{
	print("Hello World.");
	read();
	while(1);
}
