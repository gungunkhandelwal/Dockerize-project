# Rail Sathi FastAPI Application

A FastAPI-based microservice for handling railway passenger complaints with Docker containerization.

## Features

- ✅ Complaint management (CRUD operations)
- ✅ Media file upload support (images/videos)
- ✅ Email notifications
- ✅ PostgreSQL database integration
- ✅ Docker containerization
- ✅ API documentation with Swagger
- ✅ Wait-for-it script for database startup handling
- ✅ Hot-reloading for development
- ✅ Environment variables configuration

## Setup Instructions

### Using Docker (Recommended)

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd RailSathiBE
   ```

2. Copy environment file:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. Run with Docker Compose:
   ```bash
   docker-compose up --build
   ```

4. Access the application:
   - Main API: http://localhost:8000/rs_microservice/
   - Required endpoint: http://localhost:8000/items/
   - API docs (Swagger): http://localhost:8000/rs_microservice/docs
   - API docs (ReDoc): http://localhost:8000/rs_microservice/redoc
   - Health check: http://localhost:8000/health

### Local Development

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Set up PostgreSQL database

3. Copy and configure environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

4. Run the server:
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

## API Endpoints

### Required Endpoint
- `GET /items/` - List complaints (required for assignment)

### Main API Endpoints
- `GET /rs_microservice/` - Health check
- `GET /rs_microservice/complaint/get/{id}` - Get complaint by ID
- `GET /rs_microservice/complaint/get/date/{date}?mobile_number=1234567890` - Get complaints by date
- `POST /rs_microservice/complaint/add` - Create new complaint
- `PATCH /rs_microservice/complaint/update/{id}` - Update complaint
- `PUT /rs_microservice/complaint/update/{id}` - Replace complaint
- `DELETE /rs_microservice/complaint/delete/{id}` - Delete complaint
- `DELETE /rs_microservice/media/delete/{id}` - Delete media files
- `GET /rs_microservice/train_details/{train_no}` - Get train details
- `GET /health` - Health check

## Docker Features

### ✅ Wait-for-it Script
- Ensures PostgreSQL is ready before starting the FastAPI application
- Prevents connection errors during startup
- Located in `wait-for-it.sh`

### ✅ Swagger Documentation
- Automatic API documentation at `/rs_microservice/docs`
- Interactive API testing interface
- ReDoc alternative at `/rs_microservice/redoc`

### ✅ Hot-reloading
- Code changes are automatically detected
- No need to restart containers for development
- Volume mounting for real-time updates

### ✅ Environment Variables
- Secure configuration management
- Database, email, and app settings
- Easy deployment across environments

## Design Decisions

- **FastAPI Framework**: Chosen for high performance and automatic API documentation
- **PostgreSQL**: Robust relational database for complaint data
- **Docker**: Containerization for easy deployment and development
- **Wait-for-it Script**: Ensures database is ready before starting the application
- **Environment Variables**: Secure configuration management
- **Media Upload**: Support for images and videos with Google Cloud Storage
- **Email Notifications**: Automated alerts for complaint management
- **Hot-reloading**: Development-friendly with automatic code updates

## Database Schema

The application uses the following PostgreSQL tables:
- `rail_sathi_railsathicomplain` - Main complaints table
- `rail_sathi_railsathicomplainmedia` - Media files table
- `user_onboarding_user` - User management
- `user_onboarding_roles` - Role definitions
- `trains_trainaccess` - Train access permissions
- `trains_traindetails` - Train information
- `station_Depot` - Depot information
- `station_division` - Division information
- `station_zone` - Zone information

## Environment Variables

Required environment variables:
- Database configuration (POSTGRES_*)
- Email configuration (MAIL_*)
- Google Cloud Storage (GCS_*)
- App configuration (app_*)

## Development Workflow

1. **Start the application**:
   ```bash
   docker-compose up --build
   ```

2. **Make code changes** - they will be automatically detected

3. **Test endpoints**:
   - http://localhost:8000/items/ (required endpoint)
   - http://localhost:8000/rs_microservice/docs (Swagger docs)

4. **View logs**:
   ```bash
   docker-compose logs -f web
   ```

## Production Deployment

For production, consider:
- Using environment-specific `.env` files
- Setting up proper SSL/TLS
- Configuring proper database backups
- Setting up monitoring and logging
- Using a production-grade WSGI server

## Troubleshooting

### Database Connection Issues
- Ensure PostgreSQL container is healthy
- Check environment variables
- Verify wait-for-it script is working

### Hot-reloading Not Working
- Check volume mounts in docker-compose.yml
- Ensure file permissions are correct
- Restart containers if needed

### API Documentation Not Loading
- Check if FastAPI is running properly
- Verify the docs URLs are correct
- Check for any import errors