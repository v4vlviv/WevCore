FROM microsoft/aspnetcore:2.0 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /src
COPY ["WebCore/WebCore.csproj", "WebCore/"]
RUN dotnet restore "WebCore/WebCore.csproj"
COPY . .
WORKDIR "/src/WebCore"
RUN dotnet build "WebCore.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "WebCore.csproj" -c Release -o /app

FROM base 
WORKDIR /app 
COPY --from=2 /app .
ENTRYPOINT ["dotnet", "WebCore.dll"]
