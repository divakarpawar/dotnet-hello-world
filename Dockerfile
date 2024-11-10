FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

COPY . .
RUN dotnet restore

FROM build-env AS publish
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=publish /app/out .
ENTRYPOINT ["dotnet", "dotnet.dll"]
