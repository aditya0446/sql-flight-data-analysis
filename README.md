# SQL Flight Data Analysis Project

## Overview

This project showcases a SQL-based relational database for flight data analysis, including schema design, sample data, and advanced business queries.

**Key Features:**
- Relational schema covering airports, airlines, flights, tickets, passengers
- Sample data for realistic analysis scenarios
- Analytical queries: busiest airports, top airlines, passenger activity, ticket sales, and more

## Entity Relationship Diagram
<img width="1449" height="737" alt="ER-Diagram" src="https://github.com/user-attachments/assets/4f82672f-62b7-4235-bf13-cd138e4b12e6" />


*The above ER diagram illustrates the relationships among tables. Each flight is associated with airports and airlines; tickets link passengers and flights.*

## Database Tables

- **Airports:** Details of airports (ID, name, location, country)
- **Airlines:** Details of airlines (ID, name, country)
- **Flights:** Flight schedules, origin/destination, airline, times
- **Passengers:** Passenger personal info and frequent flyer status
- **Tickets:** Ticket purchases, price, flight, passenger

## Example Analysis Queries

- Find the busiest airport by take-offs
- Count tickets sold per airline
- List flights operated by a specific airline
- Top airline for each airport by departures
- Flight durations and categories
- Passenger flight history (first/last, total flights)
- Highest-priced ticket per route
- Top spending passengers by status
