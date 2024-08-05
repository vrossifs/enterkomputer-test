const http = require('http');
const cluster = require('cluster');
const process = require('process');
const numCPUs = require('os').cpus().length;
const app = require('./src/index');
const tunnel = require('localtunnel');

const port = process.env.PORT || 5555;
const host = 'localhost';
const subdomain = process.env.HOST;

if (cluster.isMaster) {
  console.log(`Primary ${process.pid} is running`);

  // Master process: spawn workers for each CPU core
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
} else {
  // Worker process: run the application
  const server = http.createServer(app);
  server.listen(port, host, () => {
    console.log(`Worker ${process.pid} started. Running server at ${host}:${port}`);

    // Create a localtunnel instance
    tunnel({ port: port, subdomain: subdomain }, (err, tunnel) => {
      if (err) {
        console.error('Error creating localtunnel:', err);
      } else {
        console.log(`Localtunnel open: ${tunnel.url}`);
      }
    });
  })
}