# Elitech Nexus - Deployment Guide

This guide provides instructions for deploying Elitech Nexus to production environments.

## Prerequisites

- Linux/Unix server (Ubuntu 20.04+ recommended)
- Node.js v16+
- MySQL 8.0+
- Nginx or Apache (reverse proxy)
- SSL certificate (Let's Encrypt recommended)
- Domain name

## Deployment Options

### Option 1: Traditional VPS Deployment

#### 1. Server Setup

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

# Install MySQL
sudo apt install -y mysql-server

# Install Nginx
sudo apt install -y nginx

# Install Git
sudo apt install -y git
```

#### 2. Clone and Configure Application

```bash
cd /var/www
sudo git clone https://github.com/fadugafhionnamei/BuildWithAI.git
cd BuildWithAI

# Setup backend
cd backend
npm install --production
cp .env.example .env

# Edit .env for production
sudo nano .env
```

Update `.env`:
```
NODE_ENV=production
PORT=3000
DB_HOST=localhost
DB_USER=nexus_user
DB_PASSWORD=strong_password_here
DB_NAME=elitech_nexus
JWT_SECRET=production_secret_key_change_this
CORS_ORIGIN=https://yourdomain.com
```

#### 3. Database Setup

```bash
# Create database and user
mysql -u root -p
```

```sql
CREATE DATABASE elitech_nexus;
CREATE USER 'nexus_user'@'localhost' IDENTIFIED BY 'strong_password_here';
GRANT ALL PRIVILEGES ON elitech_nexus.* TO 'nexus_user'@'localhost';
FLUSH PRIVILEGES;

-- Import schema
USE elitech_nexus;
SOURCE /var/www/BuildWithAI/database/schema.sql;
```

#### 4. Process Manager (PM2)

```bash
# Install PM2 globally
sudo npm install -g pm2

# Navigate to backend
cd /var/www/BuildWithAI/backend

# Start with PM2
pm2 start server.js --name "elitech-nexus" --env production

# Save PM2 configuration
pm2 save

# Set up auto-start on reboot
pm2 startup
```

#### 5. Nginx Configuration

Create `/etc/nginx/sites-available/elitech-nexus`:

```nginx
upstream elitech_backend {
    server 127.0.0.1:3000;
}

server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    
    # Redirect to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;

    # SSL certificates
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    # Security headers
    add_header Strict-Transport-Security "max-age=31536000" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-Frame-Options "DENY" always;

    # Frontend
    location / {
        alias /var/www/BuildWithAI/frontend/;
        try_files $uri $uri/ /index.html;
    }

    # API proxy
    location /api {
        proxy_pass http://elitech_backend;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # Gzip compression
    gzip on;
    gzip_types text/plain text/css text/javascript application/json;
}
```

Enable the site:
```bash
sudo ln -s /etc/nginx/sites-available/elitech-nexus /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

#### 6. SSL Certificate (Let's Encrypt)

```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot certonly --nginx -d yourdomain.com -d www.yourdomain.com
```

### Option 2: Docker Deployment

#### 1. Create Dockerfile (Backend)

```dockerfile
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]
```

#### 2. Create docker-compose.yml

```yaml
version: '3.8'

services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: elitech_nexus
      MYSQL_USER: nexus_user
      MYSQL_PASSWORD: user_password
    volumes:
      - mysql_data:/var/lib/mysql
      - ./database/schema.sql:/docker-entrypoint-initdb.d/schema.sql
    ports:
      - "3306:3306"

  backend:
    build: ./backend
    environment:
      NODE_ENV: production
      DB_HOST: db
      DB_USER: nexus_user
      DB_PASSWORD: user_password
      DB_NAME: elitech_nexus
      JWT_SECRET: production_secret
    ports:
      - "3000:3000"
    depends_on:
      - db
    volumes:
      - ./backend:/app

  frontend:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./frontend:/usr/share/nginx/html
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - backend

volumes:
  mysql_data:
```

Run: `docker-compose up -d`

### Option 3: Cloud Deployment

#### Heroku

```bash
# Login to Heroku
heroku login

# Create app
heroku create elitech-nexus

# Add MySQL add-on
heroku addons:create jawsdb:kitefin

# Deploy
git push heroku main
```

## Monitoring & Maintenance

### Logs

```bash
# PM2 logs
pm2 logs

# Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Application logs
sudo nano /var/log/pm2.log
```

### Backups

```bash
# Daily database backup
0 2 * * * mysqldump -u nexus_user -p elitech_nexus > /backups/nexus_$(date +\%Y\%m\%d).sql

# Upload to cloud storage
0 3 * * * aws s3 cp /backups/nexus_*.sql s3://your-bucket/backups/
```

### Updates

```bash
# Update dependencies
cd /var/www/BuildWithAI/backend
npm update

# Restart application
pm2 restart elitech-nexus
```

## Security Checklist

- [ ] Change all default passwords
- [ ] Set up SSL/TLS certificates
- [ ] Enable firewall (ufw)
- [ ] Configure fail2ban
- [ ] Set up automated backups
- [ ] Enable database backups
- [ ] Configure rate limiting
- [ ] Set up monitoring alerts
- [ ] Regular security updates
- [ ] Implement DDoS protection

## Performance Optimization

- Enable Gzip compression
- Use CDN for static assets
- Implement caching strategies
- Optimize database queries
- Use connection pooling
- Configure load balancing

## Support

For deployment issues, refer to official documentation:
- [Nginx Documentation](https://nginx.org/en/docs/)
- [PM2 Documentation](https://pm2.keymetrics.io/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Docker Documentation](https://docs.docker.com/)

---

**Last Updated**: May 2024
