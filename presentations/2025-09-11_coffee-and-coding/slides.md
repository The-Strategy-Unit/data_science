---
marp: true
theme: default
paginate: true
author: Eirini, Rhian and YiWen
---

<!-- class: invert -->
<!-- fit -->

# Efficient Coding
## Principles and Practices for Performant Code

Eirini, Rhian & YiWen, DS @ SU

---

# Agenda

- **Measuring Performance**: Time and profile your code
- **Common Performance Tweaks**: Easy wins for faster code
- **Loops vs. Vectorisation vs. Functional**: Choose the right approach
- **Optimising Loops**: When you must use them
- **Beyond Basics**: Tools for serious optimisation

---

## Measuring Performance: Timing

```python
from timeit import timeit  # Python's precise timing module

# Function to measure
def my_function():
    return sum(i**2 for i in range(1000))  # Sum of squares

# Time the function execution
# number=1000: run 1000 times for statistical significance
# globals=globals(): access functions defined in current scope
execution_time = timeit('my_function()',
                       globals=globals(),
                       number=1000)

# Calculate and display average execution time per call
print(f"Average execution time: {execution_time/1000:.6f}s")
```

---

## Measuring Performance: Profiling (1)

```python
import cProfile, pstats, time
from pstats import SortKey

def sum_of_squares(n):
     return sum(i * i for i in range(n))

cProfile.run('sum_of_squares(1_000_000)')

# Display meaningful results
p = pstats.Stats('stats')
p.sort_stats(SortKey.CUMULATIVE).print_stats(5)
```

---


## Measuring Performance: Profiling (2)

```console
         1000006 function calls in 0.141 seconds

   Ordered by: standard name

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000    0.141    0.141 <stdin>:1(sum_of_squares)
  1000001    0.068    0.000    0.068    0.000 <stdin>:2(<genexpr>)
        1    0.000    0.000    0.141    0.141 <string>:1(<module>)
        1    0.000    0.000    0.141    0.141 {built-in method builtins.exec}
        1    0.073    0.073    0.141    0.141 {built-in method builtins.sum}
```

`ncalls`: The function was called directly 1 time but expanded to 1M total calls
`tottime`: sum_of_squares consumed 0.000 seconds in its own code
`cumtime`: Total time including nested calls was 0.141 seconds
Last column: The bottleneck is split between {built-in method builtins.sum} and the generator expression (`i * i for i in range(n)`)

The key insight: The overhead is split almost evenly between sum() and the generator expression when processing 1M items.

---

## Performance Tweak: String Concatenation

```python
from timeit import timeit  # Import timing functionality

# Fast - O(n) complexity with clear intent
def join_method():
    return "".join(str(i) for i in range(1000))  # Single efficient operation

# Slow - O(n²) complexity
def concat_method():
    result = ""
    for i in range(1000):
        result += str(i)  # Creates new string each time
    return result

t1 = timeit(join_method, number=1000)  # Time the fast method
t2 = timeit(concat_method, number=1000)  # Time the slow method
print(f"join: {t1:.6f}s\n+=: {t2:.6f}s")
```

---

## Performance Tweak: Appropriate Data Structures

```python
from timeit import timeit  # For timing the operations
import random  # To select a random lookup value

# Setup test data
data = list(range(10_000))  # A list with 10,000 items
lookup_val = random.choice(data)  # Random value to find
lookup_set = set(data)  # Same data as a set for O(1) lookup

# Time list lookup (O(n) - must check each element)
t1 = timeit(lambda: lookup_val in data, number=1000)

# Time set lookup (O(1) - constant time hash table)
t2 = timeit(lambda: lookup_val in lookup_set, number=1000)

print(f"List lookup: {t1:.6f}s\nSet lookup: {t2:.6f}s")
```

---

## Performance Tweak: Pre-allocating Arrays

```python
from timeit import timeit  # For timing operations
import numpy as np  # For pre-allocated arrays

size = 10_000  # Number of elements to process

# Growing a list dynamically (expensive resizing operations)
def growing_list():
    result = []  # Empty list that will grow
    for i in range(size):
        result.append(i*2)  # Potentially triggers resize
    return result

# Pre-allocated array (fixed size from beginning)
def preallocated_array():
    result = np.zeros(size)  # Create array of right size first
    for i in range(size):
        result[i] = i*2  # No resizing needed
    return result

t1 = timeit(growing_list, number=100)
t2 = timeit(preallocated_array, number=100)
print(f"Growing list: {t1:.6f}s\nPre-allocated: {t2:.6f}s")
```
<!-- Pre-allocated 2x slower? Wtf Python -->

---

## Loops vs. Vectorisation vs. Functional

| Approach | Best For | Example Use Case |
|---|---|---|
| **Loops** | Complex logic, small data | Custom algorithms |
| **Vectorisation** | Numerical operations | Data science, numpy |
| **Functional** | Data transformations | Pipelines, map/reduce |

---

## Loops

```python
from timeit import timeit  # For timing code execution

size = 1_000_000  # Number of elements to process

# Standard loop approach (explicit iteration)
def standard_loop():
    result = []
    for i in range(size):
        result.append(i * 2 + 5)  # Each operation done sequentially
    return result

def list_comprehension():
    return [i for i in range(size)]

t1 = timeit(standard_loop, number=1)
t2 = timeit(list_comprehension, number=1)

print(f"Standard loop: {t1:.6f}s\nList comprehension: {t2:.6f}s") # comprehension 2x faster
```
---

## Vectorisation with NumPy

```python
from timeit import timeit  # For timing code execution
import numpy as np  # NumPy for vectorised operations

size = 1_000_000  # Number of elements to process

# Pure Python approach (loops through each element)
def python_way():
    return [i * 2 + 5 for i in range(size)]

# NumPy vectorised approach (operates on entire array at once)
def numpy_way():
    return np.arange(size) * 2 + 5  # Uses C implementation

# Compare execution times
t1 = timeit(python_way, number=1)
t2 = timeit(numpy_way, number=1)

print(f"Python: {t1:.6f}s\nNumPy: {t2:.6f}s")  # NumPy 10x faster
```

---

## Vectorisation with Pandas

```python
import pandas as pd  # For DataFrame operations
import numpy as np   # For random data generation
from timeit import timeit  # For timing operations

# Create sample dataframe with 100,000 random values
df = pd.DataFrame({'value': np.random.rand(100_000)})

# Slow: Using apply (runs Python function on each row)
def apply_method():
    return df['value'].apply(lambda x: x * 2 + 5)

# Fast: Vectorised operations (C implementation)
def vector_method():
    return df['value'] * 2 + 5

# Compare execution times
t1 = timeit(apply_method, number=10)
t2 = timeit(vector_method, number=10)

print(f"apply: {t1:.6f}s\nvectorised: {t2:.6f}s") # Vectorised 100x faster
```

---

## Functional Programming

```python
from timeit import timeit

# Compare map vs list comprehension
t1 = timeit(lambda: list(map(lambda x: x**2, range(1000))), number=1000)
t2 = timeit(lambda: [x**2 for x in range(1000)], number=1000)

print(f"map: {t1:.6f}s\ncomprehension: {t2:.6f}s") # Comprehension 2x faster
```

---

## Loops vs. Vectorisation vs. Functional speed

| Approach | Time (sec) |
|---|---:|
| **Loops** | Standard loop: 0.049893 |
|           | comprehension: 0.027239 |
| **Vectorisation** | Python: 0.054816 |
|                   | NumPy: 0.002517 |
|                   | Pandas apply: 0.104524 |
|                   | Pandas vectorised: 0.001358 |
| **Functional** | map: 0.040885 |
|                | comprehension: 0.025535 |

---

## When to Use Each Approach

- **Vectorisation**: Large numerical datasets (NumPy/Pandas)
- **List Comprehensions**: Simple transformations on sequences
- **Generators**: Large datasets, memory efficiency
- **Functional**: Complex pipelines, data transformations
- **Loops**: Complex logic, small datasets, or when readability matters

---

## Loop Optimisation Techniques

```python
from timeit import timeit  # For timing execution
import math  # For sqrt function

# Create test data - objects with a 'value' attribute
data = [type('obj', (), {'value': i}) for i in range(10_000)]

# Regular approach: recalculating len() and looking up math.sqrt each time
def regular_loop():
    total = 0
    for i in range(len(data)):  # len() called every iteration
        total += math.sqrt(data[i].value)  # Function lookup each time
    return total

# Optimised approach: pre-compute length and bind function locally
def optimised_loop():
    total = 0
    n = len(data)  # Calculate length once
    sqrt = math.sqrt  # Local reference to function
    for i in range(n):
        total += sqrt(data[i].value)
    return total

t1 = timeit(regular_loop, number=10)
t2 = timeit(optimised_loop, number=10)
print(f"Regular: {t1:.6f}s\nOptimised: {t2:.6f}s")
```

---

## Best Practices Summary

1. **Measure first** - profile before optimising
2. **Use appropriate data structures** for the task
3. **Vectorise numerical operations** when possible
4. **Avoid premature optimisation** - readable code first
5. **Know when to use loops, comprehensions, or functional styles**
<!-- 6. **Use generators** for memory efficiency with large datasets -->
<!-- 7. **Consider specialised tools** for performance-critical code -->

---

# Appendix
## Beyond basics (nerdier stuff)

---

## Just-In-Time Compilation (1)

```python
from numba import jit  # Just-In-Time compiler for Python
import numpy as np  # For numerical operations
from timeit import timeit  # For timing

def slow_func(x): # Regular Python function (interpreted at runtime)
    total = 0
    for i in range(len(x)): total += np.sin(x[i]) * np.cos(x[i])
    return total

@jit(nopython=True) # Same function with JIT compilation (compiled to machine code)
def fast_func(x):
    total = 0
    for i in range(len(x)): total += np.sin(x[i]) * np.cos(x[i])
    return total

x = np.random.random(10_000)  # Random data to process
t1 = timeit(lambda: slow_func(x), number=10)
t2 = timeit(lambda: fast_func(x), number=10)
print(f"Python: {t1:.6f}s\nNumba: {t2:.6f}s")
```

---

## Just-In-Time Compilation (2)

> [JIT](https://en.wikipedia.org/wiki/Just-in-time_compilation) translates code into machine code at runtime to improve execution speed.
This approach can improve performance by optimising the execution of frequently run code segments

---

## Cython - Basic Example

```python
# Pure Python version (slow.py)
def calculate_sum(n):
    """Sum the squares from 0 to n-1"""
    total = 0
    for i in range(n):
        total += i * i
    return total

# Cython version (fast.pyx)
def calculate_sum_cy(int n):
    """Same function with static typing"""
    cdef int i, total = 0  # Static type declarations
    for i in range(n):
        total += i * i
    return total

# Compare (in Python):
from timeit import timeit
from slow import calculate_sum
from pyximport import install; install()  # Compile on import
from fast import calculate_sum_cy

t1 = timeit("calculate_sum(10_000)", globals=globals(), number=1000)
t2 = timeit("calculate_sum_cy(10_000)", globals=globals(), number=1000)
print(f"Python: {t1:.6f}s\nCython: {t2:.6f}s")  # Typically 20-100x faster
```

---

## Cython - Best Practices
```python
# Key techniques for maximum performance:
# 1. Declare types for all variables
cdef:
    int i, n = 1000  # Integer variables
    double x = 0.5   # Floating point
    int* ptr         # C pointer

# 2. Use typed memoryviews for arrays (faster than NumPy)
def process(double[:] arr):  # Works with any array-like object
    cdef int i
    for i in range(arr.shape[0]):
        arr[i] = arr[i] * 2  # Direct memory access

# 3. Move Python operations outside loops
cdef double total = 0
py_func = some_python_function  # Store reference outside loop
for i in range(n):
    # Call Python functions minimally inside loops
    total += c_only_operations(i)

# 4. Use nogil for parallel execution with OpenMP
cpdef process_parallel(double[:] data) nogil:  # No Python GIL
    # Can now use OpenMP for parallelism
```

## Compiling Cython Code
```python
# Option 1: Using setuptools (recommended for projects)
# Create setup.py in your project directory:
from setuptools import setup, Extension
from Cython.Build import cythonize

setup(
    ext_modules = cythonize([
        Extension("fast", ["fast.pyx"]),  # Module name, source file
    ])
)

# Then compile from command line:
# python setup.py build_ext --inplace

# Option 2: Quick development with pyximport
# In your Python script:
import pyximport
pyximport.install()  # Automatically compiles .pyx files
import fast  # Will compile fast.pyx on first import

# Option 3: Using Cython directly in terminal
# cython -a fast.pyx  # Generates fast.c and HTML report
# gcc -shared -fPIC -o fast.so fast.c \
#     $(python3-config --includes) $(python3-config --ldflags)
```
