# ✈️ Elitech Nexus - Your NAAP-PhilSCA Collaboration Hub

Elitech Nexus is a secure, offline-first scheduling and organizational workspace explicitly designed for the **Elitech Society** at the **Philippine State College of Aeronautics (PhilSCA)**. 

Bachelor of Science in Aviation Information Technology (BSAIT) students frequently manage demanding schedules, balancing academic requirements with critical extracurriculars. Historically, students lacked a centralized system to track their organization participation and log their attendance at high-value tech seminars. 

**Elitech Nexus solves this problem** by providing a unified, localized dashboard to monitor milestones, log attendance, and manage organizational responsibilities.

## 🎯 Vision

To empower Elitech Society members with a modern, user-friendly platform that streamlines organizational management and enhances their academic and professional development journey.

---

## 📋 Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | HTML5, Vanilla JavaScript, Tailwind CSS |
| **Backend** | Node.js with Express.js (RESTful API) |
| **Database** | MySQL 8.0 (Local RDBMS) |
| **Authentication** | JWT + bcryptjs |
| **Deployment** | Local/Docker-ready |

---

## ⭐ Key Features

### 1. 📅 Event Tracker & Calendar
- Centralized, interactive dashboard to view organizational deadlines
- Tech seminars and chapter meetings calendar
- Upcoming events with detailed information
- Event categorization (seminars, workshops, networking events)

### 2. 🔐 Local Authentication
- Secure, locally hashed login and registration
- JWT-based session management
- Member profile management
- Password encryption with bcryptjs

### 3. ✅ Attendance Logging & Reminders
- Log attendance at specific events
- Automated alerts for upcoming mandatory workshops
- Attendance history and statistics
- Event participation tracking

### 4. 📊 Dashboard Analytics
- Real-time attendance statistics
- Event participation metrics
- Personal attendance history
- Organizational overview

---

## 🚀 Getting Started (Local Installation Guide)

Follow these steps to deploy Elitech Nexus locally on your machine.

### Prerequisites

- **[Node.js](https://nodejs.org/)** (v16.x or higher recommended)
- **[XAMPP](https://www.apachefriends.org/)** (or any MySQL server: MySQL Community, MariaDB, etc.)
- **Git** (for version control)
- **Text Editor** (VS Code recommended)

### Installation Steps

#### **1. Clone the Repository**

```bash
git clone https://github.com/fadugafhionnamei/BuildWithAI.git
cd BuildWithAI
```

#### **2. Set Up MySQL Database**

##### Option A: Using XAMPP (Recommended)
1. Open XAMPP Control Panel
2. Start **Apache** and **MySQL** services
3. Click **Admin** for MySQL (opens phpMyAdmin)
4. Create a new database named `elitech_nexus`
5. Go to the **SQL** tab and paste the contents of `database/schema.sql`
6. Click **Execute**

##### Option B: Using Command Line
```bash
mysql -u root -p
```

Then in MySQL terminal:
```sql
CREATE DATABASE elitech_nexus;
USE elitech_nexus;
-- Paste contents from database/schema.sql
```

#### **3. Set Up Backend**

```bash
cd backend
npm install
cp .env.example .env
```

Update `.env` with your database credentials:
```
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=elitech_nexus
JWT_SECRET=elitech_nexus_secret_key_2024
CORS_ORIGIN=http://localhost:5500
```

Start backend server:
```bash
npm run dev
```

Expected output:
```
✈️ Elitech Nexus API running on http://localhost:3000
✓ Database connection successful
```

#### **4. Set Up Frontend**

Navigate to frontend directory and serve using one of these methods:

**Method A: Python (if installed)**
```bash
cd frontend
python -m http.server 5500
```

**Method B: Node.js HTTP Server**
```bash
npm install -g http-server
cd frontend
http-server -p 5500
```

**Method C: VS Code Live Server Extension**
1. Install "Live Server" extension in VS Code
2. Right-click on `frontend/index.html`
3. Select "Open with Live Server"

#### **5. Access Application**

Open your browser and navigate to:
```
http://localhost:5500/
```

---

## 🔑 Default Credentials

After database setup, test login with:
- **Email**: `admin@elitech.ph`
- **Password**: `admin123`

Or register a new account directly in the application.

---

## 📁 Project Structure

```
BuildWithAI/
├── frontend/
│   ├── index.html                 # Main entry point
│   ├── assets/
│   │   ├── css/
│   │   │   └── styles.css        # Tailwind + custom styles
│   │   ├── js/
│   │   │   └── main.js           # SPA router & API client
│   │   └── images/               # Static assets
│   
├── backend/
│   ├── server.js                 # Express app entry
│   ├── package.json              # Dependencies
│   ├── .env                      # Environment config
│   ├── config/
│   │   └── database.js           # MySQL connection pool
│   ├── middleware/
│   │   └── auth.js               # JWT authentication
│   ├── models/
│   │   ├── User.js               # User operations
│   │   ├── Event.js              # Event operations
│   │   └── Attendance.js         # Attendance operations
│   ├── controllers/
│   │   ├── UserController.js     # User business logic
│   │   ├── EventController.js    # Event business logic
│   │   └── AttendanceController.js # Attendance logic
│   └── routes/
│       ├── authRoutes.js         # Login/Register endpoints
│       ├── eventRoutes.js        # Event CRUD endpoints
│       ├── attendanceRoutes.js   # Attendance endpoints
│       └── userRoutes.js         # User profile endpoints
│
├── database/
│   └── schema.sql                # MySQL schema & sample data
│
├── SETUP_GUIDE.md                # Detailed setup instructions
├── README.md                     # This file
└── .gitignore                    # Git ignore rules
```

---

## 🔌 API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/register` | Create new user account |
| POST | `/api/auth/login` | Login and get JWT token |

### Events
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/events` | Get all events |
| GET | `/api/events/upcoming` | Get upcoming events |
| GET | `/api/events/:id` | Get specific event |
| POST | `/api/events` | Create event (protected) |
| PUT | `/api/events/:id` | Update event (protected) |
| DELETE | `/api/events/:id` | Delete event (protected) |

### Attendance
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/attendance/log` | Log event attendance (protected) |
| GET | `/api/attendance/user/:userId` | Get user's attendance history (protected) |
| GET | `/api/attendance/event/:eventId` | Get event attendees (protected) |

### Users
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/users/me` | Get current user profile (protected) |
| GET | `/api/users` | Get all users (protected) |

---

## 🎨 Frontend Pages

- **Login Page** - User authentication
- **Registration Page** - New account creation
- **Dashboard** - Main organizational hub with statistics
- **Events Page** - Browse all events
- **Attendance Page** - View attendance history
- **Profile Page** - User account settings

---

## 🛠️ Development

### Backend Commands

```bash
# Install dependencies
npm install

# Start development server with auto-reload
npm run dev

# Start production server
npm start

# Run tests
npm test
```

### Database Management

**Backup Database**
```bash
mysqldump -u root elitech_nexus > backup.sql
```

**Restore Database**
```bash
mysql -u root elitech_nexus < backup.sql
```

---

## 🔒 Security Features

- Password hashing with bcryptjs (10 rounds)
- JWT token authentication
- CORS protection
- Helmet.js security headers
- Input validation on all endpoints
- SQL injection prevention via parameterized queries
- Environment variable configuration

---

## 📝 Future Enhancements

- [ ] Email notifications for upcoming events
- [ ] Event reminders (SMS/Email)
- [ ] Admin dashboard for event management
- [ ] Advanced reporting and analytics
- [ ] Mobile app (React Native)
- [ ] Real-time notifications (WebSockets)
- [ ] Two-factor authentication (2FA)
- [ ] Dark mode support
- [ ] Multi-language support
- [ ] Offline mode capability

---

## 🐛 Troubleshooting

### Database Connection Error
**Problem**: `Error: connect ECONNREFUSED 127.0.0.1:3306`

**Solution**:
1. Ensure MySQL is running (XAMPP: Start MySQL from Control Panel)
2. Check `.env` database credentials
3. Verify database `elitech_nexus` exists

### Port Already in Use
**Problem**: `Error: listen EADDRINUSE :::3000`

**Solution**: 
```bash
# Change PORT in .env
PORT=3001

# Or kill process using the port (Windows PowerShell as Admin)
Stop-Process -Id (Get-NetTCPConnection -LocalPort 3000).OwningProcess
```

### Module Not Found
**Problem**: `Error: Cannot find module 'express'`

**Solution**:
```bash
cd backend
npm install
```

### CORS Error
**Problem**: `Access to XMLHttpRequest blocked by CORS policy`

**Solution**: Update `.env` CORS_ORIGIN to match frontend URL
```
CORS_ORIGIN=http://localhost:5500
```

---

## 📞 Support & Contact

For issues, questions, or suggestions:
1. Check the [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions
2. Review error messages in browser console and terminal
3. Contact the Elitech Development Team

---

## 📄 License

Elitech Nexus is developed for the Elitech Society at PhilSCA.

---

## 👥 Contributors

- **Development Team**: Elitech Society
- **Mentorship**: Build With AI Program
- **Institution**: Philippine State College of Aeronautics (PhilSCA)

---

**Built with ❤️ for the Elitech Society | PhilSCA | 2024**
