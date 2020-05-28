FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
#expose will be used by elasticbeanstalk automatically to map the port 80 to localhost
COPY --from=builder /app/build /usr/share/nginx/html
## run of nginx will be taken care by nginx image itself