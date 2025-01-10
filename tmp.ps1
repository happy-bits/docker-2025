# I terminalen, lista filerna i volymen
docker run --rm -it `
-v redisvolume:/mnt `
ubuntu ls /mnt

    # --rm => tar bort containern efter att den har körts
    # mnt, kan vara vilket namn som helst

# Visa innehållet

docker run --rm -it `
-v redisvolume:/mnt `
ubuntu cat /mnt/dump.rdb