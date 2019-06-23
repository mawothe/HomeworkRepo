//basic formatting variables
var svgWidth = 960;
var svgHeight = 500;

var margin = {
  top: 20,
  right: 40,
  bottom: 60,
  left: 100
};

var width = svgWidth - margin.left - margin.right;
var height = svgHeight - margin.top - margin.bottom;

// Create an SVG wrapper, append an SVG group that will hold our chart, and shift the latter by left and top margins.
var svg = d3.select("#scatter")
  .append("svg")
  .attr("width", svgWidth)
  .attr("height", svgHeight);

var chartGroup = svg.append("g")
  .attr("transform", `translate(${margin.left}, ${margin.top})`);

  console.log("Checkpoint 1");

var censusData = "data.csv";

  console.log("Checkpoint 2");

// Import Data
d3.csv(censusData)
  .then(function(healthData) {
    console.log(healthData);

    // Parse Data and Cast as numbers
    healthData.forEach(function(d) {
      d.age = +d.age;
      d.smokes = +d.smokes;
    });
 
    console.log("Checkpoint 3");
    console.log(healthData[0])

    // Create scale functions
    var xLinearScale = d3.scaleLinear()
      .domain([20, d3.max(healthData, d => d.age)])
      .range([0, width]);

    var yLinearScale = d3.scaleLinear()
      .domain([0, d3.max(healthData, d => d.smokes)])
      .range([height, 0]);

    // Create variables to hold axis functions
    var bottomAxis = d3.axisBottom(xLinearScale);
    var leftAxis = d3.axisLeft(yLinearScale);

    // // Append Axes to the chart
    // chartGroup.append("g")
    //   .attr("transform", `translate(0, ${height})`)
    //   .call(bottomAxis);

    // chartGroup.append("g")
    //   .call(leftAxis);

    // Create the circles to plot data
    chartGroup.selectAll("circle")
    .data(healthData)
    .enter()
    .append("circle")
    .attr("cx", d => xLinearScale(d.age))
    .attr("cy", d => yLinearScale(d.smokes))
    .attr("r", "15")
    .attr("fill", "blue")
    .attr("opacity", ".5")

    //Add the labels of the states to the graph
    chartGroup.selectAll("text")
    .data(healthData)
    .enter()
    .append("text")
    .classed("chartText", true)
    .text((d) => d.abbr)
    .attr("x", d => xLinearScale(d.age)-10)
    .attr("y", d => yLinearScale(d.smokes) +5 );

    // Append Axes to the chart
    chartGroup.append("g")
      .attr("transform", `translate(0, ${height})`)
      .call(bottomAxis);

    chartGroup.append("g")
      .call(leftAxis);

  // Create axes labels
  chartGroup.append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 0 - margin.left + 40)
    .attr("x", 0 - (height / 2))
    .attr("dy", "1em")
    .attr("class", "axisText")
    .text(" Percentage (%) of Smokers ");

  chartGroup.append("text")
    .attr("transform", `translate(${width / 2}, ${height + margin.top + 30})`)
    .attr("class", "axisText")
    .text("Age of Residents in States");

  });