import time
import psycopg2

try:
    start = time.time()
    conn = psycopg2.connect("postgresql://postgres.zfvgigfjmbtgwgirdify:Bimdiendie1@@aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require")
    end = time.time()
    print(f"Connection time: {end - start} seconds")
    
    start = time.time()
    cur = conn.cursor()
    cur.execute("SELECT 1")
    cur.fetchone()
    end = time.time()
    print(f"Query time: {end - start} seconds")
    
    conn.close()
except Exception as e:
    print(e)
