#!/usr/bin/env python
# coding: utf-8

# In[26]:


def fizzbuzz(x):
    res = ""
    if (x % 3 == 0):
        res += "Fizz"
    if (x % 5 == 0):
        res += "Buzz"
    return(res)

for i in range(1,101):
    if (fizzbuzz(i)):
        print(f"Fizzbuzz of {i}: {fizzbuzz(i)}")


# In[ ]:


import unittest

class TestFizzbuzz(unittest.TestCase):
    
    def test_fizzbuss1(self):
        self.assertEqual(fizzbuzz(75), "FizzBuzz")
        
    def test_fizz(self):
        self.assertEqual(fizzbuzz(99), "Fizz")
    
    def test_buzz(self):
        self.assertEqual(fizzbuzz(85), "Buzz")
        
unittest.main(argv=[''], verbosity=2, exit=False)


# In[18]:


def count_vowels(string):
    num_vowels=0
    str_low = string.lower()
    for char in string:
        if char in "aeiou":
           num_vowels += 1
    return num_vowels

print(f"Vowels in 'annnmemmmtlo': {count_vowels('annnmemmmtlo')}")
mystr = input("Enter string:")
print(f"Vowels in '{mystr}': {count_vowels(mystr)}")


# In[ ]:




