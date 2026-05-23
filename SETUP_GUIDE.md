# Elitech Nexus - Installation & Setup Guide

This document provides comprehensive setup instructions for deploying **Elitech Nexus** locally.

## Architecture Overview

```
Elitech Nexus
├── Frontend (HTML5, Vanilla JS, Tailwind CSS)
├── Backend (Node.js + Express.js)
└── Database (MySQL)
```

## Prerequisites

1. **Node.js** (v16+) - [Download](https://nodejs.org/)
2. **MySQL Server** - Either:
   - [XAMPP](https://www.apachefriends.org/) (Recommended, includes MySQL)
   - [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)
3. **Git** - [Download](https://git-scm.com/)
4. **Text Editor** - VS Code recommended

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/fadugafhionnamei/BuildWithAI.git
cd BuildWithAI
```

### 2. Set Up MySQL Database

#### Option A: Using XAMPP
1. Open XAMPP Control Panel
2. Start **Apache** and **MySQL**
3. Click "Admin" for MySQL (opens phpMyAdmin)
4. In phpMyAdmin, select "New" and create database `elitech_nexus`
5. Go to SQL tab and paste contents of `database/schema.sql`
6. Click Execute

#### Option B: Command Line
```bash
mysql -u root -p
```

Then in MySQL:
```sql
CREATE DATABASE elitech_nexus;
USE elitech_nexus;
-- Paste the contents of database/schema.sql
```

### 3. Set Up Backend

```bash
cd backend
npm install
```

Create `.env` file (or copy from `.env.example`):
```
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=elitech_nexus
JWT_SECRET=elitech_nexus_secret_key_2024
```

Start the backend server:
```bash
npm run dev
```

Expected output:
```
✈️ Elitech Nexus API running on http://localhost:3000
✓ Database connection successful
```

### 4. Set Up Frontend

Navigate to the frontend directory and serve the HTML file. You can use:

**Option A: Python (if installed)**
```bash
cd frontend
python -m http.server 5500
```

**Option B: Node.js (using http-server)**
```bash
npm install -g http-server
cd frontend
http-server -p 5500
```

**Option C: VS Code Live Server**
1. Install "Live Server" extension in VS Code
2. Right-click `frontend/index.html`
3. Select "Open with Live Server"

### 5. Access the Application

Open your browser and navigate to:
```
http://localhost:5500/
```

## Default Login Credentials

After setup, you can log in with:
- **Email**: `admin@elitech.ph`
- **Password**: `admin123` (hashed in database)

Or register a new account directly.

## Project Structure

```
BuildWithAI/
├── frontend/
│   ├── index.html
│   └── assets/
│       ├── css/
│       │   └── styles.css
│       ├── js/
│       │   └── main.js
│       └── images/
├── backend/
│   ├── server.js
│   ├── package.json
│   ├── .env
│   ├── config/
│   │   └── database.js
│   ├── middleware/
│   │   └── auth.js
│   ├── models/
│   │   ├── User.js
│   │   ├── Event.js
│   │   └── Attendance.js
│   ├── routes/
│   │   ├── authRoutes.js
│   │   ├── eventRoutes.js
│   │   ├── attendanceRoutes.js
│   │   └── userRoutes.js
│   └── controllers/ (to be implemented)
├── database/
│   └── schema.sql
└── README.md
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Create new account
- `POST /api/auth/login` - Login user

### Events
- `GET /api/events` - Get all events
- `GET /api/events/upcoming` - Get upcoming events
- `GET /api/events/:id` - Get specific event
- `POST /api/events` - Create event (protected)
- `PUT /api/events/:id` - Update event (protected)
- `DELETE /api/events/:id` - Delete event (protected)

### Attendance
- `POST /api/attendance/log` - Log attendance (protected)
- `GET /api/attendance/user/:userId` - Get user attendance (protected)
- `GET /api/attendance/event/:eventId` - Get event attendance (protected)

### Users
- `GET /api/users/me` - Get current user profile (protected)
- `GET /api/users` - Get all users (protected)

## Features Implemented

### ✅ Completed
- User Authentication (Registration & Login)
- Event Management (CRUD operations)
- Attendance Logging
- Responsive Dashboard
- Event Calendar View
- User Profile Management

### 🎯 Planned Features
- Event Reminders & Notifications
- AdminPanel forEvent Management
- Attendance Reports & Statistics
- Email Confirmation
- Two-Factor Authentication
- Mobile App Integration

## Troubleshooting

### Database Connection Error
- Ensure MySQL is running (check XAMPP Control Panel)
- Verify `DB_HOST`, `DB_USER`, `DB_PASSWORD` in `.env`
- Confirm database `elitech_nexus` exists

### Port Already in Use
```bash
# Change PORT in .env or use different port:
PORT=3001
```

### CORS Error
- Ensure `CORS_ORIGIN` in `.env` matches your frontend URL
- Default: `http://localhost:5500`

### Missing Dependencies
```bash
cd backend
npm install
```

## Development Commands

### Backend
```bash
npm run dev      # Start with auto-reload
npm start        # Start normally
npm test         # Run tests
```

## Support

For issues or questions:
1. Check this README
2. Review error logs in console
3. Contact the Elitech Development Team

---

**Elitech Nexus** - Built for the Elitech Society at Philippine State College of Aeronautics (PhilSCA)
