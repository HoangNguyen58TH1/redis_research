for i in {0..15}; do
  echo "DB $i: $(redis-cli -n $i DBSIZE) keys"
done

# DB 0: 0 keys
# DB 1: 0 keys
# DB 2: 0 keys
# DB 3: 0 keys
# DB 4: 0 keys
# DB 5: 0 keys
# DB 6: 0 keys
# DB 7: 0 keys
# DB 8: 0 keys
# DB 9: 0 keys
# DB 10: 0 keys
# DB 11: 0 keys
# DB 12: 0 keys
# DB 13: 0 keys
# DB 14: 0 keys
# DB 15: 0 keys
