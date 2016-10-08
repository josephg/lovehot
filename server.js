const express = require('express');
const http = require('http');
const app = express();

// Poor man's logger.
app.use((req, res, next) => {
  console.log('Got request for', req.url);
  next()
})

app.get('/', (req, res) => {
  res.send('Oh hai')
})

app.get('/wait', (req, res) => {
})

app.get('/contents', (req, res, next) => {
  const separator = 'XXXXXXXXXASLDKJFLFASKD';
  res.setHeader('x-sep', separator)
  bundleTo(res, separator, err => {
    if (err) return next(err);
    res.end();
  });
});

http.createServer(app).listen(2000);
console.log('listening on port 2000')

function bundleTo(stream, separator, callback) {
  const recursive = require('recursive-readdir');
  const fs = require('fs');
  
  recursive('payload', ['.*.swp', '*.lnk'], (err, files) => {
    if (err) return callback(err);

    var work = files.length;
    files.forEach(filename => {
      fs.readFile(filename, (err, contents) => {
        if (err) throw err;
        // Remove the directory from the start of the filename
        const trimmedfn = filename.split('/').slice(1).join('/');

        stream.write(`${separator} ${trimmedfn}\n`);
        stream.write(contents);
        stream.write('\n');
        if (--work === 0) callback();
      });
    });
  });
}

