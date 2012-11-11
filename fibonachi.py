#!/usr/bin/env python
import os

def fib(n):
    result = []
    first,  second = 0,  1
    while second < n:
        result.append(second)
	#first = second
        second = first + second
        first = second - first
    return result

if __name__ == "__main__":
	a = fib(100)
	print a
