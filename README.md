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




INSERT INTO notes ("loan_id","note_id") VALUES ('2228886','16001787') ON CONFLICT (loan_id) DO UPDATE SET note_id = , "order_id" = VALUES(`order_id`)



INSERT INTO notes (loan_id, note_id, order_id, outstanding_principal, created_at, updated_at) VALUES ('2228886','16001787','4147679','0.87', '2015-12-27 18:17:27.804451','2015-12-27 18:17:27.804538') ON CONFLICT (note_id) DO UPDATE SET order_id = notes.order_id, outstanding_principal = notes.outstanding_principal, updated_at = EXCLUDED.updated_at
