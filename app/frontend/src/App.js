import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [ipmiData, setIpmiData] = useState(null);
  const [nvidiaSmiData, setNvidiaSmiData] = useState(null);
  const [token, setToken] = useState(null);
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const login = async () => {
    try {
      const response = await axios.post('/login', { username, password });
      setToken(response.data.access_token);
    } catch (error) {
      console.error('Login failed:', error);
    }
  };

  const fetchData = async () => {
    if (!token) return;

    const config = {
      headers: { Authorization: `Bearer ${token}` }
    };

    try {
      const ipmiResponse = await axios.get('/ipmi', config);
      setIpmiData(ipmiResponse.data);

      const nvidiaSmiResponse = await axios.get('/nvidia_smi', config);
      setNvidiaSmiData(nvidiaSmiResponse.data);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  useEffect(() => {
    if (token) {
      fetchData();
    }
  }, [token]);

  return (
    <div className="App">
      <h1>IPMI and NVIDIA SMI Dashboard</h1>
      {!token ? (
        <div>
          <input
            type="text"
            placeholder="Username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
          <input
            type="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <button onClick={login}>Login</button>
        </div>
      ) : (
        <div>
          <h2>IPMI Data</h2>
          <pre>{JSON.stringify(ipmiData, null, 2)}</pre>
          <h2>NVIDIA SMI Data</h2>
          <pre>{JSON.stringify(nvidiaSmiData, null, 2)}</pre>
        </div>
      )}
    </div>
  );
}

export default App;
