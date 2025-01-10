
# -------------- SETUP

# Ta bort alla containers, images och volumer!

docker rm -f $(docker ps -aq) ; docker rmi -f $(docker images -q) ; docker volume rm -f $(docker volume ls -q)

# Gå till en mapp t.ex C:\TMP
cd C:\TMP

# Skapa en fil med namnet "script.ps1" och skriv in funktionen
@"
function Info() 
{
    write-host
    docker image ls -a
    
    write-host
    docker container ls -a
    
    write-host
    docker volume ls
    
    write-host
}
"@ | Out-File -FilePath "info.ps1"


# Ladda in funktionen i PowerShell (notera första punkten)
 . .\Info.ps1

# Kolla om Docker är igång

docker info

# Finns det några images, containers eller volumes? Isåfall ta bort dem genom att använda Docker Desktop

info

# -------------- IMAGE

# Hämta en image från Docker Hub, (Bara 72.8Mb, lägger sig i listan, tar några sekunder)
## (från 2020-04)

info 

# Hämta den senaste versionen (nu visas två st i listan)
docker pull ubuntu:latest
info 

# Samma kommando igen (image is up to date, så det händer inget)
docker pull ubuntu:latest
info 

# Hämta version 20.04 av ubuntu
docker pull ubuntu:20.04
info 

# Använder "default tag" "latest", så det blir samma som ovan
docker pull ubuntu
info 

# -------------- INFO


# Container är inte en virtuell maskin: En container är en isolerad miljö för att köra en specifik process.

# Containerns livslängd är knuten till den process som körs inuti den. När processen avslutas, avslutas också containern.

# Att "ansluta" eller "gå in" i en container betyder att du går in i den isolerade miljön för den *körande processen*. Om processen har avslutats finns det ingen container att ansluta till.

# Kommandon docker attach och docker exec: Dessa kommandon fungerar bara på körande containers.

# -------------- CONTAINER

# Skapa en container från en image med namnet ubbe1
# "-it" ==> för att få en interaktiv terminal
docker run -it --name ubbe1 ubuntu:20.04

# Detalj: "docker run" hämtar imagen om det behövs
# Tips: öppna en till flik i terminalen och visa att containern är skapad och igång
# Visa alla mappar, skapa en mapp, visa alla mappar igen
ls
mkdir oooooooooo
ls
exit

# Notera att den är Exited
info

# Starta (detta behövs)
docker start ubbe1

# Kör bash i containern (detalj: "bash" krävs i slutet)
docker exec -it ubbe1 bash

# Verifiera att mappen finns + avsluta
ls
exit

# Kör kommando från värden, lista alla mappar (-it behövs inte)
docker exec ubbe1 ls
docker exec ubbe1 ls -al

# -------------- CONTAINER

# Som tidigare, skapa en ny container och en mapp i den
docker run -it --name ubbe2 ubuntu:20.04
mkdir ppppppppppppp
exit
docker start ubbe2
info

docker exec -t ubbe1 ls
docker exec -t ubbe2 ls

# -------------- CONTAINER - python

# Skapa en container, installera python3, skriv en fil och kör den
docker run -it --name ubbe3 ubuntu

# Installera python och skapa en python-fil
# Detalj: "apt-get" används i Debian-baserade system (som Ubuntu) för att uppdatera listan över tillgängliga paket och installera nya paket
apt-get update

# Detalj: installera Python 3 och godkänn automatiskt
apt-get install -y python3

# (Välj 8 och 49 under installationen)

echo 'print("This code lives in a container!")' > hello.py
ls

# Testkör
python3 hello.py

# Avsluta
exit

# Kör filen från värden
docker start ubbe3
docker exec ubbe3 python3 hello.py

# -------------- SKAPA IN IMAGE (!)

# Skapa en image från en container
info
docker commit ubbe3 my-own-image
info

# Skapa en container från den nya imagen, visa att filen finns där (hello.py) och att Python är installerat
docker run -it --name ubbe4 my-own-image
ls
exit

# Skapa en container och kör python-filen direkt
docker run --name ubbe5 my-own-image python3 hello.py

# (kör kommandot igen och få ett felmeddelande, att containern redan finns)

# I vissa fall vill vi inte behålla containern, utan bara köra en kommando:
docker run --rm my-own-image python3 hello.py


# -------------- REDIS

# Se till att du har en tom mapp
cd c:\TMP
ls 

# Hämta och kör redis, skapa en container med namnet reddy
# Starta en redis-server och spara ett snapshot var 60:e sekund om minst 1 write har hänt
    # -v => koppla data-filen till en mapp på värden
    # -d => körs i bakgrunden

docker run `
--name reddy `
-d `
-v "c:/TMP/redis-data:/data" `
redis `
redis-server --save 60 1 --loglevel verbose

    # debug     <-- loggar mest
    # verbose
    # notice
    # warning

info


    # Default startas containers i “foreground mode”, då är din console kopplad till containers input och output.
    # Med detached mode kan du följa containerns med docker logs -f <container_id>



# Nu finns en mapp "redis-data", som är tom
ls
ls redis-data

# Högerklicka på tabben i Terminal och välj "split tab" (!)

# Visa loggarna där (-f ==> forstätt följ loggarna)
docker logs reddy -f

# Anslut till redis-servern

docker exec -it reddy redis-cli

    # loggarna
    [datum] Accepted 127.0.0.1:34320

# Lägg till ett värde, och visa det sedan. 
SET welcome "I'm reddy!"

    # loggarna
    [datum] - DB 0: 2 keys (0 volatile) in 4 slots HT.
    [datum] * DB saved on disk

GET welcome
exit

# Visa att data har sparats (här ser du texten "I'm reddy!")

ls redis-data
cat redis-data/dump.rdb

# Ta bort containern, skapa en ny exakt likadan, visa att data finns kvar
docker rm reddy -f
    # -f => force, tar bort även om containern körs 

info

[Detta är en kopia av ovan, förutom att namnet är ändrat]

docker run `
--name reddyNEUE `
-d `
-v "c:/TMP/redis-data:/data" `
redis `
redis-server --save 60 1 --loglevel verbose

[anslut som innan med "docker exec"]
docker exec -it reddyNEUE redis-cli
GET welcome
exit

# Ta bort containern
docker rm reddyNEUE -f

# -------------- REDIS - volume

# Precis som innan men med en volume, döper den till "redisvolume"
docker run `
--name reddy2 `
-d `
-v "redisvolume:/data" `
redis `
redis-server --save 60 1 --loglevel verbose

# Nu syns volumen i listan
info

# Lägg till ett värde i databasen
[Detta är en kopia av ovan, men med "reddy2"]

# Anslut till redis-servern

docker exec -it reddy2 redis-cli

    # loggarna
    [datum] Accepted 127.0.0.1:34320

# Lägg till ett värde, och visa det sedan. 
SET welcome "I'm reddy2!"

    # loggarna
    [datum] - DB 0: 2 keys (0 volatile) in 4 slots HT.
    [datum] * DB saved on disk

GET welcome
exit

# Öppna Docker Desktop och visa att "dump.rdb" finns i "redisvolume", med det nya värdet

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


    I Docker är det en vanlig och rekommenderad praxis att använda *volymer* för att lagra data från databaskontainrar istället för att lagra data direkt i kontainern. Här är några anledningar till varför:

    Data Persistence: Data som lagras i en volym överlever *omstart eller återuppbyggnad* av kontainern. Om du inte använder en volym och kontainern tas bort, går all data förlorad.

    Separation of Concerns: Genom att separera data från applikationen blir det enklare att hantera och *säkerhetskopiera data*. Det gör också kontainern mer flexibel och enklare att byta ut.

    Delning mellan kontainrar: Volymer gör det möjligt att *dela data* mellan flera kontainrar. Detta kan vara användbart om flera applikationer behöver komma åt samma databasdata.

    Prestanda: Användning av volymer kan förbättra *prestandan* eftersom Docker optimerar volymer för disk I/O.

    Skalbarhet: Det är lättare att *skala upp och ner* tjänster och applikationer när data lagras i volymer eftersom du kan skapa och förstöra kontainrar utan att förlora data.

    (En Volume är inte en sorts Container)
    (Det kommenderas inte att flera redis-container delar samma volume)


# -------------- MYSQL (bra, men skippa i webbinaret)

# Skapa en container med en mysql-databas
# Liknar det tidigare, men här behöver vi ange ett lösenord för root-användaren
# Volymen pekar också mot en annan mapp
docker run `
--name mydatabase `
-d `
-e MYSQL_ROOT_PASSWORD=secret `
-v "mysqlvolume:/var/lib/mysql" `
mysql


# Visa innehållet i databasen

docker run --rm -it `
-v mysqlvolume:/mnt `
ubuntu ls -al /mnt

    # ls -alt ==> om du vill sortera efter datum

# Kör ett kommando i containern, i detta fallet "mysql"
docker exec -it `
mydatabase `
mysql -u root -p

# Ange "secret"

# Skapa en tabell "fruit" med en frukt
CREATE DATABASE shop;
USE shop;
CREATE TABLE fruit(id INT PRIMARY KEY, name VARCHAR(255));
INSERT INTO fruit VALUES (17, 'Green Apple');
SELECT * FROM fruit;

#
# Liknar det vi gjorde sist, men med tillägget "-e" (execute i MySQL)
# La också till "psecret" för att automatiskt logga in (obs inget mellanslag)
docker exec -it `
mydatabase `
mysql -u root -psecret -e "USE shop; INSERT INTO fruit VALUES (18, 'Banana');"

# Visa de båda frukterna
docker exec -it `
mydatabase `
mysql -u root -psecret -e "USE shop; SELECT * from fruit;"


# -------------- NODE ALPINE (bra, men skippa i webbinaret)

# Hämta image, och starta en interaktiv terminal (notera sh på slutet)

docker run -it `
--name myalpine `
node:18-alpine sh

info

# När du är inne i container
node -v  
# nu ser du verisonen av node (18.20.3)

# -------------- TODO APP

# Gå till projektet
cd C:\Project\Docker\getting-started-app

# Visa projektet. Visa compose.yaml.
code .

# Förklara: här är källkod, men programmet körs inte här, utan i containers

# Starta
docker compose up

    # Kan också köra "-d"

    # Allt starta utifrån yml-filen. 
    # mysql-1 och app-1 loggas 

    # det tar 1-2 minuter
    
# Browsa till localhost:3000 och lägg till en todo

info

# Notera att volymen "getting-started..." har skapats
# Notera att volymen "getting-started.." containers har skapats, en för mysql och en för node18-alphine

# Testa att stänga ner allt och starta om
# Verfifiera att todon är kvar


# Ändra i filen, typ rad 109, där knappen är och spara om 
C:\Project\Docker\getting-started-app\src\static\js\app.js

# Notera att loggen uppdateras:

    [nodemon] restarting due to changes...
    app-1    | [nodemon] starting `node src/index.js`
    app-1    | Waiting for mysql:3306.
    app-1    | Connected!
    app-1    | Connected to mysql db at host mysql
    app-1    | Listening on port 3000

# Ladda om sidan och se förändringen!


# -------------- ÖVRIGT

# Ta bort alla avslutade containers

docker container prune

docker compose logs -f # <== får inte att funka


# -------------- CONTAINER - problem (skippa)

# Skapa en container från en image med namnet ubbe1, ubbe2
docker run --name tmp ubuntu:20.04
info

# Problem: denna container har ingen process som körs, så den avslutas direkt
# Standardbetteend för ubuntu-imagen är att starta, efter kommandon är körda så avslutas den,
# Alla image fungerar inte så. T.ex nginx och mysql hålls igång efter att de startats.


# Vi tar bort den
docker rm tmp
info
