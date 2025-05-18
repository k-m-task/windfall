# How to Run the Windfall Backend Application

This comprehensive guide provides detailed instructions for running the Windfall backend application locally without Docker.

> **VS Code Users**: For the easiest setup, see [VS_CODE_SETUP.md](VS_CODE_SETUP.md) for instructions on running directly from VS Code with our pre-configured launch settings.

## Prerequisites

1. **Java Development Kit (JDK) 17 or later**
   - Download and install from [Oracle](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://adoptium.net/)
   - Set the JAVA_HOME environment variable to point to your JDK installation
   - Verify installation: `java -version`

2. **Maven (Optional)**
   - The project includes a Maven wrapper (mvnw), so installing Maven separately is optional
   - If you prefer to use Maven directly, download from [Maven's website](https://maven.apache.org/download.cgi)
   - Verify installation: `mvn -version`

3. **IDE (Recommended)**
   - [IntelliJ IDEA](https://www.jetbrains.com/idea/) (Community Edition is free)
   - [Eclipse](https://www.eclipse.org/downloads/) with Spring Tools
   - [VS Code](https://code.visualstudio.com/) with Java extensions

## Running the Application

### Option 1: Using the Run Scripts (Easiest)

We've provided convenient scripts to run the application with various options:

**Windows:**
```bash
# Navigate to the backend directory
cd backend

# Run with default settings (H2 database, port 8080)
run.bat

# Run with MySQL database
run.bat --mysql

# Run on a different port
run.bat --port 8081

# Run in debug mode
run.bat --debug

# Combine options
run.bat --mysql --port 8081 --debug
```

**Linux/Mac:**
```bash
# Navigate to the backend directory
cd backend

# Make the script executable (first time only)
chmod +x run.sh

# Run with default settings (H2 database, port 8080)
./run.sh

# Run with MySQL database
./run.sh --mysql

# Run on a different port
./run.sh --port 8081

# Run in debug mode
./run.sh --debug

# Combine options
./run.sh --mysql --port 8081 --debug
```

### Option 2: Using Maven Wrapper

```bash
# Navigate to the backend directory
cd backend

# Run the application
./mvnw spring-boot:run    # On Linux/Mac
# OR
./mvnw.cmd spring-boot:run  # On Windows
```

### Option 3: Using Maven (if installed)

```bash
# Navigate to the backend directory
cd backend

# Run the application
mvn spring-boot:run
```

### Option 4: Build and Run the JAR

```bash
# Navigate to the backend directory
cd backend

# Build the application
./mvnw package -DskipTests    # On Linux/Mac
# OR
mvnw.cmd package -DskipTests  # On Windows

# Run the JAR
java -jar target/backend-0.0.1-SNAPSHOT.jar
```

### Option 5: Using an IDE

1. **IntelliJ IDEA**:
   - Open the backend directory as a Maven project
   - Locate the `BackendApplication.java` file
   - Right-click and select "Run BackendApplication"

2. **Eclipse**:
   - Import the backend directory as a Maven project
   - Locate the `BackendApplication.java` file
   - Right-click and select "Run As > Java Application"

3. **VS Code**:
   - Open the backend directory
   - Install Java extensions if prompted
   - Locate the `BackendApplication.java` file
   - Click the "Run" button above the main method

## Accessing the Application

Once the application is running:

1. **API Endpoint**: http://localhost:8080/api/hello
2. **H2 Console**: http://localhost:8080/h2-console
   - JDBC URL: `jdbc:h2:mem:windfall`
   - Username: `sa`
   - Password: `password`

## Database Configuration

### H2 In-Memory Database (Default)

By default, the application is configured to use an H2 in-memory database, which means:

1. No external database is required
2. Data will be lost when the application is stopped
3. The database is accessible via the H2 console for debugging

### MySQL Database (Optional)

#### Option 1: Using a Local MySQL Installation

1. **Install MySQL** on your machine:
   - [MySQL Downloads](https://dev.mysql.com/downloads/mysql/)
   - [MySQL Installer Guide](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)

2. **Create a database and user**:
   ```sql
   CREATE DATABASE windfall;
   CREATE USER 'windfall'@'localhost' IDENTIFIED BY 'windfall';
   GRANT ALL PRIVILEGES ON windfall.* TO 'windfall'@'localhost';
   FLUSH PRIVILEGES;
   ```

3. **Run the application with MySQL profile**:
   ```bash
   # Using Maven Wrapper
   ./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
   # OR
   mvnw.cmd spring-boot:run -Dspring-boot.run.profiles=mysql
   
   # Using Maven
   mvn spring-boot:run -Dspring-boot.run.profiles=mysql
   
   # Using Java
   java -jar target/backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=mysql
   ```

#### Option 2: Using Docker for MySQL Only

If you want to use Docker just for the database:

1. Start the MySQL container:
   ```bash
   docker-compose --profile backend-mysql up -d mysql
   ```

2. Run the application with MySQL profile:
   ```bash
   ./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql
   ```

The MySQL configuration is defined in `application-mysql.properties` and is set up to connect to a MySQL instance running on localhost:3306.

## Development Features

### Hot Reloading

The application includes Spring Boot DevTools, which enables hot reloading. When you make changes to your code, the application will automatically restart.

### Debugging

To run the application in debug mode:

```bash
# Using Maven Wrapper
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000"
```

Then connect your IDE debugger to port 8000.

### Running Tests

```bash
# Run all tests
./mvnw test

# Run a specific test class
./mvnw test -Dtest=BackendApplicationTests
```

### Profiles and Configuration

You can customize the application behavior using profiles:

```bash
# Run with a specific profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev

# Override properties
./mvnw spring-boot:run -Dserver.port=8081
```

## Troubleshooting

### JAVA_HOME Not Set

If you see an error like:
```
The JAVA_HOME environment variable is not defined correctly,
this environment variable is needed to run this program.
```

Set the JAVA_HOME environment variable:

**Windows:**
```
set JAVA_HOME=C:\Path\To\Your\JDK
```

**Linux/Mac:**
```
export JAVA_HOME=/path/to/your/jdk
```

### Port Already in Use

If port 8080 is already in use, you can change the port:

```bash
# Using Maven Wrapper
./mvnw spring-boot:run -Dserver.port=8081

# Using Java
java -jar target/backend-0.0.1-SNAPSHOT.jar --server.port=8081
```

### Database Connection Issues

If you're having trouble connecting to MySQL:

1. Verify MySQL is running: `mysql --version`
2. Check connection: `mysql -u windfall -pwindfall -h localhost windfall`
3. Verify port: MySQL typically runs on port 3306
