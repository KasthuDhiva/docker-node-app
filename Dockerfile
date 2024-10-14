# Step 1: Use an official Node.js image as the base
FROM node:14
# Step 2: Set the working directory in the container
WORKDIR /app
# Step 3: Copy package.json and package-lock.json files
COPY package*.json ./
# Step 4: Install Node.js dependencies
RUN npm install
# Step 5: Copy the rest of the application code
COPY . .
# Step 6: Expose the application port
EXPOSE 3000
# Step 7: Run the Node.js application
CMD ["node", "server.js"]
