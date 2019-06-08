// from data.js
var tableData = data;

//the reference to the table body
var tbody = d3.select("tbody");

 //Load empty table onto page
tableData.forEach(function(sighting) {
    var row = tbody.append("tr");
    Object.entries(sighting).forEach(function ([key, value]) {
      var cell = row.append("td");
      cell.text(value);
    });
})

//button variable to attach to the handlClick function
var button = d3.select("#filter-btn");

// create a function to handle the click/input
button.on("click", function() {

    d3.event.preventDefault();

    //console log the click
    console.log("Button has been clicked. ");

     //select the input element and get the raw HTML node
     var inputElement = d3.select("#datetime");

     //get the value property of the input element
     var inputValue = inputElement.property("value");

     console.log(inputValue);

     //filter the data by the value property of the input element
     var filteredData = tableData.filter(ufo => ufo.datetime === inputValue);

      //Clear previous output
      tbody.html("");

     //load the filtered data into a table on the page
     filteredData.forEach((function(sighting) {
         var row = tbody.append("tr");
         Object.entries(sighting).forEach(function([key, value]) {
           var cell = row.append("td");
           cell.text(value);
         });
     }));
})

 

