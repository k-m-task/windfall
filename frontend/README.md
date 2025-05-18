# Windfall Frontend

This is the React frontend for the Windfall application. It's designed to work with the Spring Boot backend located in the `/backend` directory.

## Integration with Backend

The frontend is configured to communicate with the backend API in the following ways:

1. **Proxy Configuration**: The `package.json` includes a proxy setting that forwards API requests to the backend server running on port 8080.
   ```json
   "proxy": "http://localhost:8080"
   ```

2. **API Communication**: The application uses Axios to make HTTP requests to the backend API endpoints.

3. **CORS Support**: The backend has been configured with CORS settings to allow requests from the frontend running on localhost:3000.

## Available Scripts

In the project directory, you can run:

### `yarn start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `yarn test`

Launches the test runner in the interactive watch mode.

### `yarn build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

## VS Code Run Configurations

Several VS Code run configurations have been set up to make development easier:

1. **Frontend: Start React App** - Starts the React development server on port 3000.

2. **Frontend: Launch Chrome** - Opens Chrome and navigates to the React app.

3. **Full Stack: Backend (H2) + Frontend** - Starts both the backend (using H2 in-memory database) and frontend servers together.

4. **Full Stack: Backend (MySQL) + Frontend** - Starts both the backend (using MySQL database) and frontend servers together.

## Development Workflow

1. Start the backend server using one of the Spring Boot run configurations or the "Start Backend (H2)" or "Start Backend (MySQL)" task.

2. Start the frontend development server using `yarn start` or the "Frontend: Start React App" run configuration.

3. The frontend will automatically connect to the backend API at http://localhost:8080.

4. Any changes to the frontend code will trigger a hot reload of the application.

## Backend API Endpoints

The backend provides the following API endpoints:

- `GET /api/hello` - Returns a simple JSON response with a message, status, and timestamp.

## Troubleshooting

If you encounter connection issues between the frontend and backend:

1. Ensure the backend server is running on port 8080.
2. Check the browser console for any CORS-related errors.
3. Verify that the proxy setting in package.json is correctly set to "http://localhost:8080".
4. Restart both the frontend and backend servers if necessary.
