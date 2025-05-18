# Running Windfall Locally Without Docker

This guide provides simple instructions for running the Windfall application locally without Docker.

> **VS Code Users**: For the easiest setup, see [backend/VS_CODE_SETUP.md](backend/VS_CODE_SETUP.md) for instructions on running directly from VS Code with our pre-configured launch settings.

## Quick Start

### Running the Backend

1. **Prerequisites**:
   - Java 17 or later
   - Maven (optional)

2. **Start the backend with H2 database (simplest option)**:
   ```bash
   cd backend
   ./mvnw spring-boot:run    # On Linux/Mac
   # OR
   mvnw.cmd spring-boot:run  # On Windows
   ```

   The backend will be available at http://localhost:8080

3. **Test the API**:
   - Visit http://localhost:8080/api/hello in your browser
   - You should see a JSON response

4. **Access the H2 Console** (for database inspection):
   - Visit http://localhost:8080/h2-console
   - JDBC URL: `jdbc:h2:mem:windfall`
   - Username: `sa`
   - Password: `password`

### Setting Up the Frontend (when ready)

1. **Prerequisites**:
   - Node.js and npm (or yarn)

2. **Create and start the React application**:
   ```bash
   # If you haven't created the React app yet
   npx create-react-app frontend
   # OR
   yarn create react-app frontend

   # Start the development server
   cd frontend
   npm start
   # OR
   yarn start
   ```

   The frontend will be available at http://localhost:3000

## Development Tips

### Backend Hot Reload

The Spring Boot application includes DevTools which enables hot reloading. When you make changes to your code, the application will automatically restart.

### Using an IDE

For the best development experience, consider using an IDE:

- **IntelliJ IDEA**: Open the backend directory as a Maven project
- **Eclipse**: Import the backend directory as a Maven project
- **VS Code**: Open the project root and install Java extensions

### Debugging

To run the backend in debug mode:

```bash
cd backend
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000"
```

Then connect your IDE debugger to port 8000.

## Using a Local MySQL Database (Optional)

If you prefer to use MySQL instead of the in-memory H2 database:

1. **Install MySQL** on your machine
2. **Create a database and user**:
   ```sql
   CREATE DATABASE windfall;
   CREATE USER 'windfall'@'localhost' IDENTIFIED BY 'windfall';
   GRANT ALL PRIVILEGES ON windfall.* TO 'windfall'@'localhost';
   FLUSH PRIVILEGES;
   ```

3. **Run the backend with MySQL profile**:
   ```bash
   cd backend
   ./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
   ```

## Troubleshooting

### Port Already in Use

If port 8080 is already in use, you can change the port:

```bash
cd backend
./mvnw spring-boot:run -Dserver.port=8081
```

### JAVA_HOME Not Set

If you see a JAVA_HOME error:

**Windows**:
```
set JAVA_HOME=C:\Path\To\Your\JDK
```

**Linux/Mac**:
```
export JAVA_HOME=/path/to/your/jdk
```

## Next Steps

Once your application is running locally, you can:

1. Develop new features
2. Run tests: `./mvnw test`
3. Build a JAR file: `./mvnw package`
