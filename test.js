var https = require('https');
var fs = require('fs');


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
download(`https://russellthackston.me/etl/sensordata_${year}_${month}_${day}_${hour}.csv`, 'file.csv')

const csvFilePath='file.csv'
const csv=require('csvtojson')
csv()
.fromFile(csvFilePath)
.then((jsonObj)=>{
    console.log(jsonObj);
    /**
     * [
     * 	{a:"1", b:"2", c:"3"},
     * 	{a:"4", b:"5". c:"6"}
     * ]
     */
})

// Async / await usage
const jsonArray=await csv().fromFile(csvFilePath);
