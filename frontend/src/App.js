import { useState, useEffect } from 'react';
import axios from 'axios';
import logo from './logo.svg';
import './App.css';

function App() {
  const [backendData, setBackendData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    // Fetch data from the backend API
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await axios.get('/api/hello');
        setBackendData(response.data);
        setError(null);
      } catch (err) {
        setError('Error connecting to backend: ' + err.message);
        console.error('Error fetching data:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        
        <div className="backend-status">
          <h2>Backend Connection Status</h2>
          {loading ? (
            <p>Loading data from backend...</p>
          ) : error ? (
            <div className="error-message">
              <p>{error}</p>
              <p>Make sure the backend server is running on port 8080</p>
            </div>
          ) : (
            <div className="success-message">
              <p>✅ Successfully connected to backend!</p>
              <div className="backend-response">
                <p><strong>Message:</strong> {backendData?.message}</p>
                <p><strong>Status:</strong> {backendData?.status}</p>
                <p><strong>Timestamp:</strong> {new Date(parseInt(backendData?.timestamp)).toLocaleString()}</p>
              </div>
            </div>
          )}
        </div>
        
        <p className="info-text">
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
