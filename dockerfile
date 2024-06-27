# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# Copy everything and restore dependencies
COPY . .
RUN dotnet restore

# Build and publish the application
RUN dotnet publish -c Release -o /app

# Stage 2: Create the runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app

# Copy the published app from the build stage
COPY --from=build /app ./

# Set the environment to Development for local debugging
ENV ASPNETCORE_ENVIRONMENT=Development

# Expose port 80 for the web application
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["dotnet", "DotNet5Crud.dll"]

