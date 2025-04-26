# Start from official image
FROM nginx:alpine

# Copy static HTML file
RUN echo "<h1>Jenkins Test Application deployed successfully 🚀</h1>" > /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
