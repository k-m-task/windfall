# Docker Usage Guide for Windfall Project

This document explains how to use Docker and Docker Compose with the Windfall project, particularly focusing on running specific services without running the entire stack.

## Prerequisites

- Docker and Docker Compose installed on your system
- Basic understanding of Docker commands

## Using Profiles in Docker Compose

The `docker-compose.yml` file has been configured with profiles to allow you to run specific services or combinations of services. The available profiles are:

- `backend-mysql`: Runs the MySQL database and Spring Boot backend with MySQL
- `backend-h2`: Runs only the Spring Boot backend with H2 in-memory database
- `full-stack`: Runs the entire stack (MySQL, backend, and frontend)

## Running Specific Services

### Running the Backend with MySQL

To run the MySQL database and the Spring Boot backend with MySQL:

```bash
docker-compose --profile backend-mysql up
```

This will start both the MySQL and backend-mysql containers. The backend will be accessible at `localhost:8080`.

### Running the Backend with H2

To run just the Spring Boot backend with the H2 in-memory database:

```bash
docker-compose --profile backend-h2 up
```

This will start only the backend-h2 container. The backend will be accessible at `localhost:8080`.

### Running the Full Stack

To run the entire stack (MySQL, backend, and frontend):

```bash
docker-compose --profile full-stack up
```

This will start all containers. The frontend will be accessible at `localhost:80`.

## Building and Running

If you need to rebuild the images before starting the containers:

```bash
docker-compose --profile <profile> build
docker-compose --profile <profile> up
```

Or in a single command:

```bash
docker-compose --profile <profile> up --build
```

## Running in Detached Mode

To run containers in the background (detached mode):

```bash
docker-compose --profile <profile> up -d
```

## Stopping Services

To stop all running containers:

```bash
docker-compose down
```

To stop and remove volumes (this will delete all data in the MySQL database):

```bash
docker-compose down -v
```

## Viewing Logs

To view logs from all containers:

```bash
docker-compose logs
```

To follow logs in real-time:

```bash
docker-compose logs -f
```

To view logs for a specific service:

```bash
docker-compose logs <service_name>
# For example:
docker-compose logs backend-mysql
# OR
docker-compose logs backend-h2
```

## Connecting to the MySQL Database

When running the MySQL container, you can connect to it using the following credentials:

- Host: `localhost` (or `mysql` from other containers)
- Port: `3306`
- Database: `windfall`
- Username: `windfall`
- Password: `windfall`
- Root Password: `rootpassword`
