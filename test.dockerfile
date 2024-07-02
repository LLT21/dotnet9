FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
RUN apt-get update
RUN apt-get -yqq install clang zlib1g-dev 

WORKDIR /app
COPY ./ .
RUN dotnet publish -c Release -o out

# Construct the actual image that will run
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
RUN apt-get update

WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 8080

ENTRYPOINT ["./test"]