
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	f3 0f 1e fa          	endbr64 
  100004:	55                   	push   %rbp
  100005:	48 89 e5             	mov    %rsp,%rbp
  100008:	53                   	push   %rbx
  100009:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 31                	int    $0x31
  10000f:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100011:	48 8d 05 ff 2f 00 00 	lea    0x2fff(%rip),%rax        # 103017 <end+0xfff>
  100018:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001e:	48 89 05 e3 1f 00 00 	mov    %rax,0x1fe3(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100025:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100028:	48 83 e8 01          	sub    $0x1,%rax
  10002c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100032:	48 89 05 c7 1f 00 00 	mov    %rax,0x1fc7(%rip)        # 102000 <stack_bottom>
  100039:	eb 02                	jmp    10003d <process_main+0x3d>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  10003b:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  10003d:	e8 42 03 00 00       	call   100384 <rand>
  100042:	48 63 d0             	movslq %eax,%rdx
  100045:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  10004c:	48 c1 fa 25          	sar    $0x25,%rdx
  100050:	89 c1                	mov    %eax,%ecx
  100052:	c1 f9 1f             	sar    $0x1f,%ecx
  100055:	29 ca                	sub    %ecx,%edx
  100057:	6b d2 64             	imul   $0x64,%edx,%edx
  10005a:	29 d0                	sub    %edx,%eax
  10005c:	39 d8                	cmp    %ebx,%eax
  10005e:	7d db                	jge    10003b <process_main+0x3b>
	    void * ret = malloc(PAGESIZE);
  100060:	bf 00 10 00 00       	mov    $0x1000,%edi
  100065:	e8 12 00 00 00       	call   10007c <malloc>
	    if(ret == NULL)
  10006a:	48 85 c0             	test   %rax,%rax
  10006d:	74 04                	je     100073 <process_main+0x73>
		break;
	    *((int*)ret) = p;       // check we have write access
  10006f:	89 18                	mov    %ebx,(%rax)
  100071:	eb c8                	jmp    10003b <process_main+0x3b>
  100073:	cd 32                	int    $0x32
  100075:	eb fc                	jmp    100073 <process_main+0x73>

0000000000100077 <free>:
#include "malloc.h"

void free(void *firstbyte) {
  100077:	f3 0f 1e fa          	endbr64 
    return;
}
  10007b:	c3                   	ret    

000000000010007c <malloc>:

void *malloc(uint64_t numbytes) {
  10007c:	f3 0f 1e fa          	endbr64 
    return 0 ;
}
  100080:	b8 00 00 00 00       	mov    $0x0,%eax
  100085:	c3                   	ret    

0000000000100086 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  100086:	f3 0f 1e fa          	endbr64 
    return 0;
}
  10008a:	b8 00 00 00 00       	mov    $0x0,%eax
  10008f:	c3                   	ret    

0000000000100090 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  100090:	f3 0f 1e fa          	endbr64 
    return 0;
}
  100094:	b8 00 00 00 00       	mov    $0x0,%eax
  100099:	c3                   	ret    

000000000010009a <defrag>:

void defrag() {
  10009a:	f3 0f 1e fa          	endbr64 
}
  10009e:	c3                   	ret    

000000000010009f <heap_info>:

int heap_info(heap_info_struct * info) {
  10009f:	f3 0f 1e fa          	endbr64 
    return 0;
}
  1000a3:	b8 00 00 00 00       	mov    $0x0,%eax
  1000a8:	c3                   	ret    

00000000001000a9 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  1000a9:	f3 0f 1e fa          	endbr64 
  1000ad:	55                   	push   %rbp
  1000ae:	48 89 e5             	mov    %rsp,%rbp
  1000b1:	48 83 ec 28          	sub    $0x28,%rsp
  1000b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1000b9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1000bd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  1000c1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1000c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1000c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1000cd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  1000d1:	eb 1c                	jmp    1000ef <memcpy+0x46>
        *d = *s;
  1000d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1000d7:	0f b6 10             	movzbl (%rax),%edx
  1000da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1000de:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1000e0:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1000e5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1000ea:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  1000ef:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1000f4:	75 dd                	jne    1000d3 <memcpy+0x2a>
    }
    return dst;
  1000f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1000fa:	c9                   	leave  
  1000fb:	c3                   	ret    

00000000001000fc <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  1000fc:	f3 0f 1e fa          	endbr64 
  100100:	55                   	push   %rbp
  100101:	48 89 e5             	mov    %rsp,%rbp
  100104:	48 83 ec 28          	sub    $0x28,%rsp
  100108:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10010c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100110:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100114:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100118:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  10011c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100120:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  100124:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100128:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  10012c:	73 6a                	jae    100198 <memmove+0x9c>
  10012e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100132:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100136:	48 01 d0             	add    %rdx,%rax
  100139:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  10013d:	73 59                	jae    100198 <memmove+0x9c>
        s += n, d += n;
  10013f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100143:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  100147:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10014b:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  10014f:	eb 17                	jmp    100168 <memmove+0x6c>
            *--d = *--s;
  100151:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  100156:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  10015b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10015f:	0f b6 10             	movzbl (%rax),%edx
  100162:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100166:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100168:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10016c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100170:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100174:	48 85 c0             	test   %rax,%rax
  100177:	75 d8                	jne    100151 <memmove+0x55>
    if (s < d && s + n > d) {
  100179:	eb 2e                	jmp    1001a9 <memmove+0xad>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  10017b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10017f:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100183:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100187:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10018b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10018f:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100193:	0f b6 12             	movzbl (%rdx),%edx
  100196:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100198:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  10019c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1001a0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1001a4:	48 85 c0             	test   %rax,%rax
  1001a7:	75 d2                	jne    10017b <memmove+0x7f>
        }
    }
    return dst;
  1001a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1001ad:	c9                   	leave  
  1001ae:	c3                   	ret    

00000000001001af <memset>:

void* memset(void* v, int c, size_t n) {
  1001af:	f3 0f 1e fa          	endbr64 
  1001b3:	55                   	push   %rbp
  1001b4:	48 89 e5             	mov    %rsp,%rbp
  1001b7:	48 83 ec 28          	sub    $0x28,%rsp
  1001bb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1001bf:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  1001c2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1001ca:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  1001ce:	eb 15                	jmp    1001e5 <memset+0x36>
        *p = c;
  1001d0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1001d3:	89 c2                	mov    %eax,%edx
  1001d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1001d9:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001db:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1001e0:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  1001e5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  1001ea:	75 e4                	jne    1001d0 <memset+0x21>
    }
    return v;
  1001ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1001f0:	c9                   	leave  
  1001f1:	c3                   	ret    

00000000001001f2 <strlen>:

size_t strlen(const char* s) {
  1001f2:	f3 0f 1e fa          	endbr64 
  1001f6:	55                   	push   %rbp
  1001f7:	48 89 e5             	mov    %rsp,%rbp
  1001fa:	48 83 ec 18          	sub    $0x18,%rsp
  1001fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100202:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100209:	00 
  10020a:	eb 0a                	jmp    100216 <strlen+0x24>
        ++n;
  10020c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100211:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100216:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10021a:	0f b6 00             	movzbl (%rax),%eax
  10021d:	84 c0                	test   %al,%al
  10021f:	75 eb                	jne    10020c <strlen+0x1a>
    }
    return n;
  100221:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100225:	c9                   	leave  
  100226:	c3                   	ret    

0000000000100227 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100227:	f3 0f 1e fa          	endbr64 
  10022b:	55                   	push   %rbp
  10022c:	48 89 e5             	mov    %rsp,%rbp
  10022f:	48 83 ec 20          	sub    $0x20,%rsp
  100233:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100237:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10023b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100242:	00 
  100243:	eb 0a                	jmp    10024f <strnlen+0x28>
        ++n;
  100245:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10024a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  10024f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100253:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100257:	74 0b                	je     100264 <strnlen+0x3d>
  100259:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10025d:	0f b6 00             	movzbl (%rax),%eax
  100260:	84 c0                	test   %al,%al
  100262:	75 e1                	jne    100245 <strnlen+0x1e>
    }
    return n;
  100264:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100268:	c9                   	leave  
  100269:	c3                   	ret    

000000000010026a <strcpy>:

char* strcpy(char* dst, const char* src) {
  10026a:	f3 0f 1e fa          	endbr64 
  10026e:	55                   	push   %rbp
  10026f:	48 89 e5             	mov    %rsp,%rbp
  100272:	48 83 ec 20          	sub    $0x20,%rsp
  100276:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10027a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  10027e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100282:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100286:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  10028a:	48 8d 42 01          	lea    0x1(%rdx),%rax
  10028e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100292:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100296:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10029a:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  10029e:	0f b6 12             	movzbl (%rdx),%edx
  1002a1:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  1002a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002a7:	48 83 e8 01          	sub    $0x1,%rax
  1002ab:	0f b6 00             	movzbl (%rax),%eax
  1002ae:	84 c0                	test   %al,%al
  1002b0:	75 d4                	jne    100286 <strcpy+0x1c>
    return dst;
  1002b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1002b6:	c9                   	leave  
  1002b7:	c3                   	ret    

00000000001002b8 <strcmp>:

int strcmp(const char* a, const char* b) {
  1002b8:	f3 0f 1e fa          	endbr64 
  1002bc:	55                   	push   %rbp
  1002bd:	48 89 e5             	mov    %rsp,%rbp
  1002c0:	48 83 ec 10          	sub    $0x10,%rsp
  1002c4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1002c8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1002cc:	eb 0a                	jmp    1002d8 <strcmp+0x20>
        ++a, ++b;
  1002ce:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  1002d3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  1002d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002dc:	0f b6 00             	movzbl (%rax),%eax
  1002df:	84 c0                	test   %al,%al
  1002e1:	74 1d                	je     100300 <strcmp+0x48>
  1002e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002e7:	0f b6 00             	movzbl (%rax),%eax
  1002ea:	84 c0                	test   %al,%al
  1002ec:	74 12                	je     100300 <strcmp+0x48>
  1002ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1002f2:	0f b6 10             	movzbl (%rax),%edx
  1002f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1002f9:	0f b6 00             	movzbl (%rax),%eax
  1002fc:	38 c2                	cmp    %al,%dl
  1002fe:	74 ce                	je     1002ce <strcmp+0x16>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100300:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100304:	0f b6 00             	movzbl (%rax),%eax
  100307:	89 c2                	mov    %eax,%edx
  100309:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10030d:	0f b6 00             	movzbl (%rax),%eax
  100310:	38 c2                	cmp    %al,%dl
  100312:	0f 97 c0             	seta   %al
  100315:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100318:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10031c:	0f b6 00             	movzbl (%rax),%eax
  10031f:	89 c1                	mov    %eax,%ecx
  100321:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100325:	0f b6 00             	movzbl (%rax),%eax
  100328:	38 c1                	cmp    %al,%cl
  10032a:	0f 92 c0             	setb   %al
  10032d:	0f b6 c8             	movzbl %al,%ecx
  100330:	89 d0                	mov    %edx,%eax
  100332:	29 c8                	sub    %ecx,%eax
}
  100334:	c9                   	leave  
  100335:	c3                   	ret    

0000000000100336 <strchr>:

char* strchr(const char* s, int c) {
  100336:	f3 0f 1e fa          	endbr64 
  10033a:	55                   	push   %rbp
  10033b:	48 89 e5             	mov    %rsp,%rbp
  10033e:	48 83 ec 10          	sub    $0x10,%rsp
  100342:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100346:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100349:	eb 05                	jmp    100350 <strchr+0x1a>
        ++s;
  10034b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100350:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100354:	0f b6 00             	movzbl (%rax),%eax
  100357:	84 c0                	test   %al,%al
  100359:	74 0e                	je     100369 <strchr+0x33>
  10035b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10035f:	0f b6 00             	movzbl (%rax),%eax
  100362:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100365:	38 d0                	cmp    %dl,%al
  100367:	75 e2                	jne    10034b <strchr+0x15>
    }
    if (*s == (char) c) {
  100369:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10036d:	0f b6 00             	movzbl (%rax),%eax
  100370:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100373:	38 d0                	cmp    %dl,%al
  100375:	75 06                	jne    10037d <strchr+0x47>
        return (char*) s;
  100377:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10037b:	eb 05                	jmp    100382 <strchr+0x4c>
    } else {
        return NULL;
  10037d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100382:	c9                   	leave  
  100383:	c3                   	ret    

0000000000100384 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100384:	f3 0f 1e fa          	endbr64 
  100388:	55                   	push   %rbp
  100389:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  10038c:	8b 05 7e 1c 00 00    	mov    0x1c7e(%rip),%eax        # 102010 <rand_seed_set>
  100392:	85 c0                	test   %eax,%eax
  100394:	75 0a                	jne    1003a0 <rand+0x1c>
        srand(819234718U);
  100396:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  10039b:	e8 24 00 00 00       	call   1003c4 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1003a0:	8b 05 6e 1c 00 00    	mov    0x1c6e(%rip),%eax        # 102014 <rand_seed>
  1003a6:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  1003ac:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1003b1:	89 05 5d 1c 00 00    	mov    %eax,0x1c5d(%rip)        # 102014 <rand_seed>
    return rand_seed & RAND_MAX;
  1003b7:	8b 05 57 1c 00 00    	mov    0x1c57(%rip),%eax        # 102014 <rand_seed>
  1003bd:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1003c2:	5d                   	pop    %rbp
  1003c3:	c3                   	ret    

00000000001003c4 <srand>:

void srand(unsigned seed) {
  1003c4:	f3 0f 1e fa          	endbr64 
  1003c8:	55                   	push   %rbp
  1003c9:	48 89 e5             	mov    %rsp,%rbp
  1003cc:	48 83 ec 08          	sub    $0x8,%rsp
  1003d0:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  1003d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1003d6:	89 05 38 1c 00 00    	mov    %eax,0x1c38(%rip)        # 102014 <rand_seed>
    rand_seed_set = 1;
  1003dc:	c7 05 2a 1c 00 00 01 	movl   $0x1,0x1c2a(%rip)        # 102010 <rand_seed_set>
  1003e3:	00 00 00 
}
  1003e6:	90                   	nop
  1003e7:	c9                   	leave  
  1003e8:	c3                   	ret    

00000000001003e9 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  1003e9:	f3 0f 1e fa          	endbr64 
  1003ed:	55                   	push   %rbp
  1003ee:	48 89 e5             	mov    %rsp,%rbp
  1003f1:	48 83 ec 28          	sub    $0x28,%rsp
  1003f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1003f9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  1003fd:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100400:	48 8d 05 a9 0e 00 00 	lea    0xea9(%rip),%rax        # 1012b0 <upper_digits.1>
  100407:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (base < 0) {
  10040b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10040f:	79 0e                	jns    10041f <fill_numbuf+0x36>
        digits = lower_digits;
  100411:	48 8d 05 b8 0e 00 00 	lea    0xeb8(%rip),%rax        # 1012d0 <lower_digits.0>
  100418:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        base = -base;
  10041c:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10041f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100424:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100428:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  10042b:	8b 45 dc             	mov    -0x24(%rbp),%eax
  10042e:	48 63 c8             	movslq %eax,%rcx
  100431:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100435:	ba 00 00 00 00       	mov    $0x0,%edx
  10043a:	48 f7 f1             	div    %rcx
  10043d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100441:	48 01 d0             	add    %rdx,%rax
  100444:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100449:	0f b6 10             	movzbl (%rax),%edx
  10044c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100450:	88 10                	mov    %dl,(%rax)
        val /= base;
  100452:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100455:	48 63 f0             	movslq %eax,%rsi
  100458:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10045c:	ba 00 00 00 00       	mov    $0x0,%edx
  100461:	48 f7 f6             	div    %rsi
  100464:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100468:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  10046d:	75 bc                	jne    10042b <fill_numbuf+0x42>
    return numbuf_end;
  10046f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100473:	c9                   	leave  
  100474:	c3                   	ret    

0000000000100475 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100475:	f3 0f 1e fa          	endbr64 
  100479:	55                   	push   %rbp
  10047a:	48 89 e5             	mov    %rsp,%rbp
  10047d:	53                   	push   %rbx
  10047e:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100485:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  10048c:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100492:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100499:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1004a0:	e9 bd 09 00 00       	jmp    100e62 <printer_vprintf+0x9ed>
        if (*format != '%') {
  1004a5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1004ac:	0f b6 00             	movzbl (%rax),%eax
  1004af:	3c 25                	cmp    $0x25,%al
  1004b1:	74 31                	je     1004e4 <printer_vprintf+0x6f>
            p->putc(p, *format, color);
  1004b3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1004ba:	4c 8b 00             	mov    (%rax),%r8
  1004bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1004c4:	0f b6 00             	movzbl (%rax),%eax
  1004c7:	0f b6 c8             	movzbl %al,%ecx
  1004ca:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1004d0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1004d7:	89 ce                	mov    %ecx,%esi
  1004d9:	48 89 c7             	mov    %rax,%rdi
  1004dc:	41 ff d0             	call   *%r8
            continue;
  1004df:	e9 76 09 00 00       	jmp    100e5a <printer_vprintf+0x9e5>
        }

        // process flags
        int flags = 0;
  1004e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  1004eb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1004f2:	01 
  1004f3:	eb 4d                	jmp    100542 <printer_vprintf+0xcd>
            const char* flagc = strchr(flag_chars, *format);
  1004f5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1004fc:	0f b6 00             	movzbl (%rax),%eax
  1004ff:	0f be c0             	movsbl %al,%eax
  100502:	89 c6                	mov    %eax,%esi
  100504:	48 8d 05 a5 0c 00 00 	lea    0xca5(%rip),%rax        # 1011b0 <flag_chars>
  10050b:	48 89 c7             	mov    %rax,%rdi
  10050e:	e8 23 fe ff ff       	call   100336 <strchr>
  100513:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100517:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  10051c:	74 34                	je     100552 <printer_vprintf+0xdd>
                flags |= 1 << (flagc - flag_chars);
  10051e:	48 8d 15 8b 0c 00 00 	lea    0xc8b(%rip),%rdx        # 1011b0 <flag_chars>
  100525:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100529:	48 29 d0             	sub    %rdx,%rax
  10052c:	ba 01 00 00 00       	mov    $0x1,%edx
  100531:	89 c1                	mov    %eax,%ecx
  100533:	d3 e2                	shl    %cl,%edx
  100535:	89 d0                	mov    %edx,%eax
  100537:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  10053a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100541:	01 
  100542:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100549:	0f b6 00             	movzbl (%rax),%eax
  10054c:	84 c0                	test   %al,%al
  10054e:	75 a5                	jne    1004f5 <printer_vprintf+0x80>
  100550:	eb 01                	jmp    100553 <printer_vprintf+0xde>
            } else {
                break;
  100552:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100553:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  10055a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100561:	0f b6 00             	movzbl (%rax),%eax
  100564:	3c 30                	cmp    $0x30,%al
  100566:	7e 67                	jle    1005cf <printer_vprintf+0x15a>
  100568:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10056f:	0f b6 00             	movzbl (%rax),%eax
  100572:	3c 39                	cmp    $0x39,%al
  100574:	7f 59                	jg     1005cf <printer_vprintf+0x15a>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100576:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  10057d:	eb 2e                	jmp    1005ad <printer_vprintf+0x138>
                width = 10 * width + *format++ - '0';
  10057f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100582:	89 d0                	mov    %edx,%eax
  100584:	c1 e0 02             	shl    $0x2,%eax
  100587:	01 d0                	add    %edx,%eax
  100589:	01 c0                	add    %eax,%eax
  10058b:	89 c1                	mov    %eax,%ecx
  10058d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100594:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100598:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  10059f:	0f b6 00             	movzbl (%rax),%eax
  1005a2:	0f be c0             	movsbl %al,%eax
  1005a5:	01 c8                	add    %ecx,%eax
  1005a7:	83 e8 30             	sub    $0x30,%eax
  1005aa:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1005ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005b4:	0f b6 00             	movzbl (%rax),%eax
  1005b7:	3c 2f                	cmp    $0x2f,%al
  1005b9:	0f 8e 85 00 00 00    	jle    100644 <printer_vprintf+0x1cf>
  1005bf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005c6:	0f b6 00             	movzbl (%rax),%eax
  1005c9:	3c 39                	cmp    $0x39,%al
  1005cb:	7e b2                	jle    10057f <printer_vprintf+0x10a>
        if (*format >= '1' && *format <= '9') {
  1005cd:	eb 75                	jmp    100644 <printer_vprintf+0x1cf>
            }
        } else if (*format == '*') {
  1005cf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1005d6:	0f b6 00             	movzbl (%rax),%eax
  1005d9:	3c 2a                	cmp    $0x2a,%al
  1005db:	75 68                	jne    100645 <printer_vprintf+0x1d0>
            width = va_arg(val, int);
  1005dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005e4:	8b 00                	mov    (%rax),%eax
  1005e6:	83 f8 2f             	cmp    $0x2f,%eax
  1005e9:	77 30                	ja     10061b <printer_vprintf+0x1a6>
  1005eb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005f2:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1005f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1005fd:	8b 00                	mov    (%rax),%eax
  1005ff:	89 c0                	mov    %eax,%eax
  100601:	48 01 d0             	add    %rdx,%rax
  100604:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10060b:	8b 12                	mov    (%rdx),%edx
  10060d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100610:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100617:	89 0a                	mov    %ecx,(%rdx)
  100619:	eb 1a                	jmp    100635 <printer_vprintf+0x1c0>
  10061b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100622:	48 8b 40 08          	mov    0x8(%rax),%rax
  100626:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10062a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100631:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100635:	8b 00                	mov    (%rax),%eax
  100637:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  10063a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100641:	01 
  100642:	eb 01                	jmp    100645 <printer_vprintf+0x1d0>
        if (*format >= '1' && *format <= '9') {
  100644:	90                   	nop
        }

        // process precision
        int precision = -1;
  100645:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  10064c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100653:	0f b6 00             	movzbl (%rax),%eax
  100656:	3c 2e                	cmp    $0x2e,%al
  100658:	0f 85 00 01 00 00    	jne    10075e <printer_vprintf+0x2e9>
            ++format;
  10065e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100665:	01 
            if (*format >= '0' && *format <= '9') {
  100666:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10066d:	0f b6 00             	movzbl (%rax),%eax
  100670:	3c 2f                	cmp    $0x2f,%al
  100672:	7e 67                	jle    1006db <printer_vprintf+0x266>
  100674:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10067b:	0f b6 00             	movzbl (%rax),%eax
  10067e:	3c 39                	cmp    $0x39,%al
  100680:	7f 59                	jg     1006db <printer_vprintf+0x266>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100682:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100689:	eb 2e                	jmp    1006b9 <printer_vprintf+0x244>
                    precision = 10 * precision + *format++ - '0';
  10068b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  10068e:	89 d0                	mov    %edx,%eax
  100690:	c1 e0 02             	shl    $0x2,%eax
  100693:	01 d0                	add    %edx,%eax
  100695:	01 c0                	add    %eax,%eax
  100697:	89 c1                	mov    %eax,%ecx
  100699:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006a0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1006a4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1006ab:	0f b6 00             	movzbl (%rax),%eax
  1006ae:	0f be c0             	movsbl %al,%eax
  1006b1:	01 c8                	add    %ecx,%eax
  1006b3:	83 e8 30             	sub    $0x30,%eax
  1006b6:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1006b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006c0:	0f b6 00             	movzbl (%rax),%eax
  1006c3:	3c 2f                	cmp    $0x2f,%al
  1006c5:	0f 8e 85 00 00 00    	jle    100750 <printer_vprintf+0x2db>
  1006cb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006d2:	0f b6 00             	movzbl (%rax),%eax
  1006d5:	3c 39                	cmp    $0x39,%al
  1006d7:	7e b2                	jle    10068b <printer_vprintf+0x216>
            if (*format >= '0' && *format <= '9') {
  1006d9:	eb 75                	jmp    100750 <printer_vprintf+0x2db>
                }
            } else if (*format == '*') {
  1006db:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1006e2:	0f b6 00             	movzbl (%rax),%eax
  1006e5:	3c 2a                	cmp    $0x2a,%al
  1006e7:	75 68                	jne    100751 <printer_vprintf+0x2dc>
                precision = va_arg(val, int);
  1006e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006f0:	8b 00                	mov    (%rax),%eax
  1006f2:	83 f8 2f             	cmp    $0x2f,%eax
  1006f5:	77 30                	ja     100727 <printer_vprintf+0x2b2>
  1006f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1006fe:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100702:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100709:	8b 00                	mov    (%rax),%eax
  10070b:	89 c0                	mov    %eax,%eax
  10070d:	48 01 d0             	add    %rdx,%rax
  100710:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100717:	8b 12                	mov    (%rdx),%edx
  100719:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10071c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100723:	89 0a                	mov    %ecx,(%rdx)
  100725:	eb 1a                	jmp    100741 <printer_vprintf+0x2cc>
  100727:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10072e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100732:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100736:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10073d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100741:	8b 00                	mov    (%rax),%eax
  100743:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100746:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  10074d:	01 
  10074e:	eb 01                	jmp    100751 <printer_vprintf+0x2dc>
            if (*format >= '0' && *format <= '9') {
  100750:	90                   	nop
            }
            if (precision < 0) {
  100751:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100755:	79 07                	jns    10075e <printer_vprintf+0x2e9>
                precision = 0;
  100757:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  10075e:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100765:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  10076c:	00 
        int length = 0;
  10076d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100774:	48 8d 05 3b 0a 00 00 	lea    0xa3b(%rip),%rax        # 1011b6 <flag_chars+0x6>
  10077b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    again:
        switch (*format) {
  10077f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100786:	0f b6 00             	movzbl (%rax),%eax
  100789:	0f be c0             	movsbl %al,%eax
  10078c:	83 e8 43             	sub    $0x43,%eax
  10078f:	83 f8 37             	cmp    $0x37,%eax
  100792:	0f 87 b6 03 00 00    	ja     100b4e <printer_vprintf+0x6d9>
  100798:	89 c0                	mov    %eax,%eax
  10079a:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
  1007a1:	00 
  1007a2:	48 8d 05 1b 0a 00 00 	lea    0xa1b(%rip),%rax        # 1011c4 <flag_chars+0x14>
  1007a9:	8b 04 02             	mov    (%rdx,%rax,1),%eax
  1007ac:	48 98                	cltq   
  1007ae:	48 8d 15 0f 0a 00 00 	lea    0xa0f(%rip),%rdx        # 1011c4 <flag_chars+0x14>
  1007b5:	48 01 d0             	add    %rdx,%rax
  1007b8:	3e ff e0             	notrack jmp *%rax
        case 'l':
        case 'z':
            length = 1;
  1007bb:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  1007c2:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  1007c9:	01 
            goto again;
  1007ca:	eb b3                	jmp    10077f <printer_vprintf+0x30a>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1007cc:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1007d0:	74 5d                	je     10082f <printer_vprintf+0x3ba>
  1007d2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007d9:	8b 00                	mov    (%rax),%eax
  1007db:	83 f8 2f             	cmp    $0x2f,%eax
  1007de:	77 30                	ja     100810 <printer_vprintf+0x39b>
  1007e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007e7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1007eb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1007f2:	8b 00                	mov    (%rax),%eax
  1007f4:	89 c0                	mov    %eax,%eax
  1007f6:	48 01 d0             	add    %rdx,%rax
  1007f9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100800:	8b 12                	mov    (%rdx),%edx
  100802:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100805:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10080c:	89 0a                	mov    %ecx,(%rdx)
  10080e:	eb 1a                	jmp    10082a <printer_vprintf+0x3b5>
  100810:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100817:	48 8b 40 08          	mov    0x8(%rax),%rax
  10081b:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10081f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100826:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10082a:	48 8b 00             	mov    (%rax),%rax
  10082d:	eb 5c                	jmp    10088b <printer_vprintf+0x416>
  10082f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100836:	8b 00                	mov    (%rax),%eax
  100838:	83 f8 2f             	cmp    $0x2f,%eax
  10083b:	77 30                	ja     10086d <printer_vprintf+0x3f8>
  10083d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100844:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100848:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10084f:	8b 00                	mov    (%rax),%eax
  100851:	89 c0                	mov    %eax,%eax
  100853:	48 01 d0             	add    %rdx,%rax
  100856:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10085d:	8b 12                	mov    (%rdx),%edx
  10085f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100862:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100869:	89 0a                	mov    %ecx,(%rdx)
  10086b:	eb 1a                	jmp    100887 <printer_vprintf+0x412>
  10086d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100874:	48 8b 40 08          	mov    0x8(%rax),%rax
  100878:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10087c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100883:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100887:	8b 00                	mov    (%rax),%eax
  100889:	48 98                	cltq   
  10088b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  10088f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100893:	48 c1 f8 38          	sar    $0x38,%rax
  100897:	25 80 00 00 00       	and    $0x80,%eax
  10089c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  10089f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  1008a3:	74 09                	je     1008ae <printer_vprintf+0x439>
  1008a5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1008a9:	48 f7 d8             	neg    %rax
  1008ac:	eb 04                	jmp    1008b2 <printer_vprintf+0x43d>
  1008ae:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1008b2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1008b6:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1008b9:	83 c8 60             	or     $0x60,%eax
  1008bc:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1008bf:	e9 cf 02 00 00       	jmp    100b93 <printer_vprintf+0x71e>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1008c4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1008c8:	74 5d                	je     100927 <printer_vprintf+0x4b2>
  1008ca:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008d1:	8b 00                	mov    (%rax),%eax
  1008d3:	83 f8 2f             	cmp    $0x2f,%eax
  1008d6:	77 30                	ja     100908 <printer_vprintf+0x493>
  1008d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008df:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1008e3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1008ea:	8b 00                	mov    (%rax),%eax
  1008ec:	89 c0                	mov    %eax,%eax
  1008ee:	48 01 d0             	add    %rdx,%rax
  1008f1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1008f8:	8b 12                	mov    (%rdx),%edx
  1008fa:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1008fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100904:	89 0a                	mov    %ecx,(%rdx)
  100906:	eb 1a                	jmp    100922 <printer_vprintf+0x4ad>
  100908:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10090f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100913:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100917:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10091e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100922:	48 8b 00             	mov    (%rax),%rax
  100925:	eb 5c                	jmp    100983 <printer_vprintf+0x50e>
  100927:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10092e:	8b 00                	mov    (%rax),%eax
  100930:	83 f8 2f             	cmp    $0x2f,%eax
  100933:	77 30                	ja     100965 <printer_vprintf+0x4f0>
  100935:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10093c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100940:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100947:	8b 00                	mov    (%rax),%eax
  100949:	89 c0                	mov    %eax,%eax
  10094b:	48 01 d0             	add    %rdx,%rax
  10094e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100955:	8b 12                	mov    (%rdx),%edx
  100957:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10095a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100961:	89 0a                	mov    %ecx,(%rdx)
  100963:	eb 1a                	jmp    10097f <printer_vprintf+0x50a>
  100965:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10096c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100970:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100974:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10097b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10097f:	8b 00                	mov    (%rax),%eax
  100981:	89 c0                	mov    %eax,%eax
  100983:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100987:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  10098b:	e9 03 02 00 00       	jmp    100b93 <printer_vprintf+0x71e>
        case 'x':
            base = -16;
  100990:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100997:	e9 28 ff ff ff       	jmp    1008c4 <printer_vprintf+0x44f>
        case 'X':
            base = 16;
  10099c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  1009a3:	e9 1c ff ff ff       	jmp    1008c4 <printer_vprintf+0x44f>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  1009a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009af:	8b 00                	mov    (%rax),%eax
  1009b1:	83 f8 2f             	cmp    $0x2f,%eax
  1009b4:	77 30                	ja     1009e6 <printer_vprintf+0x571>
  1009b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009bd:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1009c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009c8:	8b 00                	mov    (%rax),%eax
  1009ca:	89 c0                	mov    %eax,%eax
  1009cc:	48 01 d0             	add    %rdx,%rax
  1009cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009d6:	8b 12                	mov    (%rdx),%edx
  1009d8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1009db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009e2:	89 0a                	mov    %ecx,(%rdx)
  1009e4:	eb 1a                	jmp    100a00 <printer_vprintf+0x58b>
  1009e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1009ed:	48 8b 40 08          	mov    0x8(%rax),%rax
  1009f1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1009f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1009fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a00:	48 8b 00             	mov    (%rax),%rax
  100a03:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100a07:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100a0e:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100a15:	e9 79 01 00 00       	jmp    100b93 <printer_vprintf+0x71e>
        case 's':
            data = va_arg(val, char*);
  100a1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a21:	8b 00                	mov    (%rax),%eax
  100a23:	83 f8 2f             	cmp    $0x2f,%eax
  100a26:	77 30                	ja     100a58 <printer_vprintf+0x5e3>
  100a28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a2f:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a33:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a3a:	8b 00                	mov    (%rax),%eax
  100a3c:	89 c0                	mov    %eax,%eax
  100a3e:	48 01 d0             	add    %rdx,%rax
  100a41:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a48:	8b 12                	mov    (%rdx),%edx
  100a4a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100a4d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a54:	89 0a                	mov    %ecx,(%rdx)
  100a56:	eb 1a                	jmp    100a72 <printer_vprintf+0x5fd>
  100a58:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a5f:	48 8b 40 08          	mov    0x8(%rax),%rax
  100a63:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100a67:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100a6e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100a72:	48 8b 00             	mov    (%rax),%rax
  100a75:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100a79:	e9 15 01 00 00       	jmp    100b93 <printer_vprintf+0x71e>
        case 'C':
            color = va_arg(val, int);
  100a7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a85:	8b 00                	mov    (%rax),%eax
  100a87:	83 f8 2f             	cmp    $0x2f,%eax
  100a8a:	77 30                	ja     100abc <printer_vprintf+0x647>
  100a8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a93:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100a97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100a9e:	8b 00                	mov    (%rax),%eax
  100aa0:	89 c0                	mov    %eax,%eax
  100aa2:	48 01 d0             	add    %rdx,%rax
  100aa5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100aac:	8b 12                	mov    (%rdx),%edx
  100aae:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100ab1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ab8:	89 0a                	mov    %ecx,(%rdx)
  100aba:	eb 1a                	jmp    100ad6 <printer_vprintf+0x661>
  100abc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ac3:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ac7:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100acb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100ad2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100ad6:	8b 00                	mov    (%rax),%eax
  100ad8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  100ade:	e9 77 03 00 00       	jmp    100e5a <printer_vprintf+0x9e5>
        case 'c':
            data = numbuf;
  100ae3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ae7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  100aeb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100af2:	8b 00                	mov    (%rax),%eax
  100af4:	83 f8 2f             	cmp    $0x2f,%eax
  100af7:	77 30                	ja     100b29 <printer_vprintf+0x6b4>
  100af9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b00:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b0b:	8b 00                	mov    (%rax),%eax
  100b0d:	89 c0                	mov    %eax,%eax
  100b0f:	48 01 d0             	add    %rdx,%rax
  100b12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b19:	8b 12                	mov    (%rdx),%edx
  100b1b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b1e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b25:	89 0a                	mov    %ecx,(%rdx)
  100b27:	eb 1a                	jmp    100b43 <printer_vprintf+0x6ce>
  100b29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b30:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b34:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b38:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b3f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b43:	8b 00                	mov    (%rax),%eax
  100b45:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100b48:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  100b4c:	eb 45                	jmp    100b93 <printer_vprintf+0x71e>
        default:
            data = numbuf;
  100b4e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100b52:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  100b56:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b5d:	0f b6 00             	movzbl (%rax),%eax
  100b60:	84 c0                	test   %al,%al
  100b62:	74 0c                	je     100b70 <printer_vprintf+0x6fb>
  100b64:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b6b:	0f b6 00             	movzbl (%rax),%eax
  100b6e:	eb 05                	jmp    100b75 <printer_vprintf+0x700>
  100b70:	b8 25 00 00 00       	mov    $0x25,%eax
  100b75:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  100b78:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  100b7c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b83:	0f b6 00             	movzbl (%rax),%eax
  100b86:	84 c0                	test   %al,%al
  100b88:	75 08                	jne    100b92 <printer_vprintf+0x71d>
                format--;
  100b8a:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  100b91:	01 
            }
            break;
  100b92:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  100b93:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100b96:	83 e0 20             	and    $0x20,%eax
  100b99:	85 c0                	test   %eax,%eax
  100b9b:	74 1e                	je     100bbb <printer_vprintf+0x746>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  100b9d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  100ba1:	48 83 c0 18          	add    $0x18,%rax
  100ba5:	8b 55 e0             	mov    -0x20(%rbp),%edx
  100ba8:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100bac:	48 89 ce             	mov    %rcx,%rsi
  100baf:	48 89 c7             	mov    %rax,%rdi
  100bb2:	e8 32 f8 ff ff       	call   1003e9 <fill_numbuf>
  100bb7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  100bbb:	48 8d 05 f4 05 00 00 	lea    0x5f4(%rip),%rax        # 1011b6 <flag_chars+0x6>
  100bc2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100bc6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bc9:	83 e0 20             	and    $0x20,%eax
  100bcc:	85 c0                	test   %eax,%eax
  100bce:	74 51                	je     100c21 <printer_vprintf+0x7ac>
  100bd0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bd3:	83 e0 40             	and    $0x40,%eax
  100bd6:	85 c0                	test   %eax,%eax
  100bd8:	74 47                	je     100c21 <printer_vprintf+0x7ac>
            if (flags & FLAG_NEGATIVE) {
  100bda:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bdd:	25 80 00 00 00       	and    $0x80,%eax
  100be2:	85 c0                	test   %eax,%eax
  100be4:	74 0d                	je     100bf3 <printer_vprintf+0x77e>
                prefix = "-";
  100be6:	48 8d 05 ca 05 00 00 	lea    0x5ca(%rip),%rax        # 1011b7 <flag_chars+0x7>
  100bed:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100bf1:	eb 7d                	jmp    100c70 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100bf3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100bf6:	83 e0 10             	and    $0x10,%eax
  100bf9:	85 c0                	test   %eax,%eax
  100bfb:	74 0d                	je     100c0a <printer_vprintf+0x795>
                prefix = "+";
  100bfd:	48 8d 05 b5 05 00 00 	lea    0x5b5(%rip),%rax        # 1011b9 <flag_chars+0x9>
  100c04:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100c08:	eb 66                	jmp    100c70 <printer_vprintf+0x7fb>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  100c0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c0d:	83 e0 08             	and    $0x8,%eax
  100c10:	85 c0                	test   %eax,%eax
  100c12:	74 5c                	je     100c70 <printer_vprintf+0x7fb>
                prefix = " ";
  100c14:	48 8d 05 a0 05 00 00 	lea    0x5a0(%rip),%rax        # 1011bb <flag_chars+0xb>
  100c1b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
            if (flags & FLAG_NEGATIVE) {
  100c1f:	eb 4f                	jmp    100c70 <printer_vprintf+0x7fb>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100c21:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c24:	83 e0 20             	and    $0x20,%eax
  100c27:	85 c0                	test   %eax,%eax
  100c29:	74 46                	je     100c71 <printer_vprintf+0x7fc>
  100c2b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c2e:	83 e0 01             	and    $0x1,%eax
  100c31:	85 c0                	test   %eax,%eax
  100c33:	74 3c                	je     100c71 <printer_vprintf+0x7fc>
                   && (base == 16 || base == -16)
  100c35:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  100c39:	74 06                	je     100c41 <printer_vprintf+0x7cc>
  100c3b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100c3f:	75 30                	jne    100c71 <printer_vprintf+0x7fc>
                   && (num || (flags & FLAG_ALT2))) {
  100c41:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100c46:	75 0c                	jne    100c54 <printer_vprintf+0x7df>
  100c48:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c4b:	25 00 01 00 00       	and    $0x100,%eax
  100c50:	85 c0                	test   %eax,%eax
  100c52:	74 1d                	je     100c71 <printer_vprintf+0x7fc>
            prefix = (base == -16 ? "0x" : "0X");
  100c54:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  100c58:	75 09                	jne    100c63 <printer_vprintf+0x7ee>
  100c5a:	48 8d 05 5c 05 00 00 	lea    0x55c(%rip),%rax        # 1011bd <flag_chars+0xd>
  100c61:	eb 07                	jmp    100c6a <printer_vprintf+0x7f5>
  100c63:	48 8d 05 56 05 00 00 	lea    0x556(%rip),%rax        # 1011c0 <flag_chars+0x10>
  100c6a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100c6e:	eb 01                	jmp    100c71 <printer_vprintf+0x7fc>
            if (flags & FLAG_NEGATIVE) {
  100c70:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100c71:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100c75:	78 24                	js     100c9b <printer_vprintf+0x826>
  100c77:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100c7a:	83 e0 20             	and    $0x20,%eax
  100c7d:	85 c0                	test   %eax,%eax
  100c7f:	75 1a                	jne    100c9b <printer_vprintf+0x826>
            len = strnlen(data, precision);
  100c81:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100c84:	48 63 d0             	movslq %eax,%rdx
  100c87:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100c8b:	48 89 d6             	mov    %rdx,%rsi
  100c8e:	48 89 c7             	mov    %rax,%rdi
  100c91:	e8 91 f5 ff ff       	call   100227 <strnlen>
  100c96:	89 45 bc             	mov    %eax,-0x44(%rbp)
  100c99:	eb 0f                	jmp    100caa <printer_vprintf+0x835>
        } else {
            len = strlen(data);
  100c9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100c9f:	48 89 c7             	mov    %rax,%rdi
  100ca2:	e8 4b f5 ff ff       	call   1001f2 <strlen>
  100ca7:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100caa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cad:	83 e0 20             	and    $0x20,%eax
  100cb0:	85 c0                	test   %eax,%eax
  100cb2:	74 20                	je     100cd4 <printer_vprintf+0x85f>
  100cb4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100cb8:	78 1a                	js     100cd4 <printer_vprintf+0x85f>
            zeros = precision > len ? precision - len : 0;
  100cba:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100cbd:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  100cc0:	7e 08                	jle    100cca <printer_vprintf+0x855>
  100cc2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100cc5:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100cc8:	eb 05                	jmp    100ccf <printer_vprintf+0x85a>
  100cca:	b8 00 00 00 00       	mov    $0x0,%eax
  100ccf:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100cd2:	eb 5c                	jmp    100d30 <printer_vprintf+0x8bb>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100cd4:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100cd7:	83 e0 20             	and    $0x20,%eax
  100cda:	85 c0                	test   %eax,%eax
  100cdc:	74 4b                	je     100d29 <printer_vprintf+0x8b4>
  100cde:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ce1:	83 e0 02             	and    $0x2,%eax
  100ce4:	85 c0                	test   %eax,%eax
  100ce6:	74 41                	je     100d29 <printer_vprintf+0x8b4>
                   && !(flags & FLAG_LEFTJUSTIFY)
  100ce8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100ceb:	83 e0 04             	and    $0x4,%eax
  100cee:	85 c0                	test   %eax,%eax
  100cf0:	75 37                	jne    100d29 <printer_vprintf+0x8b4>
                   && len + (int) strlen(prefix) < width) {
  100cf2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100cf6:	48 89 c7             	mov    %rax,%rdi
  100cf9:	e8 f4 f4 ff ff       	call   1001f2 <strlen>
  100cfe:	89 c2                	mov    %eax,%edx
  100d00:	8b 45 bc             	mov    -0x44(%rbp),%eax
  100d03:	01 d0                	add    %edx,%eax
  100d05:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  100d08:	7e 1f                	jle    100d29 <printer_vprintf+0x8b4>
            zeros = width - len - strlen(prefix);
  100d0a:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100d0d:	2b 45 bc             	sub    -0x44(%rbp),%eax
  100d10:	89 c3                	mov    %eax,%ebx
  100d12:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d16:	48 89 c7             	mov    %rax,%rdi
  100d19:	e8 d4 f4 ff ff       	call   1001f2 <strlen>
  100d1e:	89 c2                	mov    %eax,%edx
  100d20:	89 d8                	mov    %ebx,%eax
  100d22:	29 d0                	sub    %edx,%eax
  100d24:	89 45 b8             	mov    %eax,-0x48(%rbp)
  100d27:	eb 07                	jmp    100d30 <printer_vprintf+0x8bb>
        } else {
            zeros = 0;
  100d29:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  100d30:	8b 55 bc             	mov    -0x44(%rbp),%edx
  100d33:	8b 45 b8             	mov    -0x48(%rbp),%eax
  100d36:	01 d0                	add    %edx,%eax
  100d38:	48 63 d8             	movslq %eax,%rbx
  100d3b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d3f:	48 89 c7             	mov    %rax,%rdi
  100d42:	e8 ab f4 ff ff       	call   1001f2 <strlen>
  100d47:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  100d4b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  100d4e:	29 d0                	sub    %edx,%eax
  100d50:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100d53:	eb 25                	jmp    100d7a <printer_vprintf+0x905>
            p->putc(p, ' ', color);
  100d55:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d5c:	48 8b 08             	mov    (%rax),%rcx
  100d5f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d65:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d6c:	be 20 00 00 00       	mov    $0x20,%esi
  100d71:	48 89 c7             	mov    %rax,%rdi
  100d74:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100d76:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100d7a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100d7d:	83 e0 04             	and    $0x4,%eax
  100d80:	85 c0                	test   %eax,%eax
  100d82:	75 36                	jne    100dba <printer_vprintf+0x945>
  100d84:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100d88:	7f cb                	jg     100d55 <printer_vprintf+0x8e0>
        }
        for (; *prefix; ++prefix) {
  100d8a:	eb 2e                	jmp    100dba <printer_vprintf+0x945>
            p->putc(p, *prefix, color);
  100d8c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d93:	4c 8b 00             	mov    (%rax),%r8
  100d96:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100d9a:	0f b6 00             	movzbl (%rax),%eax
  100d9d:	0f b6 c8             	movzbl %al,%ecx
  100da0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100da6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dad:	89 ce                	mov    %ecx,%esi
  100daf:	48 89 c7             	mov    %rax,%rdi
  100db2:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  100db5:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  100dba:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  100dbe:	0f b6 00             	movzbl (%rax),%eax
  100dc1:	84 c0                	test   %al,%al
  100dc3:	75 c7                	jne    100d8c <printer_vprintf+0x917>
        }
        for (; zeros > 0; --zeros) {
  100dc5:	eb 25                	jmp    100dec <printer_vprintf+0x977>
            p->putc(p, '0', color);
  100dc7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dce:	48 8b 08             	mov    (%rax),%rcx
  100dd1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100dd7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dde:	be 30 00 00 00       	mov    $0x30,%esi
  100de3:	48 89 c7             	mov    %rax,%rdi
  100de6:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  100de8:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  100dec:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  100df0:	7f d5                	jg     100dc7 <printer_vprintf+0x952>
        }
        for (; len > 0; ++data, --len) {
  100df2:	eb 32                	jmp    100e26 <printer_vprintf+0x9b1>
            p->putc(p, *data, color);
  100df4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100dfb:	4c 8b 00             	mov    (%rax),%r8
  100dfe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e02:	0f b6 00             	movzbl (%rax),%eax
  100e05:	0f b6 c8             	movzbl %al,%ecx
  100e08:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e0e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e15:	89 ce                	mov    %ecx,%esi
  100e17:	48 89 c7             	mov    %rax,%rdi
  100e1a:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  100e1d:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  100e22:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  100e26:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  100e2a:	7f c8                	jg     100df4 <printer_vprintf+0x97f>
        }
        for (; width > 0; --width) {
  100e2c:	eb 25                	jmp    100e53 <printer_vprintf+0x9de>
            p->putc(p, ' ', color);
  100e2e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e35:	48 8b 08             	mov    (%rax),%rcx
  100e38:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100e3e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100e45:	be 20 00 00 00       	mov    $0x20,%esi
  100e4a:	48 89 c7             	mov    %rax,%rdi
  100e4d:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  100e4f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  100e53:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  100e57:	7f d5                	jg     100e2e <printer_vprintf+0x9b9>
        }
    done: ;
  100e59:	90                   	nop
    for (; *format; ++format) {
  100e5a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100e61:	01 
  100e62:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e69:	0f b6 00             	movzbl (%rax),%eax
  100e6c:	84 c0                	test   %al,%al
  100e6e:	0f 85 31 f6 ff ff    	jne    1004a5 <printer_vprintf+0x30>
    }
}
  100e74:	90                   	nop
  100e75:	90                   	nop
  100e76:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100e7a:	c9                   	leave  
  100e7b:	c3                   	ret    

0000000000100e7c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100e7c:	f3 0f 1e fa          	endbr64 
  100e80:	55                   	push   %rbp
  100e81:	48 89 e5             	mov    %rsp,%rbp
  100e84:	48 83 ec 20          	sub    $0x20,%rsp
  100e88:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100e8c:	89 f0                	mov    %esi,%eax
  100e8e:	89 55 e0             	mov    %edx,-0x20(%rbp)
  100e91:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  100e94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100e98:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100e9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ea0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ea4:	48 8d 15 f5 80 fb ff 	lea    -0x47f0b(%rip),%rdx        # b8fa0 <console+0xfa0>
  100eab:	48 39 d0             	cmp    %rdx,%rax
  100eae:	72 0f                	jb     100ebf <console_putc+0x43>
        cp->cursor = console;
  100eb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100eb4:	48 8d 15 45 71 fb ff 	lea    -0x48ebb(%rip),%rdx        # b8000 <console>
  100ebb:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }
    if (c == '\n') {
  100ebf:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  100ec3:	0f 85 82 00 00 00    	jne    100f4b <console_putc+0xcf>
        int pos = (cp->cursor - console) % 80;
  100ec9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100ecd:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ed1:	48 8d 15 28 71 fb ff 	lea    -0x48ed8(%rip),%rdx        # b8000 <console>
  100ed8:	48 29 d0             	sub    %rdx,%rax
  100edb:	48 d1 f8             	sar    %rax
  100ede:	48 89 c1             	mov    %rax,%rcx
  100ee1:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100ee8:	66 66 66 
  100eeb:	48 89 c8             	mov    %rcx,%rax
  100eee:	48 f7 ea             	imul   %rdx
  100ef1:	48 89 d0             	mov    %rdx,%rax
  100ef4:	48 c1 f8 05          	sar    $0x5,%rax
  100ef8:	48 89 ce             	mov    %rcx,%rsi
  100efb:	48 c1 fe 3f          	sar    $0x3f,%rsi
  100eff:	48 29 f0             	sub    %rsi,%rax
  100f02:	48 89 c2             	mov    %rax,%rdx
  100f05:	48 89 d0             	mov    %rdx,%rax
  100f08:	48 c1 e0 02          	shl    $0x2,%rax
  100f0c:	48 01 d0             	add    %rdx,%rax
  100f0f:	48 c1 e0 04          	shl    $0x4,%rax
  100f13:	48 29 c1             	sub    %rax,%rcx
  100f16:	48 89 ca             	mov    %rcx,%rdx
  100f19:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  100f1c:	eb 25                	jmp    100f43 <console_putc+0xc7>
            *cp->cursor++ = ' ' | color;
  100f1e:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100f21:	83 c8 20             	or     $0x20,%eax
  100f24:	89 c6                	mov    %eax,%esi
  100f26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f2a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f2e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100f32:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100f36:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f3a:	89 f2                	mov    %esi,%edx
  100f3c:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  100f3f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  100f43:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  100f47:	75 d5                	jne    100f1e <console_putc+0xa2>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  100f49:	eb 24                	jmp    100f6f <console_putc+0xf3>
        *cp->cursor++ = c | color;
  100f4b:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  100f4f:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100f52:	89 d6                	mov    %edx,%esi
  100f54:	09 c6                	or     %eax,%esi
  100f56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100f5a:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f5e:	48 8d 48 02          	lea    0x2(%rax),%rcx
  100f62:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  100f66:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f6a:	89 f2                	mov    %esi,%edx
  100f6c:	66 89 10             	mov    %dx,(%rax)
}
  100f6f:	90                   	nop
  100f70:	c9                   	leave  
  100f71:	c3                   	ret    

0000000000100f72 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100f72:	f3 0f 1e fa          	endbr64 
  100f76:	55                   	push   %rbp
  100f77:	48 89 e5             	mov    %rsp,%rbp
  100f7a:	48 83 ec 30          	sub    $0x30,%rsp
  100f7e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  100f81:	89 75 e8             	mov    %esi,-0x18(%rbp)
  100f84:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100f88:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  100f8c:	48 8d 05 e9 fe ff ff 	lea    -0x117(%rip),%rax        # 100e7c <console_putc>
  100f93:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100f97:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  100f9b:	78 09                	js     100fa6 <console_vprintf+0x34>
  100f9d:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  100fa4:	7e 07                	jle    100fad <console_vprintf+0x3b>
        cpos = 0;
  100fa6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  100fad:	8b 45 ec             	mov    -0x14(%rbp),%eax
  100fb0:	48 98                	cltq   
  100fb2:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  100fb6:	48 8d 05 43 70 fb ff 	lea    -0x48fbd(%rip),%rax        # b8000 <console>
  100fbd:	48 01 d0             	add    %rdx,%rax
  100fc0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100fc4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  100fc8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100fcc:	8b 75 e8             	mov    -0x18(%rbp),%esi
  100fcf:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  100fd3:	48 89 c7             	mov    %rax,%rdi
  100fd6:	e8 9a f4 ff ff       	call   100475 <printer_vprintf>
    return cp.cursor - console;
  100fdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100fdf:	48 8d 15 1a 70 fb ff 	lea    -0x48fe6(%rip),%rdx        # b8000 <console>
  100fe6:	48 29 d0             	sub    %rdx,%rax
  100fe9:	48 d1 f8             	sar    %rax
}
  100fec:	c9                   	leave  
  100fed:	c3                   	ret    

0000000000100fee <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  100fee:	f3 0f 1e fa          	endbr64 
  100ff2:	55                   	push   %rbp
  100ff3:	48 89 e5             	mov    %rsp,%rbp
  100ff6:	48 83 ec 60          	sub    $0x60,%rsp
  100ffa:	89 7d ac             	mov    %edi,-0x54(%rbp)
  100ffd:	89 75 a8             	mov    %esi,-0x58(%rbp)
  101000:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  101004:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101008:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10100c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101010:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101017:	48 8d 45 10          	lea    0x10(%rbp),%rax
  10101b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10101f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101023:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101027:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  10102b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10102f:	8b 75 a8             	mov    -0x58(%rbp),%esi
  101032:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101035:	89 c7                	mov    %eax,%edi
  101037:	e8 36 ff ff ff       	call   100f72 <console_vprintf>
  10103c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10103f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  101042:	c9                   	leave  
  101043:	c3                   	ret    

0000000000101044 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  101044:	f3 0f 1e fa          	endbr64 
  101048:	55                   	push   %rbp
  101049:	48 89 e5             	mov    %rsp,%rbp
  10104c:	48 83 ec 20          	sub    $0x20,%rsp
  101050:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101054:	89 f0                	mov    %esi,%eax
  101056:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101059:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  10105c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101060:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101064:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101068:	48 8b 50 08          	mov    0x8(%rax),%rdx
  10106c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101070:	48 8b 40 10          	mov    0x10(%rax),%rax
  101074:	48 39 c2             	cmp    %rax,%rdx
  101077:	73 1a                	jae    101093 <string_putc+0x4f>
        *sp->s++ = c;
  101079:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10107d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101081:	48 8d 48 01          	lea    0x1(%rax),%rcx
  101085:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101089:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10108d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101091:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101093:	90                   	nop
  101094:	c9                   	leave  
  101095:	c3                   	ret    

0000000000101096 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  101096:	f3 0f 1e fa          	endbr64 
  10109a:	55                   	push   %rbp
  10109b:	48 89 e5             	mov    %rsp,%rbp
  10109e:	48 83 ec 40          	sub    $0x40,%rsp
  1010a2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  1010a6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  1010aa:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1010ae:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1010b2:	48 8d 05 8b ff ff ff 	lea    -0x75(%rip),%rax        # 101044 <string_putc>
  1010b9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    sp.s = s;
  1010bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1010c1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1010c5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1010ca:	74 33                	je     1010ff <vsnprintf+0x69>
        sp.end = s + size - 1;
  1010cc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1010d0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1010d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1010d8:	48 01 d0             	add    %rdx,%rax
  1010db:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1010df:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1010e3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1010e7:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1010eb:	be 00 00 00 00       	mov    $0x0,%esi
  1010f0:	48 89 c7             	mov    %rax,%rdi
  1010f3:	e8 7d f3 ff ff       	call   100475 <printer_vprintf>
        *sp.s = 0;
  1010f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1010fc:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1010ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101103:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  101107:	c9                   	leave  
  101108:	c3                   	ret    

0000000000101109 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  101109:	f3 0f 1e fa          	endbr64 
  10110d:	55                   	push   %rbp
  10110e:	48 89 e5             	mov    %rsp,%rbp
  101111:	48 83 ec 70          	sub    $0x70,%rsp
  101115:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101119:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  10111d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  101121:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101125:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101129:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10112d:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101134:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101138:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  10113c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  101140:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101144:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101148:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  10114c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  101150:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101154:	48 89 c7             	mov    %rax,%rdi
  101157:	e8 3a ff ff ff       	call   101096 <vsnprintf>
  10115c:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10115f:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  101162:	c9                   	leave  
  101163:	c3                   	ret    

0000000000101164 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101164:	f3 0f 1e fa          	endbr64 
  101168:	55                   	push   %rbp
  101169:	48 89 e5             	mov    %rsp,%rbp
  10116c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101170:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  101177:	eb 1a                	jmp    101193 <console_clear+0x2f>
        console[i] = ' ' | 0x0700;
  101179:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10117c:	48 98                	cltq   
  10117e:	48 8d 14 00          	lea    (%rax,%rax,1),%rdx
  101182:	48 8d 05 77 6e fb ff 	lea    -0x49189(%rip),%rax        # b8000 <console>
  101189:	66 c7 04 02 20 07    	movw   $0x720,(%rdx,%rax,1)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10118f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101193:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10119a:	7e dd                	jle    101179 <console_clear+0x15>
    }
    cursorpos = 0;
  10119c:	c7 05 56 7e fb ff 00 	movl   $0x0,-0x481aa(%rip)        # b8ffc <cursorpos>
  1011a3:	00 00 00 
}
  1011a6:	90                   	nop
  1011a7:	c9                   	leave  
  1011a8:	c3                   	ret    
