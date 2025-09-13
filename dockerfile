# 1. Start with a base image
FROM node:18-alpine

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy package.json and package-lock.json first for better caching
COPY package*.json ./

# 4. Install the application dependencies
RUN npm install

# 5. Copy the rest of the application code
COPY . .

# 6. Expose the port the app runs on
EXPOSE 3000

# 7. Define the command to start the app
CMD ["node", "app.js"]