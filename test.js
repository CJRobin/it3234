var https = require('https');
var fs = require('fs');
var request=require('request');
const Json2csvParser = require('json2csv').Parser;

var download = function(url, dest, cb) {
  var file = fs.createWriteStream(dest);
  var request = https.get(url, function(response) {
    response.pipe(file);
    file.on('finish', function() {
      file.close(cb);  // close() is async, call cb after close completes.
    });
  }).on('error', function(err) { // Handle errors
    fs.unlink(dest); // Delete the file async. (But we don't check the result)
    if (cb) cb(err.message);
  });
}
let items = []
const date = new Date();
let year = date.getFullYear();
let month = date.getMonth()+1;
let day = date.getDate();
let hour = date.getHours();
month = month < 10 ? month = "0"+ month : month;
if(hour < 10) {
  hour = "0"+ hour;
}
if(day < 10) {
  day = "0"+ day;
}
download(`https://russellthackston.me/etl/sensordata_${year}_${month}_${day}_${hour}.csv`, 'file.csv', function() {
  const csvFilePath='file.csv'
  const csv=require('csvtojson')
  csv()
  .fromFile(csvFilePath)
  .then((json)=>{
      console.log(json);
      for (i=0; i < json.length; i++) {
        if(json[i]['battery charge'] < 5) {
          items.push(json[i]);
        }
      }
      const fields = ['type', 'id', 'name', 'battery charge']
      const json2csvParser = new Json2csvParser({ fields });
      const csv = json2csvParser.parse(items);
      console.log(csv);
      fs.writeFile(`sensordata_${year}_${month}_${day}_${date.getUTCHours()}.csv`, csv, function(err) {
          if(err) {
              return console.log(err);
          }
          const options = {
              method: "POST",
              url: "https://russellthackston.me/etl-drop/index.php",
              port: 443,
              headers: {
                  "Authorization": "9b03bce9b78c54c0d2c5882ebee645b0",
                  "Content-Type": "multipart/form-data"
              },
              formData : {
                  "file" : fs.createReadStream(`sensordata_${year}_${month}_${day}_${date.getUTCHours()}.csv`)
              }
          };

          request(options, function (err, res, body) {
              if(err) console.log(err);
              console.log(body);
          });

      });

  });
});
