# APReF: Automatic Parallelizer of REcursive Functions

This is a source-to-source Haskell compiler that automatically identifies and rewrites recursive functions in a parallel form.

Optimizations implemented:
* Automatic parallelization
* Constant folding
* Reassociation of terms for commutative operations
* Symbolic simplification of scan operations

### References

[**Automatic Parallelization of Recursive Functions with Rewriting Rules**](https://doi.org/10.1016/j.scico.2018.01.004)  
Rodrigo C. O. Rocha, Luís F. W. Góes, Fernando M. Q. Pereira  
Journal of Science of Computer Programming, 2018

[An Algebraic Framework for Parallelizing Recurrence in Functional Programming](http://dx.doi.org/10.1007/978-3-319-45279-1_10)  
Rodrigo C. O. Rocha, Luís F. W. Góes, Fernando M. Q. Pereira  
SBLP 2016 - Brazilian Symposium on Programming Languages


### Example

Given the following sequential recursive function:
```
f :: Integer -> [Integer]
f 0 = []
f n = [n] ++ f(n-1) ++ [n]
```
the source-to-source compiler is able to rewrite it as in the following parallel version:
```
f_g_1 :: Integer -> [Integer]
f_g_1 i = [i]
f_g_2 :: Integer -> [Integer]
f_g_2 i = [i]
f :: Integer -> [Integer]
f 0 = []
f n = let k = n
      in (parFoldr (++) (map f_g_1 (reverse [1..k]))) ++ [] ++
         (parFoldr (++) (map f_g_2 [1..k]))
```

### Usage

By passing a Haskell file to the source-to-source compiler,
any parallelizable function will be rewritten in their parallel counterparts.
Auxiliary packages and functions will also be added.

```
python apref.py -f <haskell-file> --scan --constfold
```

The flag '--scan' enables a scan-based optimization.
Similarly, the '--constfold' enables a constant folding optimization.

