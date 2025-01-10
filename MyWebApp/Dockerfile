

# BASBILD FÖR RUNTIME 

## Använd en officiell .NET 9 runtime som basbild "aspnet:9.0"
## Innehåller allt för att köra, men inte för att bygga
## Denna får namnet "base"
## Fasen avslutas när nästa "FROM" börjar

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
RUN echo "👉 VERSION 1"

## Sätt arbetskatalogen i kontainern till "app"
WORKDIR /app

# -----------------------------------------------------------

# BYGGMILJÖ

## Använder en annan basbild för att bygga och publicera appen "sdk:9.0"
## Denna får namnet "build"
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

## Arbetskatalogen för byggmiljön sätts till "src"
WORKDIR /src

## Kopiera projektfilen till arbetskatalogen
COPY ["MyWebApp.csproj", "./"]

## Restore laddar ner alla beroenden, de kommer cache'as
RUN dotnet restore "./MyWebApp.csproj"

## Kopiera hela projektets källkod till arbetskatalogen
COPY . .

## Bygg appen och lägg den i app/build
RUN dotnet build "MyWebApp.csproj" -c Release -o /app/build


# -----------------------------------------------------------

# PUBLICERING

## Utgå ifrån byggfasen
## Skapa en ny med namn "publish"
## Generellt: separera byggfasen med publiceringsfasen för bättre felhantering, du kan t.ex testa appen innan den publiceras
FROM build AS publish

## Publicerar appen i "/app/publish"
RUN dotnet publish "MyWebApp.csproj" -c Release -o /app/publish

# -----------------------------------------------------------

# SLUTBILD FÖR KÖRNING

## Utgå från basbilden, som endast innehåller runtime för att KÖRA applikationen
## Detta är den enda bilden som blir kvar i slutändan (de andra slängs)
## Detalj: "final" är inget reseverat namn, men den sista fasen brukar kallas "final" eller "production"
FROM base AS final

## Sätt arbetskatalog 
WORKDIR /app

## Kopierar den publicerade applikationen från publiceringsfasen till slutbilden
## Filerna kommer hamna 
COPY --from=publish /app/publish .

## Kör detta när containern startar (ex vid docker run)
ENTRYPOINT ["dotnet", "MyWebApp.dll"]

## Nu finns inga nya FROM så då vet vi att slutbilden är nådd