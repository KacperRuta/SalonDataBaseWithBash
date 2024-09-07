# SalonDataBaseWithBash

This project provides a simple command-line interface (CLI) for scheduling appointments at a salon. The system interacts with a PostgreSQL database and allows users to choose a service, provide their phone number, and book an appointment for the desired time. The system stores customer information and appointment details in the database.

## Files

- **salon.sql**: This file contains the SQL dump used to create and populate the PostgreSQL database for the salon. It includes tables for services, customers, and appointments.
- **salon.sh**: A Bash script that allows users to schedule appointments interactively. It queries the database, stores customer information if it's a first-time customer, and logs appointments.
- **examples.txt**: Provides example outputs of the working script. It shows the interaction flow between the user and the appointment system.

## How It Works

1. **Service Selection**:
   - Upon running the script, users are greeted with a list of available services pulled from the database.
   - The user selects a service by entering the corresponding number.

2. **Phone Number Check**:
   - The script prompts the user for their phone number.
   - If the phone number exists in the database, the user's name is retrieved, and they can proceed to schedule an appointment.
   - If the phone number does not exist, the system asks for the user's name and stores the new customer in the database.

3. **Booking the Appointment**:
   - The user is asked to provide a time for the appointment.
   - The system saves the appointment details in the database.

4. **Confirmation**:
   - The script confirms the appointment by displaying the service, time, and customer's name.

## How to Run

1. **Ensure you have PostgreSQL installed and a user `postgres` set up.**
2. **Import the database by running the following command:**
   ```bash
   psql --username=postgres --file=salon.sql
3. **Make sure the salon.sh script is executable:**
   ```bash
   chmod +x salon.sh
4. **Run the script:**
   ```bash
   ./salon.sh
   
##Example Interaction

```CSS
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?

1) cut
2) color
3) perm
4) style
5) trim
1

What's your phone number?
555-555-5555

What time would you like your cut, Fabio?
10:30

I have put you down for a cut at 10:30, Fabio.
