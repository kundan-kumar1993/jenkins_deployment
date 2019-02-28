#
# Build ASP .NET Core
#
FROM microsoft/dotnet:2.2-sdk AS dotnet-builder
WORKDIR /api

# caches restore result by copying csproj file separately
#COPY api/Gjenesis.API ./Gjenesis.API/
#COPY api/nuget.config .
#RUN dotnet restore Gjenesis.API
COPY api ./api/
#COPY api/nuget.config .
RUN dotnet restore api

# copies the rest of your code
COPY api/ .
RUN dotnet publish api -o /app -c Release

#
# Build Angular
#
# FROM node:10.11-alpine AS angular-builder

# COPY web/package.json web/package-lock.json ./

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
# RUN npm i && mkdir /ng-app && mv ./node_modules ./ng-app

# WORKDIR /ng-app

# Copy rest and build
#COPY web/ .
#COPY --from=dotnet-builder /app/swagger.json .

#RUN npm rebuild node-sass
#RUN npm run lint
#RUN npm config set gjenesis-web:swagger swagger.json
#RUN npm run build

#
# Build final result, where the .NET Core runtime hosts both the .NET backend
# and the Angular frontend (served by Kestrel).
#
FROM microsoft/dotnet:2.2-aspnetcore-runtime

WORKDIR /app
COPY --from=dotnet-builder /app .
#COPY --from=angular-builder /ng-app/dist wwwroot

ENTRYPOINT ["dotnet", "api.dll"]
EXPOSE 8181
