multicore-sieve
===============

Ejemplo de código multicore con Grand Central Dispatch.

* sievesingle.m es un programa en C sin multicore

* sievemultip.m es el mismo programa, donde se paraleliza:
    * el poner en 1 el arreglo
    * marcar en 0 los primos
    * sumar los primos 

Notar que en ninguna parte se especifica la cantidad de cores.

Ejemplo de ejecución
--------------------

    $ cd src
    $ make test
    
    time ./sievesingle 1000000000
    total primos: 50847534
          198.05 real       195.73 user         2.31 sys
    
    time ./sieveopenmp 1000000000
    threads: 4
    total primes 50847534
          129.05 real       482.46 user         4.94 sys
    
    time ./sievemultip 1000000000
    total primos: 50847534
          130.08 real       485.81 user         5.11 sys


Uso de CPU
----------

![](http://github.com/aldrinmartoq/multicore-sieve/raw/master/results/sievesingle.png)

![](http://github.com/aldrinmartoq/multicore-sieve/raw/master/results/sieveopenmp.png)

![](http://github.com/aldrinmartoq/multicore-sieve/raw/master/results/sievemultip.png)
