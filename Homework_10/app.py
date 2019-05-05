#Dependencies
import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

#Define engine
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to each table
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)

# Design a Flask API based on the queries that you have just developed
from flask import Flask, jsonify

# Use Flask to create your routes per instructions
app = Flask(__name__)

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/station<br/>"
        f"/api/v1.0/<precipiation><br/>"
        f"/api/v1.0/<temperature>"
        f"/apiv1.0/<start_date><end_date>"
    )


@app.route("/api/v1.0/station")
def station():
    """Return a list of all the stations"""
    # Query all stations
    results = session.query(Station.station).all()

    # Convert list of tuples into normal list
    all_stations = list(np.ravel(results))

    return jsonify(all_stations)


@app.route("/api/v1.0/<precipitation>")
def precipitation():
    """Return a list of precipiation data connected to date data"""
    # Query precipitation
    results = session.query(Measurement.prcp, Measurement.date, Measurement.station).all()

    # Create a dictionary from the row data and append to a list of precipitation
    precipitation_list = []
    for date in results:
        pcrp_dict = {}
        prcp_dict["date"] = date
        precipitation_list.append(prcp_dict)

    return jsonify(precipitation)

@app.route("/api/v1.0/<temperature>")
def temperature():
    """Return a list of temperature observation data for the past year"""
    # Query tobs
    results = session.query(Measurement.date, Measurement.tobs).\
                filter(Measurement.date>='2016-08-23').all()

    # Create a dictionary from the row data and append to a list of precipitation
    tobs_list = []
    for date in results:
        temp_dict = {}
        temp_dict["date"] = date
        tobs_list.append(temp_dict)

    return jsonify(temperature)

@app.route("/api/v1.0/<start_date><end_date>")
    

if __name__ == '__main__':
    app.run(debug=True)

