# Basbild
FROM postgres:latest

# Sätt miljövariabler
# Skapar en admin med namnet "postgres" och med systemdatabasen "postgres" (detta är default)
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=strong_password
ENV POSTGRES_DB=postgres

# Specifiera arbetskatalogen (valfritt)
WORKDIR /var/lib/postgresql/data

# Exponera standard PostgreSQL-port
EXPOSE 5432

# Volym för att behålla data
VOLUME /var/lib/postgresql/data
