LhFast
======

## development

## testing

## production

## data operations

```sh
Loan.where("fico_mean is null").limit(100).map {|l| FetchLoanFicoWorker.perform_async(l.loan_id) }
``

## License
Copyright (c) 2015, Weston Platter. All rights reserved.

