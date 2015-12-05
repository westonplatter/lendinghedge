LhFast
======

## development

## testing

## production

## License
Copyright (c) 2015, Weston Platter. All rights reserved.



SELECT * FROM loans
WHERE loan_status NOT IN ('Current')
LIMIT 10000


SELECT count(*) FROM loans
WHERE loan_status IN (
  'Does not meet the credit policy.  Status:Charged Off',
  'Charged Off',
  'Default',
  'Fully Paid',
  'Does not meet the credit policy.  Status:Fully Paid'
)
LIMIT 10000
