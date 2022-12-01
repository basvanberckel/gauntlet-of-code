FROM mcr.microsoft.com/dotnet/sdk:6.0

WORKDIR /app

COPY cases cases

RUN dotnet new console

COPY solution.cs Program.cs

CMD dotnet run