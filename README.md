## Num

In R, writing a large number is kinda clunky:

```R
40000000
```

What number is that? Do you have to count the zeros to know it is four million?

...What if I lied and it is actually 40 million?

R does support scientific notation:

```R
4e7
```

...but do we remember that is 40 million?

It would be easier if we could do this:

```R
40,000,000
```

or this:

```R
40M
```

...with Num, now we can!

```R
num::num("40,000,000")
[1] 4e+07

num::num("40M")
[1] 4e+07

num::num("40M") - num::num("4K")
[1] 39996000

num::num("36,524K") + num::num("4.681B")
[1] 4717524000
```

We support `K` for 1000; `M` for 1,000,000 (million); `B` for 1,000,000,000 (billion); and `T` for 1,000,000,000,000 (trillion).
