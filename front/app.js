const fetchMetrics = async () => {
  try {
    const response = await fetch('http://localhost:5000/metrics');

    if (!response.ok) {
      throw new Error(`HTTP Error! Status: ${response.status}`);
    }

    const data = await response.json();
    console.log("Received data:", data);

    updateDashboard(data);

  } catch (error) {
    console.error("Error detected:", error);
  } finally {
    setTimeout(fetchMetrics, 10000);
  }
};


const updateDashboard = (data) => {
	document.getElementById('hostname').innerText = data.hostname;
	document.getElementById('cpu-1m').innerText = data.cpu_load["1m"];
	document.getElementById('cpu-5m').innerText = data.cpu_load["5m"];
	document.getElementById('cpu-10m').innerText = data.cpu_load["10m"];
	document.getElementById('ram-used').innerText = data.ram_metrics.used_mo;
	document.getElementById('ram-total').innerText = data.ram_metrics.total_mo;
	document.getElementById('ram-pct').innerText = data.ram_metrics.ratio;
	document.getElementById('disk-available').innerText = data.disk_metrics.available;
	document.getElementById('disk-pct').innerText = data.disk_metrics.use_pct;
}

fetchMetrics();
