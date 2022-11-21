#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:3.1.30-focal AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim AS publish

WORKDIR /src

COPY . .

RUN dotnet restore "TournamentAssistantCore/TournamentAssistantCore.csproj"

RUN dotnet publish "TournamentAssistantCore/TournamentAssistantCore.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TournamentAssistantCore.dll"]