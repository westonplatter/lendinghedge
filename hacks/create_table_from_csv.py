import pandas as pd

df = pd.read_csv('mypath.csv')

df.columns = [c.lower() for c in df.columns]

from sqlalchemy import create_engine

engine = create_engine('postgresql://weston:@localhost:5432/lh_fast_development')

df.to_sql("fhrs", engine)
