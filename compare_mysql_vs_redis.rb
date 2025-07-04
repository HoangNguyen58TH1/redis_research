#
mysql -uroot
> CREATE DATABASE sbtest;
> CREATE USER sbtest@127.0.0.1 IDENTIFIED BY 'Password1!';
> GRANT ALL PRIVILEGES ON sbtest.* TO sbtest@127.0.0.1;
mysql -usbtest -pPassword1! -h127.0.0.1

# 1. Create data:
sysbench  \
  --mysql-host=127.0.0.1 \
  --mysql-port=3306 \
  --mysql-db=sbtest \
  --mysql-user=sbtest \
  --mysql-password=Password1! \
  --tables=16 \
  --table_size=10000 \
  oltp_common prepare

# 2
# sysbench  \
#   --mysql-host=127.0.0.1 \
#   --mysql-port=3306 \
#   --mysql-db=sbtest \
#   --mysql-user=sbtest \
#   --mysql-password=Password1! \
#   --tables=16 \
#   --table_size=10000 \
#   oltp_read_write run
# ==>
# SQL statistics:
#     queries performed:
#         read:                            172858
#         write:                           49388
#         other:                           24694
#         total:                           246940
#     transactions:                        12347  (1234.36 per sec.)
#     queries:                             246940 (24687.27 per sec.)
#     ignored errors:                      0      (0.00 per sec.)
#     reconnects:                          0      (0.00 per sec.)
# General statistics:
#     total time:                          10.0025s
#     total number of events:              12347
# Latency (ms):
#          min:                                    0.74
#          avg:                                    0.81
#          max:                                    4.97
#          95th percentile:                        0.86
#          sum:                                 9995.44
# Threads fairness:
#     events (avg/stddev):           12347.0000/0.00
#     execution time (avg/stddev):   9.9954/0.00

# 3. Run command benchmark MySQL:
sysbench  \
  --mysql-host=127.0.0.1 \
  --mysql-port=3306 \
  --mysql-db=sbtest \
  --mysql-user=sbtest \
  --mysql-password=Password1! \
  --tables=16 \
  --table_size=10000 \
  --report-interval=1 \
  --threads=4 \
  --time=200 \
  --events=0 \
  oltp_read_write run
# [ 1s ] thds: 4 tps: 1704.33 qps: 34162.13 (r/w/o: 23916.28/6833.22/3412.63) lat (ms,95%): 2.14 err/s: 0.00 reconn/s: 0.00
# [ 2s ] thds: 4 tps: 2341.38 qps: 46795.64 (r/w/o: 32763.35/9349.52/4682.77) lat (ms,95%): 1.61 err/s: 0.00 reconn/s: 0.00
# [ 3s ] thds: 4 tps: 2649.48 qps: 52993.68 (r/w/o: 37090.77/10604.94/5297.97) lat (ms,95%): 1.58 err/s: 0.00 reconn/s: 0.00
# [ 4s ] thds: 4 tps: 1874.56 qps: 37483.28 (r/w/o: 26239.90/7494.25/3749.13) lat (ms,95%): 1.79 err/s: 0.00 reconn/s: 0.00
# [ 5s ] thds: 4 tps: 1560.71 qps: 31250.09 (r/w/o: 21871.87/6255.80/3122.42) lat (ms,95%): 1.76 err/s: 0.00 reconn/s: 0.00
# [ 6s ] thds: 4 tps: 2257.11 qps: 45089.12 (r/w/o: 31562.48/9012.42/4514.21) lat (ms,95%): 1.58 err/s: 0.00 reconn/s: 0.00
# [ 7s ] thds: 4 tps: 2679.44 qps: 53603.91 (r/w/o: 37525.25/10719.78/5358.89) lat (ms,95%): 1.50 err/s: 0.00 reconn/s: 0.00
==> READ 25K & WRITE 8K

4. Reids-benchmark:
redis-benchmark -n 1000000 -t get,set -P 200 -q
GET: 2475247.50 requests per second, p50=3.239 msec
SET: 1953124.88 requests per second, p50=4.247 msec

5. Compare:
READ 2475K / 25K = 100 lần
WRITE 1953K / 8K = 244 lần

6. Conclude:
- Sysbench:
+ Mô phỏng truy cập giao dịch có logic (SELECT, UPDATE, INSERT)
+ Có ràng buộc, có index, có khóa

- Redis-benchmark:
+ Gửi hàng loạt GET/SET rất đơn giản, không có xác nhận	
+ Không có schema, không ràng buộc ACID
