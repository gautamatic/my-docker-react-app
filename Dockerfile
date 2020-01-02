# -------------------------------------------------------
# build phase
# tag this step so we can use it later
# -------------------------------------------------------
FROM node:alpine as builder-stage      
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN ["npm", "run", "build"]


# -------------------------------------------------------
# run phase
# -------------------------------------------------------
# this is a new block
# each block can only have one FROM statement
FROM nginx

# just copy the build artifacts that we need
COPY --from=builder-stage /app/build /usr/share/nginx/html

