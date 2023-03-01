# Introduction to Regular Expressions 

---

## Basic Matching 
---
---

## Alphanumerics

- At its most basic level, this regex matches specific alphanumeric characters. 

Example: 

`/s/` matches any character "`s`"

```ruby 
str = "cast"
print "matched 's'" if str.match(/s/)
print "matched 'x'" if str.match(/x/)

# => matched 's' 
``` 
---

## Special Characters 
- Regex can match non-alphanumeric characters but some have special meaning and require particular treatment. 

These characters are *meta-characters*

  `$ ^ * + ? . ( ) [ ] { } | \ /`

- If you want to match a meta-character, you must *escape* it with leading backslash `\`.

Example: 

- to match a `?` use the regex `/\?/`

Non meta characters such as `:` and empty space `' '` may be used without an escape. 

---
---

## Concatenation 
You can concatenate two or more patterns into a new pattern that matches each of the originals in the sequence. 

For example: 

`/cat/` consists of concatenation of the `c`, `a`, and `t` patterns and matches any string containing a `c` followed by an `a` followed by a `t`. 

-  The patterns we concatenated are simple; they each match a single, specific character.
- This fundamental idea is one of the more important concepts behind regex; patterns are the building blocks of regex, not characters or strings. You can construct complex regex by concatenating a series of patterns, and you can analyze a complex regex by breaking it down into its component patterns.

---
---

## Alternation 
Alternation is a simple way to construct a regex that matches one of several sub-patterns. 

- Most basic form is two or more patterns separated by pipe `|` characters, and then surrounding the entire expression in parentheses. 

Example: 

`/(cat|dog|rabbit)/` 

Even though the parentheses and pipe characters are meta-characters we do not have to escape them. We are not performing a literal match, but are instead using the "meta" meaning of those characters. 

- If we escaped them as in: 
  - `/\(cat\|dog\)/`
- This would perform a literal match of `(cat|dog)` instead of treating them as alternation operation. 

---
---

## Control Character Escapes 
Most modern computing languages use control character escapes in strings to represent characters that don't have a visual representation. For example, `\n`, `\r`, and `\t` are nearly universal ways to represent line feeds, carriage returns, and tabs, respectively. Both Ruby and JavaScript support these escapes, as do all regex engines. For example:

```ruby 
puts "has tab" if text.match(/\t/)

# prints `has tab` if `text` contains tab character. 
```

Note that not everything that looks like a control character escape is a genuine control character escape. For instance:

- `\s` and `\d` are special character classes (we'll cover these later)
- `\A` and `\z` are anchors (we'll cover these as well)
- `\x` and `\u` are special character code markers (we won't cover these)
- `\y` and `\q` have no special meaning at all

---
---

## Ignoring Case 

Regex are case sensitive by default. 

You can make case insensitive by appending an `i` after the closing `/` in the regex pattern. 

For example: 

`/launch/i`

- will match all three "launch" strings here:
```
I love Launch School!
LAUNCH SCHOOL! Gotta love it!
launchschool.com
```

---
---

## Exercises: 

1. Write a regex that matches an uppercase K. Test it with these strings:
```
Kx
BlacK
kelly
```

Answer: `/K/` or `/k/i` 

2. Write a regex that matches an uppercase or lowercase H. Test it with these strings:
```
Henry
perch
golf
```

Answer: `/h/i` or `/(h|H)/`

3. Write a regex that matches the string dragon. Test it with these strings:
```
snapdragon
bearded dragon
dragoon
```

Answer: `/dragon/`

4. Write a regex that matches any of the following fruits: banana, orange, apple, strawberry. The fruits may appear in other words. Test it with these strings:
```
banana
orange
pineapples
strawberry
raspberry
grappler
```

Answer: `/(banana|orange|apple|strawberry)/`

5. Write a regex that matches a comma or space. Test your regex with these strings:
```
This line has spaces
This,line,has,commas,
No-spaces-or-commas
```

Answer: `/( |,)/`

6. Challenge: Write a regex that matches blueberry or blackberry, but write berry precisely once. Test it with these strings:
```
blueberry
blackberry
black berry
strawberry
```

Answer: `/(blue|black)berry/`

---
---
---
---

# Character Classes 

Character classes are patterns that let you specify a set of characters that you want to match. 

---

## Sets of Characters 

- Character class patterns use a list of characters between square brackets. 
- Example: `/[abc]/`
- Pattern matches a single occurrence of any of the characters between the brackets.

Use cases: 

- input validation 
  - check if input is a number 1-5
    - `/[12345]/`
  - check if y/n answer 
    - `/[ynYN]/`
- check for upper/lower case letters if can't use `i`. 
  - `/[Hh]oover/` matches `Hoover` or `hoover` but not `HOOVER`.


It is good practice to group characters by type: 
  - digits 
  - uppercase characters 
  - lowercase characters 
  - whitespaces 
  - non-alphanumerics

### You can concatenate any patterns, including character classes. 
- `/[abc][12]/` matches any two characters where the first character is an `a`, `b`, or `c`, and the second is a `1` or `2`. 

#

## Meta-characters inside character class

These are meta-characters inside of character class: 

 `^`   `\`   `-`   `[`   `]`

 Some of these meta characters are only meta characters in certain situations. 

 For example: 

 - You can use `^` as a non-meta character if it is *NOT* the first character in a class. 
 - You can use `-` as a non-meta character if it *IS* the first character in a class.

---
---

## Range of Characters 

You can abbreviate ranges inside character classes by specifying the starting character, a hyphen (`-`) and the last character. 

- `/[a-z]/` matches any lowercase alphabetic character. 
- `/[j-p]/` matches any letter between `j` and `p`. 
- `/[0-9]/` matches any decimal digit

You can combine ranges as well: 

  - `/[0-9A-Fa-f]/` 
  
---

## Negated Classes

The negated class matches all characters not identified in the range. To create a negated class, the first character between the brackets should be a caret (`^`). 

Examples: 

- Negated class for one character 
  - `/[^y]/ ` matches any character other than `'y'`.
- Negate multiple characters 
  - `/[^aeiou]/` matches all characters except lowercase vowels. 

---
---
---

## Exercises: 

1. Write a regex that matches uppercase or lowercase Ks or a lowercase s. Test it with these strings:
```
Kitchen Kaboodle
Reds and blues
kitchen Servers
```

Answer: `/[Kks]/`


2. Write a regex that matches any of the strings cat, cot, cut, bat, bot, or but, regardless of case. Test it with this text:
```
My cats, Butterscotch and Pudding, like to
sleep on my cot with me, but they cut my sleep
short with acrobatics when breakfast time rolls
around. I need a robotic cat feeder.
```

Answer: `/[c|b](at|ot|ut)/` or `/[bc][aou]t/i`

3. Base 20 digits include the decimal digits 0 through 9, and the letters A through J in upper or lowercase. Write a regex that matches base 20 digits. Test it with these strings:
```
0xDEADBEEF
1234.5678
Jamaica
plow ahead
```

Answer: `/[0-9A-Ja-j]/`

4. Write a regex that matches any letter except x or X. Test it with these strings:
```
0x1234
Too many XXXXXXXXXXxxxxxxXXXXXXXXXXXX to count.
The quick brown fox jumps over the lazy dog
THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
```

Answer: `/[A-WYZa-wyz]/` 

5. Write a regex that matches any character that is not a letter. Test it with these strings:
```
0x1234abcd
1,000,000,000s and 1,000,000,000s.
THE quick BROWN fox JUMPS over THE lazy DOG!
```

Answer: `/[^a-zA-Z]/`