import os

file_path = r'd:\A_JAVA_Ki_5\SWP391\motor-booking\motorcycle-booking-system-main\src\main\java\com\smartride\util\DBUtil.java'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace DB_URL to add socketTimeout
content = content.replace(
    'jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require',
    'jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres?sslmode=require&socketTimeout=5'
)

# Replace getRawConnection loop to clear the pool if one is dead
old_loop = '''            while(conn != null) {
                if(!conn.isClosed() && conn.isValid(1)) {
                    return conn;
                }
                if(conn != null) try { conn.close(); } catch(Exception e){}
                conn = pool.poll();
            }'''

new_loop = '''            if (conn != null) {
                if (!conn.isClosed() && conn.isValid(1)) {
                    return conn;
                } else {
                    if(conn != null) try { conn.close(); } catch(Exception e){}
                    pool.clear(); // Clear all connections since one died, others probably did too due to idle timeout
                }
            }'''

content = content.replace(old_loop, new_loop)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('DBUtil heavily optimized.')
