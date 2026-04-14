const https = require('https');
const fs = require('fs');
const path = require('path');

// Replace with the actual S3 URL for your report
const reportUrl = 'https://datalake-cbmc-revillagigedo.s3.amazonaws.com/revillagigedo_dashboard/revillagigedo_report_es.html'; 
const outputDir = path.join(__dirname, 'static', 'reports');
const outputFile = path.join(outputDir, 'revillagigedo_report_es.html');

// Ensure the directory exists
fs.mkdirSync(outputDir, { recursive: true });

https.get(reportUrl, (res) => {
  if (res.statusCode !== 200) {
    console.error(`Failed to fetch report: ${res.statusCode}`);
    return;
  }
  const fileStream = fs.createWriteStream(outputFile);
  res.pipe(fileStream);
  fileStream.on('finish', () => {
    fileStream.close();
    console.log('Report downloaded successfully.');
  });
}).on('error', (err) => {
  console.error('Error fetching report:', err);
});