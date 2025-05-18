# Windfall

A monorepo project with a React frontend and Spring Boot backend, designed for deployment using Docker and Kubernetes.

## Project Structure

```
windfall/
├── README.md
├── docker-compose.yml
├── kubernetes/
│   ├── frontend-deployment.yaml
│   ├── backend-deployment.yaml
│   ├── mysql-deployment.yaml
│   └── ingress.yaml
├── frontend/
│   ├── public/
│   ├── src/
│   ├── package.json
│   ├── Dockerfile
│   └── ...
├── backend/
│   ├── src/
│   ├── pom.xml
│   ├── Dockerfile
│   └── ...
└── .github/
    └── workflows/
        └── ci-cd.yml (optional)
```

## Technology Stack

### Frontend
- React 18
- React Context API for state management
- Material-UI for UI components
- React Router for routing
- Vite for build tooling
- Yarn for package management

### Backend
- Spring Boot 3.x
- Maven for build management
- MySQL 8.0 for database
- Spring Data JPA for data access
- Spring Security with JWT for authentication

### Infrastructure
- Docker for containerization
- Kubernetes for orchestration
- GitHub Actions for CI/CD (optional)

## Development Setup

### Prerequisites
- Node.js and Yarn
- Java 17+ and Maven
- Docker and Docker Compose
- kubectl for Kubernetes deployment

### Local Development

#### Option 1: Using VS Code (Recommended for Development)

1. Clone the repository
2. Open the project in VS Code
3. Install recommended extensions:
   - Java Extension Pack
   - Spring Boot Extension Pack
4. Start the backend:
   - Open the Run and Debug view (Ctrl+Shift+D or Cmd+Shift+D)
   - Select a launch configuration (e.g., "Spring Boot (H2 Database)")
   - Click the green play button
5. Start the frontend (when ready):
   ```bash
   cd frontend
   yarn dev
   ```

See [backend/VS_CODE_SETUP.md](backend/VS_CODE_SETUP.md) for detailed VS Code setup instructions.

#### Option 2: Using Command Line Scripts

1. Clone the repository
2. Start the backend:
   ```bash
   # Windows
   cd backend
   run.bat
   
   # Linux/Mac
   cd backend
   ./run.sh
   ```
   
   For more options:
   ```bash
   # Windows
   run.bat --mysql --port 8081 --debug
   
   # Linux/Mac
   ./run.sh --mysql --port 8081 --debug
   ```

See [RUN_LOCALLY.md](RUN_LOCALLY.md) for detailed command-line instructions.

#### Option 2: Using Docker Compose

```bash
# Run everything
docker-compose --profile full-stack up

# Run just the backend with MySQL
docker-compose --profile backend-mysql up

# Run just the backend with H2
docker-compose --profile backend-h2 up
```

See [DOCKER_USAGE.md](DOCKER_USAGE.md) for more Docker options.

### Deployment
1. Build Docker images: `docker-compose build`
2. Deploy to Kubernetes: `kubectl apply -f kubernetes/`

## License
[MIT](LICENSE)
