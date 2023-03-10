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

Answer: `/[^a-zA-Z]/` or `/^a-z/i` 

6. Are `/(ABC|abc)/` and `/[Aa][Bb][Cc]/` equivalent regex? If not, how do they differ? Can you provide an example of a string that would match one of these regex, but not the other?

Answer: 

`/(ABC|abc)/` will match any sequence of "abc" whether capital or lowercase 

  - will match "abcdef" or "ABCD" or "flabcars"
  - will not match "aBc" or "ABc" or "ab" 
  - we are not using character classes here, but alternation with concatenation

`/[Aa][Bb][Cc]/` will match any combination of "abc" regardless of case

  - will match "Abc" or "abC" or "aBC" 
  - will not match "flabec"
  - we are using character classes and concatenation. 


7. Are `/abc/i` and `/[Aa][Bb][Cc]/` equivalent regex? If not, how do they differ? Can you provide an example of a string that would match one of these regex, but not the other?


Answer: 

`/abc/i` will match any pattern of "abc" case insensitive 

`/[Aa][Bb][Cc]/` is equivalent. 

8. Challenge: write a regex that matches a string that looks like a simple negated character class range, e.g., '[^a-z]'. (Your answer should match precisely six characters. The match does not include the slash characters.) Test it with these strings:

```
The regex /[^a-z]/i matches any character that is
not a letter. Similarly, /[^0-9]/ matches any
non-digit while /[^A-Z]/ matches any character
that is not an uppercase letter. Beware: /[^+-<]/
is at best obscure, and may even be wrong.
```

Answer: 

/\[\^[a-zA-Z0-9]-[a-zA-Z0-9]\]/

The three matches are `[^a-z]`, `[^0-9]`, and `[^A-Z]`. Technically, the last regex string in our sample text, `[^+-<]`, is a valid regex; there is nothing illegal about character class ranges that don't use alphanumeric starting and ending points. However, you should avoid such ranges; think of them as invalid.

---
---
---
---

# Character Class Shortcuts 

Shortcuts for commonly used character classes. 

## Any Character 

- The most commonly used. 
- matches any character 
  - alphanumeric
  - punctuation 
  - whitespace 
  - control character 
  - etc...

Uses the period (`.`) meta character.  
  - Should not be inside square brackets unless its a literal `.` 


## Whitespace 

- `/\s/` matches whitespace characters 
  - equivalent to `/[ \t\v\r\n\f]/` 
  - space `' '` 
  - tab `\t`
  - vertical tab `\v`
  - carriage return `\r`
  - line feed `\n` 
  - form feed `\f` 

- `/\S/` matches non-whitespace characters 
  - equivalent to `/[^ \t\v\r\n\f]/`

Example: 

```ruby 
puts 'matched 1' if 'Four score'.match(/\s/)
puts 'matched 2' if "Four\tscore".match(/\s/)
puts 'matched 3' if "Four-score\n".match(/\s/)
puts 'matched 4' if "Four-score".match(/\s/)
```

The first three examples in each group all print a matched message because the given string contains a whitespace character; the last in each group outputs nothing since "Four-score" doesn't include whitespace.


```ruby 
puts 'matched 1' if 'a b'.match(/\S/)
puts 'matched 2' if " \t\n\r\f\v".match(/\S/)
```

prints matched 1 since /\S/ matches each of the letters in 'a b', but does not print anything for the second match since all of the characters in the string are whitespace characters.

You can use `\s` and `\S` both in and out of square brackets. Outside square brackets, e.g., `/\s/`, it stands for one of the whitespace characters. Inside square brackets, e.g., `/[a-z\s]/`, they represent an alternative to the other members of the class. Here, for instance, it represents any lowercase alphabetic character or any whitespace character.

- This matches any lower case letter "a-z" immediately before a whitespace character.
  - `/[a-z]\s` 
- This matches any lower case letter "a-z" NOT immediately before a whitespace character
  - `/[a-z]\S` 

---
---

## Digits and Hex Digits 

Decimal Digits 
  - 0-9 

Hexadecimal Digits 
  - 0-9 
  - A-F
  - a-f 

Shortcuts 
  - `\d` matches any decimal digit (0-9)
  - `\D` any character except a decimal digit 
  - `\h` any hexadecimal digit (0-9, A-F, a-f) (Ruby)
  - `\H` any non-hex digit (Ruby)


---
---

## Word Characters 

Match word characters: `/\w/` 
  - including: 
    - All alphabetic characters 
    - All decimal digits 
    - An underscore (`_`)

Matches all non-word characters 
  - `/\W/`

Can be used in or outside of square brackets. 

---
---

## Exercises 

1. Write a regex that matches any sequence of three characters delimited by whitespace characters (the regex should match both the delimiting whitespace and the sequence of 3 characters). Test it with these strings:

```
reds and blues
the lazy cat sleeps
```

Answer: `/\s...\s/`

This matches pattern: whitespace, three characters, whitespace 


2. Test the pattern /\s...\s/ from the previous exercise against this text:

```
Doc in a big red box.
Hup! 2 3 4
```
Observe that one of the three-letter words in this text match the pattern; it also matches 2 3. Why is it that this pattern doesn't include the three-letter words Doc, red, box, or Hup, but it does match 2 3?


Answer: 
Note that in all of these cases, the "match" is five characters long:
  - Doc doesn't match since Doc doesn't follow any whitespace. 
  - big matches since it is three characters with both leading and trailing whitespace. 
  - red doesn't match since the regex engine consumes the space character that precedes red when it matches big (note the trailing space). Once consumed as part of a match, the character is no longer available for subsequent matches. 
  - box doesn't match since a period follows it. 
  - Hup doesn't match since an exclamation point follows it. 
  - 2 3 matches since 2 3 is three characters long and it has both leading and trailing whitespace. space 2 space 3 space == 5 character pattern

  ## The big point here is: 
  the regex engine consumes the space character that precedes red when it matches big (note the trailing space). Once consumed as part of a match, the character is no longer available for subsequent matches. 


3. Write a regex that matches any four digit hexadecimal number that is both preceded and followed by whitespace. Note that 0x1234 is not a hexadecimal number in this exercise: there is no space before the number 1234.

```
Hello 4567 bye CDEF - cdef
0x1234 0x5678 0xABCD
1F8A done
```

Answer: 

`/\s\h\h\h\h\s/` 

The matches are 4567, CDEF, cdef, and 1F8A


4. Write a regex that matches any sequence of three letters. Test it with these strings:

```
The red d0g chases the b1ack cat.
a_b c_d
```

Answer: 

`/[a-z][a-z][a-z]/i`

---
---
---
---

# Anchors 

Anchors provide a way to limit how a regex matches a particular string by telling the regex engine where matches can begin and where they can end.


## Start or End of line 

- The `^` is an anchor that fix a regex match to the beginning of a line of text. 
- The `$` is an anchor that fix a regex match to the end of a line of text. 

Examples: 

The regex `/^cat/` matches the "cat" characters in the first two words of this text: 

```
cat
catastrophe
wildcat
I love my cat
<cat>
```

Matches `cat` on line 1 and `cat` in `catastrophe` on line 2. 

The `^` forces the pattern to match the beginning of each line.


The regex `/cat$/` matches: 

`cat` on line 1
`cat` as end of `wildcat` on line 3
`cat` at end of line 4. 


The two can be combined to `^cat$` 

Matches `cat` on line 1 only. Begins and ends with same pattern. 


## Lines vs Strings

The subtlety in `^` and `$` arises when the string you are attempting to match contains one or more newline characters that are not the last character in the string. 

Example: 

```ruby 
TEXT1 = "red fish\nblue fish"
puts "matched red" if TEXT1.match(/^red/)
puts "matched blue" if TEXT1.match(/^blue/)
```
Both `matched red` and `matched blue` since **`^` anchors the regex to the beginning of each line in the string, not the beginning of the string**.

```ruby 
TEXT2 = "red fish\nred shirt"
puts "matched fish" if TEXT2.match(/fish$/)
puts "matched shirt" if TEXT2.match(/shirt$/)
```
As before, we get a match for both regex. Note in particular that even though the first line in the string ends with a \n, fish is still said to occur at the end of the line. $ doesn't care if there is a \n character at the end, provided there is no more than one.



## Start/End of String 

More often you must match at the beginning or end of a string, not the line. 

These matches use: 

  - `\A` : matches the beginning of the string
  - `\Z` : matches up to, but not including the newline at end of string
  - `\z` : always matches end of string. 

Use `\z` unless determine to need `\Z`. 

Example: 

```ruby 
TEXT3 = "red fish\nblue fish"
TEXT4 = "red fish\nred shirt"
puts "matched red" if TEXT3.match(/\Ared/)
puts "matched blue" if TEXT3.match(/\Ablue/)
puts "matched fish" if TEXT4.match(/fish\z/)
puts "matched shirt" if TEXT4.match(/shirt\z/)
```
In contrast to the examples in the previous subsection, this prints matched red and matched shirt.


## Word Boundaries 

`\b` and `\B` 

Matches word boundaries and non-word boundaries. 

Words are sequences of word characters (`\w`) while non-words are sequences of non-word characters (`\W`). 

A word boundary occurs: 
  - between any pair of characters, one of which is a word character and one is not
  - at the beginning of a string if the first char is a word char 
  - at the end of a string if the last char is a word char 

A non-word boundary occurs: 
  - between any pair of characters, both of which are word chars or both of which are non-word chars. 
  - at the beginning of a string if the first char is a non-word char 
  - at the end of a string if the last char is a non-word char 


Examples: 

```ruby 
Eat some food.
```

In this case, word boundaries occur: 
  - before the `E`, `s` and `f`
  - after the `t`, `e`, and `d` at the end of words 

Non-word boundaries occur between the `o` and `m` in `some` and after the `.` at the end of the sentence. 


Another example: 

Match 3 letter words consisting of word characters: 

  `/\b\w\w\w\b/` : word-boundary, word-char, word-char, word-char, word-boundary 

```
One fish,
Two fish,
Red fish,
Blue fish.
123 456 7890
```

Matches: One, Two, Red, 123, 456


It's rare that you must use the non-word boundary anchor, `\B`. Here's a somewhat contrived example you can try. Try the regex `/\Bjohn/i` against these strings:

Pattern: non-word boundary, john (case insensitive)

```
John Silver   # no match 
Randy Johnson # no match 
Duke Pettijohn # match john in Pettijohn 
Joe_Johnson    # match John in Johnson b/c `_` is a word char so non-word boundary
```

  The regex matches john in the last two strings, but not the first two.

### `\b` and `\B` do not work as word boundaries inside of character classes (between square brackets). In fact, `\b` means something else entirely when inside square brackets: it matches a backspace character.

---
---

## Exercises 

1. Write a regex that matches the word `The` when it occurs at the beginning of a line. Test it with these strings:

```
The lazy cat sleeps.
The number 623 is not a word.
Then, we went to the movies.
Ah. The bus has arrived.
```

Answer: `/^The\b/`

pattern: beginning of line match `The` and word-boundary. 

matches: "The" on line 1 and line 2 only. does not match line 3 because non-word boundary before `n` in `Then`. 


2. Write a regex that matches the word cat when it occurs at the end of a line. Test it with these strings:

```
The lazy cat sleeps
The number 623 is not a cat
The Alaskan drives a snowcat
```

Answer: `/\bcat$` or `/\bcat\z/`


3. Write a regex that matches any three-letter word; a word is any string comprised entirely of letters. You can use these test strings.

```
reds and blues
The lazy cat sleeps.
The number 623 is not a word. Or is it?
```

Answer: `/\b[a-z][a-z][a-z]\b/i`


4. Challenge: Write a regex that matches an entire line of text that consists of exactly 3 words as follows:

    - The first word is `A` or `The`.
    - There is a single space between the first and second words.
    - The second word is any 4-letter word.
    - There is a single space between the second and third words.
    - The third word -- the last word -- is either `dog` or `cat`.

Test your solution with these strings:

```
A grey cat
A blue caterpillar
The lazy dog
The white cat
A loud dog
--A loud dog
Go away dog
The ugly rat
The lazy, loud dog
```

Answer: `/^(A|The) [A-Za-z][A-Za-z][A-Za-z][A-Za-z] (dog|cat)$/`

As with the other exercises, a proper Ruby solution would use \A and \z instead of ^ and $, but to allow for Rubular limitations, we use ^ and $ instead.

---
---
---
---


# Quantifiers 

## Zero or More 

Most commonly used quantifier is `*` that matches zero or more occurrences of the pattern to its left. 

Example: `/\b\d\d\d\d*\b/`

This example matches:

  - Three consecutive digits beginning at a word boundary, followed by any number of digits (0 - infinity), and then another word boundary.

This regex is read as six sub-patterns: 
  - `\b` : starting at a word boundary 
  - `\d` : a single digit followed by..
  - `\d` : a single digit followed by.. 
  - `\d` : a single digit followed by..
  - `\d*` : zero or more additional digits
  - `\b` : ending in a word boundary 

```
Four and 20 black birds
365 days in a year, 100 years in a century.
My phone number is 222-555-1212.
My serial number is 345678912.
```
You should see that this pattern matches 365, 100, 222, 555, 1212, and 345678912, but it does not match 20.

### One thing to watch out for is that "zero or more" truly means zero or more. The regex /x*/ matches every string, even an empty string, or a string that contains no xs anywhere. If you try this pattern in Rubular, it matches between every character.
---



When talking about regular expressions that match zero-length strings, imagine an arrow that starts out pointing to the beginning of the string, prior to the first character. When the regex engine goes to work, it moves this imaginary arrow to the right one character at a time until it either finds a match or determines that there is no match. The arrow never points directly at a character, but always points between each pair of characters, and matches typically occur against the character to the right of the arrow. (There are a few exceptions that match the character to the left as well, such as \b.)

When you try to match /x/ for instance, the regex engine looks to the character to the right of the arrow position. If it sees an x, it matches. Otherwise, it advances the arrow one position to the right, and again tries to match starting with the next character.

This is why something like /x*/ matches wherever in the string you're at - with the arrow pointing between characters, the regex is free to say "Nope. There are no x's between me and the next character, so it's a match."


---

Another way to see this is to try the regex `/co*t/` against these strings:

```
ct
cot
coot
cooot
```

`/co*t/` : pattern is: 
  - lowercase `c` followed by zero or more `o` characters followed by a lowercase `t`. 

This regex would match all four words above. 


---

### Note that the quantifier always applies to one pattern; the pattern it finds to the left of the quantifier. If necessary, you can use grouping parentheses to define the pattern to which you want to apply the `*`. For instance, try `/1(234)*5/` against:


```
15
12345
12342342345
1234235
```

`/1(234)*5/` : pattern is: 
  - number 1 followed by...
  - zero or more occurrences of 234 followed by..
  - number 5

In the example above, the regex would match: 
  - Line 1: `15`
  - Line 2: `12345`
  - Line 3 : `12342342345`
  Not line 4. 

---

## One or More 

The `+` quantifier is nearly identical to the `*` quantifier but matches *one or more* occurrences, rather than *zero or more*. 

Example: 

In the previous section, we wanted to match 3 or more digits using: 
 - `/\b\d\d\d\d*\b/`

If this is updated to utilize the `+` quanitifier, we would have to remove one of the `\d` patterns, because `\d+` matches one or more, rather than zero or more digits.

This would match sequence of four or more digits: 
  - `/\b\d\d\d\d+\b`

This matches three or more digits: 
  - `/\b\d\d\d+\b`
    - pattern, word boundary, digit, digit, one or more digits, word boundary.  

We saw earlier that a regex like /x*/ matches any string because it matches between every character. There is no similar subtlety to the + quantifier; /x+/ matches any sequence of one or more xs; it never matches the empty string between characters. Try it:

```
a single x matches.
As is a string of xxxxx like that.
```
 Matches only `x`'s



## Zero or One 

To match a pattern that occurs once or not at all use `?` quantifier 

Example: 

  - To test whether a string contains the words `cot` or `coot`. 

    - `/coo?t/` 

  - This matches a `c`, followed by an `o` followed by an optional `o`, followed by a `t`. 


Another Example: 

To match a date that may contain `-` separator characters. Date may be in `20180111` format or `2018-01-11`.

  - `\b\d\d\d\d-?\d\d-?\d\d\b`
    - word boundary followed by
    - digit followed by
    - digit followed by
    - digit followed by
    - digit followed by 
    - optional `-` followed by 
    - digit followed by
    - digit followed by 
    - optional `-` followed by
    - digit followed by
    - digit followed by 
    - word boundary.

  This would match: 
  ```
  20170111
  2017-01-11
  2017-0111
  201701-11
  ```

  But would not match `2018/01/11` 

---

## Ranges

The `*`, `+`, and `?` quantifiers match a repeated sequence, however you may need to specify the repeat count more precisely. 

Examples: 
  - Test phone number to see if exactly 10 digits 
  - Match all words with at least seven characters 
  - Match all words that are 5-8 characters long. 

The range quantifier is a pair of curly braces `{}`, with one or two numbers and an optional comma between the braces. 
  - `p{m}` matches precisely m occurrences of the pattern `p`. 
  - `p{m,}` matches `m` or more occurrences of `p`. 
  - `p{m,n}` matches `m` or more occurrences of `p` but not more than `n`.


Example: 

Test whether a string contains precisely 10 digits.

  - `/\b\d{10}\b/`

  Matches first two of these strings, not last two. 

  ```
  2225551212 1234567890 123456789 12345678900
  ```

Match numbers that are at least three digits in length:

  - `/b\d{3,}\b/`
    - word boundary followed by 
    - three or more digits followed by 
    - word boundary


Match words of 5-8 letters 

  - `\b[a-z]{5,8}\b/i` 

  ```
  Bizarre
  a
  one two three four five six seven eight nine
  sensitive
  dropouts
  ```
This pattern matches Bizarre, three, seven, eight, and dropouts.

---

## Greediness 

The quantifiers discussed so far are *greedy* meaning that they always match the longest possible string they can. 

To match the fewest number of characters possible, we call this *lazy* match. 

  - You can request lazy match by adding a `?` after the main quantifier. 

Example: 

  `/a[abc]*?c/` 

  - matches `abc` and `ac` in `xabcbcbacy`.

---
---
---
---

## Exercises: 

1. Write a regex that matches any word that begins with b and ends with an e, and has any number of letters in-between. You may limit your regex to lowercase letters. Test it with these strings.

```
To be or not to be
Be a busy bee
I brake for animals.
```

Answer: 

`/\bb[a-z]*e\b/`

This regex should match the words `be` (both instances), `bee`, and `brake`.


2. Write a regex that matches any line of text that ends with a ?. Test it with these strings.

```
What's up, doc?
Say what? No way.
?
Who? What? Where? When? How?
```

Answer: 

`/^.*\?$/`
  - start of string is any number of characters
  - escape `?` for literal `?`
  - `$` indicates end of line 
  -  Note the use of `.*`; you'll see this often in regex. It matches any sequence of characters, but, by default, does not match a newline character. 
    - It's how you ignore everything between two points when matching.


3. Write a regex that matches any line of text that ends with a ?, but does not match a line that consists entirely of a single ?. Test it with the strings from the previous exercise.

There should be two matches.


Answer: 

`/^.+\?$/`

  - The `.+` pattern makes the regex match at least one character before it attempts to match the `?`.


4. Write a regex that matches any line of text that contains nothing but a URL. For this exercise, a URL begins with http:// or https://, and continues until it detects a whitespace character or end of line. Test your regex with these strings:

```
http://launchschool.com/
https://mail.google.com/mail/u/0/#inbox
htpps://example.com
Go to http://launchschool.com/
https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello
http://launchschool.com/
```


Answer: 

`/^https*:\/\/\S*$/`

  - anchor to start of line
  - `http` part of URL followed by
  - optional `s` (zero or more)
  - :// 
  - `S` matches string of non-whitespace characters
  - Explicit line anchor `$` to prevent matching URL that is not end of line


5. Modify your regex from the previous exercise so the URL can have optional leading or trailing whitespace, but is otherwise on a line by itself. To test your regex with trailing whitespace, you must add some spaces to the end of some lines in your sample text.


Answer: 

`/^\s*https?:\/\/\S*\s*$/`


6. Modify your regex from the previous exercise so the URL can appear anywhere on each line, so long as it begins at a word boundary.


Answer: 

`/\bhttps?:\/\/\S*/`


7. Write a regex that matches any word that contains at least three occurrences of the letter i. Test your regex against these strings:

There should be three matches.

```
Mississippi
ziti 0minimize7
inviting illegal iridium
```

Answer: 

`/\b([a-z]*i){3}[a-z]*\b/i`

It uses the {3} quantifier to perform the 3-occurrences part of the match. The quantifier applies to `([a-z]*i)` which, uses grouping parentheses to treat `[a-z]*i` as a single pattern for use by `{3}`.



8. Write a regex that matches the last word in each line of text. For this exercise, assume that words are any sequence of non-whitespace characters. Test your regex against these strings:

```
What's up, doc?
I tawt I taw a putty tat!
Thufferin' thuccotath!
Oh my darling, Clementine!
Camptown ladies sing this song, doo dah.
```

Answer: 

`/\S+$/`

match `doc?`, `tat!`, `thuccotath!`, `Clementine!`, and `dah`.


9. Write a regex that matches lines of text that contain at least 3, but no more than 6, consecutive comma separated numbers. You may assume that every number on each line is both preceded by and followed by a comma. Test your regex against these strings:

```
,123,456,789,123,345,
,123,456,,789,123,
,23,56,7,
,13,45,78,23,45,34,
,13,45,78,23,45,34,56,
```

Answer: 

`/^,(\d+,){3,6}$/`

matches the first, third, and fourth lines


10. Write a regex that matches lines of text that contain at least 3, but no more than 6, consecutive comma separated numbers. In this exercise, you can assume that the first number on each line is not preceded by a comma, and the last number is not followed by a comma. Test your regex against these strings:

```
123,456,789,123,345
123,456,,789,123
23,56,7
13,45,78,23,45,34
13,45,78,23,45,34,56
```


Answer: 

`^(/d+,){2,5}\d+$/`

Your solution should match the first, third, and fourth lines. In this case, the lack of a comma at each end of the strings complicates our solution slightly - we can't check for 3-6 occurrences of `\d+,`, but have to check for 2-5 occurrences followed by a final `\d+` pattern.


11. Challenge: Write a regex that matches lines of text that contain either 3 comma separated numbers or 6 or more comma separated numbers. Test your regex against these strings:

```
123,456,789,123,345
123,456,,789,123
23,56,7
13,45,78,23,45,34
13,45,78,23,45,34,56
```


Answer: 
`/(^(\d+,){2}\d+$|^(\d+,){5,}\d+$)/`

In a real program, you may instead choose to use two separate regex:

```ruby 
if text.match(/^(\d+,){2}\d+$/) || text.match(/^(\d+,){5,}\d+$/)
```


12. Write a regex that matches HTML h1 header tags, e.g.,

```html 
<h1>Main Heading</h1>
<h1>Another Main Heading</h1>
<h1>ABC</h1> <p>Paragraph</p> <h1>DEF</h1><p>Done</p>
```

and the content between the opening and closing tags. If multiple header tags appear on one line, your regex should match the opening and closing tags and the text content of the headers, but nothing else. You may assume that there are no nested tags in the text between <h1> and </h1>.


Answer: 

`/<h1>.*?<\/h1>/`

----
----
----
----

# Using Regex in Ruby 

---

## `String#match` 
  - Returns a value that indicates whether a match occurred and what substrings matched.
  - The return value is "truthy" and can be tested in conditional expression. 
  - The return value is a `MatchData` object that responds to `[0]`, `[1]`, etc. 
    - Cannot apply most `Array` methods to this object directly

  ```ruby 
  fetch_url(text) if text.match(/\Ahttps?:\/\/\S+\z/)
  ```

  ### `=~`
  
  ```ruby 
  fetch_url(text) if text =~ /\Ahttps?:\/\/\S+\z/
  ```

  - This code returns the index within the string at which the regex is matched or `nil`, if no match. 
    - `=~` is faster than `match` 

---



## `String#scan` 

  - Global form of `match` returns an Array of all matching substrings. 

---

## `String#split` 

  - Frequently used with simple string as a delimiter.

  ```ruby 
  record = "xyzzy\t3456\t334\tabc"
  fields = record.split("\t")
  # -> ['xyzzy', '3456', '334', 'abc']
  ```
`split` returns an Array that contains the values from each of the split fields.


- You may encounter data where arbitrary whitespace characters separate fields, and there may be more than one whitespace character between each pair of items. The regex form of split comes in handy in such cases:

```ruby 
record = "xyzzy  3456  \t  334\t\t\tabc"
fields = record.split(/\s+/)
# -> ['xyzzy', '3456', '334', 'abc']
```

---

## Capture Groups: A Diversion 

  - Capture groups capture the matching characters that correspond to part of a regex.
    - You can use these matches later in the same regex, and when constructing new values based on the matched string. 

  Example: 

  Need to match quoted strings inside some text where either single or double quotes delimit strings. 

  `/(['"]).+?\1/`

  Here the group captures the part of the string that matches the pattern between parentheses; in this case, either a single or double quote. We then match one or more of any other character and end with a \1: we call this sequence a backreference - it references the first capture group in the regex. If the first group matches a double quote, then `\1` matches a double quote, but not a single quote.

  - It may be more reasonable to use two regex to solve this problem:
  ```ruby 
  if text.match(/".*?"/) || text.match(/'.*?'/)
    puts "Got a quoted string"
  end
  ```

  ### A regex may contain multiple capture groups, from left to right (1-9).

---


## Transformations 

  - Transforming a string with regex involves matching that string against the regex, and using the results to construct a new value. 

  In Ruby we typically use, `String#sub` and `String#gsub`. 
    - `#sub` transforms the first part of a string that matches a regex
    - `#gsub` transforms every part of a string that matches. 


Example: 

```ruby 
text = 'Four score and seven'
vowelless = text.gsub(/[aeiou]/, '*')
# -> 'F**r sc*r* *nd s*v*n'
```
Here we replace every vowel in `text` with an `*`.

---

We can use backreferences in the replacement string (second argument):
```ruby 
text = %(We read "War of the Worlds".)
puts text.sub(/(['"]).+\1/, '\1The Time Machine\1')
# prints: We read "The Time Machine".
```
One thing to note here is that if you double quote the replacement string, you need to double up on the backslashes:

```ruby 
puts text.sub(/(['"]).+\1/, "\\1The Time Machine\\1")
```

---
---
---
---

## Exercises

1. Write a method that returns true if its argument looks like a URL, false if it does not.

```ruby 
url?('http://launchschool.com')   # -> true
url?('https://example.com')       # -> true
url?('https://example.com hello') # -> false
url?('   https://example.com')    # -> false
```

Answer: 

```ruby 
def url?(text)
  return true if text.match(/\Ahttps?:\/\/\S+\z/)
  false
end 

# or 

def url?(text)
  text.match?(/\Ahttps?:\/\/\S+\z/)
end 
```


2. Write a method that returns all of the fields in a haphazardly formatted string. A variety of spaces, tabs, and commas separate the fields, with possibly multiple occurrences of each delimiter.

```ruby 
fields("Pete,201,Student")
# -> ["Pete", "201", "Student"]

fields("Pete \t 201    ,  TA")
# -> ["Pete", "201", "TA"]

fields("Pete \t 201")
# -> ["Pete", "201"]

fields("Pete \n 201")
# -> ["Pete", "\n", "201"]
```


Answer: 
```ruby 
def fields(text)
  text.split(/[, \t]+/)
end
```


3. Write a method that changes the first arithmetic operator `(+, -, *, /)` in a string to a `'?'` and returns the resulting string. Don't modify the original string.

```ruby 
mystery_math('4 + 3 - 5 = 2')
# -> '4 ? 3 - 5 = 2'

mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# -> '(4 ? 3 + 2) / 7 - 1 = 1'
```

Answer: 

```ruby 
def mystery_math(str)
  str.sub(/[+\-*\/]/, "?")
end 
```


4. Write a method that changes every arithmetic operator (+, -, *, /) to a '?' and returns the resulting string. Don't modify the original string.

```ruby
mysterious_math('4 + 3 - 5 = 2')           # -> '4 ? 3 ? 5 = 2'
mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') # -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'
```

Answer: 

```ruby 
def mysterious_math(str)
  str.gsub(/[+\-*\/]/, '?')
end 
```


5. Write a method that changes the first occurrence of the word `apple`, `blueberry`, or `cherry` in a string to `danish`.

```ruby 
danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

danish('The cherry of my eye')
# -> 'The danish of my eye'

danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

danish('I love pineapple')
# -> 'I love pineapple'
```

Answer: 

```ruby 
def danish(str)
  str.sub(/\b(apple|blueberry|cherry)\b/, "danish")
end
```


6. Challenge: write a method that changes strings in the date format 2016-06-17 to the format 17.06.2016. You must use a regular expression and should use methods described in this section.


```ruby 
format_date('2016-06-17') # -> '17.06.2016'
format_date('2016/06/17') # -> '2016/06/17' (no change)
```

Answer: 

```ruby 
def format_date(date)
  date.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1')
end 
```

We use three capture groups here to capture the year, month, and date, then use them in the replacement string in reverse order, this time separated by periods instead of hyphens.


7. Challenge: write a method that changes dates in the format `2016-06-17` or `2016/06/17` to the format `17.06.2016`. You must use a regular expression and should use methods described in this section.

```ruby 
format_date('2016-06-17') # -> '17.06.2016'
format_date('2017/05/03') # -> '03.05.2017'
format_date('2015/01-31') # -> '2015/01-31' (no change)
```

Answer: 

```ruby 
def format_date(date)
  date.sub(/\A(\d\d\d\d)([\-\/])(\d\d)\2(\d\d)\z/, '\4.\3.\1')
end
```

---
---
---
---