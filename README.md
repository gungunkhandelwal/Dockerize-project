# Rail Sathi Backend API

A comprehensive FastAPI-based microservice for managing railway passenger complaints with media upload, email notifications, and real-time processing capabilities.

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Python 3.8+ (for local development)
- PostgreSQL 14+

### Setup Instructions

#### Option 1: Using Docker (Recommended)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd RailSathiBE
   ```

2. **Set up environment variables**
   ```bash
   # Copy the example environment file
   cp .env.example .env
   
   # Edit the .env file with your actual values
   # For development, you can use the default values
   ```

3. **Start the application**
   ```bash
   docker-compose up --build
   ```

3. **Access the application**
   - API: http://localhost:8000
   - Swagger Documentation: http://localhost:8000/rs_microservice/docs
   - ReDoc Documentation: http://localhost:8000/rs_microservice/redoc

#### Option 2: Local Development

1. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Set up PostgreSQL database**
   ```bash
   # Create database and run init.sql
   psql -U postgres -d rail_sathi_db -f init.sql
   ```

5. **Run the application**
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

## 🏗️ Architecture

### Container Structure
- **railsathi_web**: FastAPI application container
- **railsathi_db**: PostgreSQL database container

### Key Components
- **FastAPI**: Modern, fast web framework for building APIs
- **PostgreSQL**: Robust relational database
- **Docker**: Containerized deployment
- **Uvicorn**: ASGI server with hot-reload support

## 🔧 Key Features

### 1. Complaint Management
- ✅ Create, read, update, and delete complaints
- ✅ Support for PNR validation
- ✅ Train information integration
- ✅ Status tracking (pending, in-progress, completed)

### 2. Media Upload
- ✅ Image and video file support
- ✅ Automatic file compression
- ✅ Cloud storage integration (Google Cloud Storage)
- ✅ Multiple file upload per complaint

### 3. Email Notifications
- ✅ Automated email alerts for complaint creation
- ✅ Configurable SMTP settings
- ✅ HTML email templates
- ✅ Asynchronous email processing

### 4. Train Information
- ✅ Train details lookup by train number
- ✅ Depot and division information
- ✅ Real-time train data integration

### 5. User Authentication
- ✅ Name and mobile number verification
- ✅ Secure complaint access control
- ✅ User-specific complaint management

## 📚 API Endpoints

### System Endpoints
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/rs_microservice` | Root endpoint - service status |
| GET | `/health` | Health check endpoint |
| GET | `/items/` | **Required assignment endpoint** - List complaints |

### Complaint Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/rs_microservice/complaint/add` | Create new complaint |
| GET | `/rs_microservice/complaint/get/{id}` | Get complaint by ID |
| GET | `/rs_microservice/complaint/get/date/{date}` | Get complaints by date |
| PATCH | `/rs_microservice/complaint/update/{id}` | Update complaint (partial) |
| PUT | `/rs_microservice/complaint/update/{id}` | Replace complaint (full) |
| DELETE | `/rs_microservice/complaint/delete/{id}` | Delete complaint |

### Media Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| DELETE | `/rs_microservice/media/delete/{id}` | Delete media files |

### Train Information
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/rs_microservice/train_details/{train_no}` | Get train details |

## 🧪 Testing the API

### Using Swagger UI
1. Open http://localhost:8000/rs_microservice/docs
2. Explore and test all endpoints interactively

### Using curl

#### Create a Complaint
```bash
curl -X POST "http://localhost:8000/rs_microservice/complaint/add" \
  -F "name=John Doe" \
  -F "mobile_number=9876543210" \
  -F "complain_type=Cleanliness" \
  -F "complain_description=Train was not clean" \
  -F "train_number=12345" \
  -F "train_name=Sample Train"
```

#### Get Complaint by ID
```bash
curl -X GET "http://localhost:8000/rs_microservice/complaint/get/1"
```

#### Get Complaints by Date
```bash
curl -X GET "http://localhost:8000/rs_microservice/complaint/get/date/2025-01-15?mobile_number=9876543210"
```

#### Get Train Details
```bash
curl -X GET "http://localhost:8000/rs_microservice/train_details/12345"
```

#### Required Assignment Endpoint
```bash
curl -X GET "http://localhost:8000/items/"
```

## 🔄 Development Features

### Hot Reload
- Code changes automatically trigger server restart
- Volume mounting for real-time development
- Docker-based development environment

### Database Management
- Automatic database initialization with sample data
- Health checks for database connectivity
- Wait-for-it script ensures proper startup order

### Logging
- Comprehensive logging configuration
- Structured logs for debugging
- Error tracking and monitoring

## 📁 Project Structure

```
RailSathiBE/
├── main.py                 # FastAPI application entry point
├── database.py            # Database connection and utilities
├── services.py            # Business logic and complaint services
├── requirements.txt       # Python dependencies
├── Dockerfile            # Docker image configuration
├── docker-compose.yml    # Multi-container setup
├── init.sql             # Database schema and sample data
├── wait-for-it.sh       # Database readiness script
├── .dockerignore        # Docker build exclusions
├── templates/           # Email templates
├── media/              # Uploaded media files
├── logs/               # Application logs
└── utils/              # Utility functions
    └── email_utils.py  # Email handling utilities
```

## 🚨 Limitations and Assumptions

### Design Decisions
1. **FastAPI**: Chosen for modern async support and automatic API documentation
2. **PostgreSQL**: Selected for ACID compliance and complex queries
3. **Docker**: Containerized deployment for consistency and scalability
4. **Form Data**: Using form data for file uploads instead of JSON
5. **Synchronous Database**: Using psycopg2 for simplicity (async version available)

## 📈 Performance Considerations

1. **Database Indexing**: Proper indexes on frequently queried columns
2. **File Compression**: Automatic image/video compression
3. **Async Processing**: Background tasks for email and file uploads
4. **Connection Pooling**: Database connection reuse
5. **Error Handling**: Comprehensive error handling and logging


## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.


---

**Rail Sathi Backend API** - Empowering railway passengers with efficient complaint management.