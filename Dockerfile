#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:3.1.30-focal AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0-jammy AS publish

WORKDIR /src

COPY TournamentAssistantShared TournamentAssistantShared
COPY TournamentAssistantProtos TournamentAssistantProtos
COPY TournamentAssistantCore TournamentAssistantCore

WORKDIR /TournamentAssistantCore

RUN dotnet publish "TournamentAssistantCore.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TournamentAssistantCore.dll"]