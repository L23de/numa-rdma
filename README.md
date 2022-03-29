# CSE 241 - Database Systems & Applications

Semester-long project for Lehigh's Spring 2022 CSE 241 course. The goal is to
design a robust database along with separate interfaces for different access
levels at a fictional company, Northside Uncommons Management of Apartments (NUMA).

## Directory Structure

```dir
.
├── setup.sql                   # Driver script to setup the database relations
├── shutdown.sql                # Script to bring down the entire database
├── triggers/                   # Holds the individual trigger scripts
├── mock/                       # CSV files containing mock data for populating the database
├── Schema.pdf                  # Database Schema Diagram
├── .git/
├── .gitignore
└── README.md                   # You're reading me!
```

## Mock Data

The following schemas were generated using the aid of [Mockaroo](https://www.mockaroo.com/). The cURL command to access the data is also provided. Add `&count=X` to the end of the endpoint to specify # of entries to generate.

- ACH - `https://api.mockaroo.com/api/d8cc21a0`
- Apartment - `https://api.mockaroo.com/api/98cd9330`
- Pay Card - `https://api.mockaroo.com/api/42551840`
- Person - `https://api.mockaroo.com/api/d41211e0`
- Pet - `https://api.mockaroo.com/api/f8298b90`
- Prev Addr - `https://api.mockaroo.com/api/83abf170`
- Property - `https://api.mockaroo.com/api/8ac165c0`
- Renter Info - `https://api.mockaroo.com/api/bce9b270`
- Venmo - `https://api.mockaroo.com/api/5d5a4450`

## Dev Notes

- When a user logins to the system, the system should automatically create a view for that user that only represents the info that they can see. All queries will be used on that
