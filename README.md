multicore-sieve
=======================

Ejemplo de código multicore con Grand Central Dispatch.

* sievesingle.m es un programa en C sin multicore

* sievemultip.m es el mismo programa, donde se paraleliza:
    * el poner en 1 el arreglo
    * marcar en 0 los primos
    * sumar los primos 

Notar que en ninguna parte se especifica la cantidad de cores.

Ejecución
---------

    $ cd src
    $ make test
    time ./sievesingle 1000000000
    total primos: 50847534
          198.70 real       196.43 user         2.25 sys

    time ./sievemultip 1000000000
    total primos: 50847534
          130.46 real       494.08 user         5.00 sys


Resultados
----------

![](http://github.com/aldrinmartoq/multicore-sieve/raw/master/results/sievesingle.png)

![](http://github.com/aldrinmartoq/multicore-sieve/raw/master/results/sievemultip.png)
