LhFast
======

## development

## testing

## production

## data operations

```sh
Loan.where("fico_mean is null").limit(100).map {|l| FetchLoanFicoWorker.perform_async(l.loan_id) }
``

```sh
num = 200
Loan.where("fico_mean is null").where("loan_id is not null").first(num).map{|l| FetchLoanFicoWorker.perform_async(l.loan_id) }
```

## License
Copyright (c) 2015, Weston Platter. All rights reserved.

