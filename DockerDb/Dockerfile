# Basbild
FROM postgres:latest

# Sätt miljövariabler
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=mydbname

# Specifiera arbetskatalogen (valfritt)
WORKDIR /var/lib/postgresql/data

# Exponera standard PostgreSQL-port
EXPOSE 5432

# Volym för att behålla data
VOLUME /var/lib/postgresql/data
