FROM microsoft/aspnetcore-build:2.0
WORKDIR /src
EXPOSE 80
COPY ["WebCore/WebCore.csproj", "WebCore/"]
RUN dotnet restore "WebCore/WebCore.csproj"
COPY . .
WORKDIR "/src/WebCore"
RUN dotnet build "WebCore.csproj" -c Release -o /app

ENTRYPOINT ["dotnet", "WebCore.dll"]
