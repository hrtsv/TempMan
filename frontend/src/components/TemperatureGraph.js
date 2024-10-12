import React, { useState, useEffect } from 'react';
import { Line } from 'react-chartjs-2';

const TemperatureGraph = () => {
  const [temperatures, setTemperatures] = useState({});

  useEffect(() => {
    const fetchData = async () => {
      const response = await fetch('http://localhost:8000/temperatures');
      const data = await response.json();
      setTemperatures(data);
    };

    fetchData();
    const interval = setInterval(fetchData, 5000);

    return () => clearInterval(interval);
  }, []);

  const data = {
    labels: Object.keys(temperatures),
    datasets: [{
      label: 'Temperature',
      data: Object.values(temperatures),
      fill: false,
      borderColor: 'rgb(75, 192, 192)',
      tension: 0.1
    }]
  };

  return <Line data={data} />;
};

export default TemperatureGraph;
