#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
ENV AppName="name in dockerfile"
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["TestEnvVar.csproj", "."]
RUN dotnet restore "./TestEnvVar.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "TestEnvVar.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TestEnvVar.csproj" -c Release -o /app/publish

FROM base AS final
#ENV AppName="name in dockerfile" not working
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TestEnvVar.dll"]