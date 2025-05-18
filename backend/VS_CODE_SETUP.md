# Running Windfall Backend in VS Code

This guide provides instructions for running and developing the Windfall backend application directly in VS Code without using Docker or command-line scripts.

## Required Extensions

We've included an `extensions.json` file that will automatically prompt you to install the recommended extensions when you open the project in VS Code. Click "Install" when prompted.

If you don't see the prompt, you can install these extensions manually:

1. **Java Extension Pack** - Includes:
   - Language Support for Java
   - Debugger for Java
   - Java Test Runner
   - Maven for Java
   - Project Manager for Java

2. **Spring Boot Extension Pack** - Includes:
   - Spring Boot Tools
   - Spring Initializr Java Support
   - Spring Boot Dashboard

3. **Additional Helpful Extensions**:
   - Lombok Annotations Support

## Running the Application

We've provided several launch configurations to make it easy to run the application with different settings:

1. Open the VS Code Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P`)
2. Type "Run" and select "Run and Debug"
3. Select one of the following configurations from the dropdown:

- **Spring Boot (H2 Database)** - Runs with the default in-memory H2 database
- **Spring Boot (MySQL Database)** - Runs with MySQL (see MySQL setup below)
- **Spring Boot (Debug Mode)** - Runs with Java debugging enabled
- **Spring Boot (Custom Port 8081)** - Runs on port 8081 instead of 8080
- **Spring Boot (MySQL + Debug)** - Runs with both MySQL and debugging enabled

Alternatively, you can:
- Click the "Run and Debug" icon in the sidebar
- Select a configuration from the dropdown at the top of the Run and Debug view
- Click the green play button

### MySQL Setup for Running with MySQL Database

Before using the MySQL configurations, you need to have MySQL running:

#### Option 1: Using Docker for MySQL Only

```bash
# Start just the MySQL container
docker-compose --profile backend-mysql up -d mysql
```

#### Option 2: Using a Local MySQL Installation

1. Install MySQL on your machine
2. Create the database and user:
   ```sql
   CREATE DATABASE windfall;
   CREATE USER 'windfall'@'localhost' IDENTIFIED BY 'windfall';
   GRANT ALL PRIVILEGES ON windfall.* TO 'windfall'@'localhost';
   FLUSH PRIVILEGES;
   ```
3. Start the MySQL service

The MySQL connection settings are defined in `application-mysql.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/windfall
spring.datasource.username=windfall
spring.datasource.password=windfall
```

## Using Spring Boot Dashboard

The Spring Boot Dashboard provides a convenient way to manage your Spring Boot applications:

1. Click the Spring Boot icon in the sidebar
2. You'll see your application listed in the dashboard
3. Right-click on the application to:
   - Start
   - Debug
   - Stop
   - Open in Browser

## Accessing the Application

Once the application is running:

1. **API Endpoint**: http://localhost:8080/api/hello
2. **H2 Console** (when using H2 database): http://localhost:8080/h2-console
   - JDBC URL: `jdbc:h2:mem:windfall`
   - Username: `sa`
   - Password: `password`

## Debugging

When running with a debug configuration:

1. Set breakpoints by clicking in the gutter (left margin) of your code
2. The application will pause when execution reaches a breakpoint
3. Use the debug toolbar to:
   - Continue (F5)
   - Step Over (F10)
   - Step Into (F11)
   - Step Out (Shift+F11)
   - Restart
   - Stop

## Viewing Logs

The application logs will appear in the "Debug Console" panel at the bottom of VS Code.

## Customizing Launch Configurations

If you need to customize the launch configurations:

1. Open `.vscode/launch.json`
2. Modify existing configurations or add new ones
3. Save the file

## Recommended VS Code Settings

We've provided a `.vscode/settings.json` file with recommended settings for Java and Spring Boot development. These settings enable:

- Automatic import organization
- Format on save
- Spring Boot-specific features
- Java code analysis

## Troubleshooting

### Java Home Not Found

If VS Code can't find your Java installation:

1. Open Settings (`Ctrl+,` or `Cmd+,`)
2. Search for "java.home"
3. Set it to your JDK installation path

### Port Already in Use

If port 8080 is already in use:

1. Use the "Spring Boot (Custom Port 8081)" launch configuration
2. Or modify the port in an existing configuration

### MySQL Connection Issues

If you're having trouble connecting to MySQL:

1. Make sure MySQL is running:
   - If using Docker: `docker ps` to check if the container is running
   - If using local MySQL: Check your system's service manager

2. Verify the database exists:
   - Connect to MySQL: `mysql -u windfall -pwindfall`
   - List databases: `SHOW DATABASES;`
   - If 'windfall' is not listed, create it: `CREATE DATABASE windfall;`

3. Check connection details in `application-mysql.properties`:
   - Verify the URL is correct: `jdbc:mysql://localhost:3306/windfall`
   - Confirm username and password match your MySQL setup

4. Test the connection with a MySQL client:
   - MySQL Workbench
   - Command line: `mysql -u windfall -pwindfall -h localhost windfall`
   - Or any other database client tool

5. Common errors:
   - "Communications link failure": MySQL is not running or port is blocked
   - "Access denied": Incorrect username or password
   - "Unknown database": Database 'windfall' doesn't exist
   - "Public Key Retrieval is not allowed": Add `allowPublicKeyRetrieval=true` to the connection URL
