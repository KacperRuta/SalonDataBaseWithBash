#! /bin/bash
PSQL="psql --username=postgres --dbname=salon -t --no-align -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

echo -e "\nWelcome to My Salon, how can I help you?\n"

SERVICE_NAMES=$($PSQL "SELECT name FROM services ORDER BY service_id;")
MAIN_MENU() {
  COUNT=1
  while IFS= read -r SERVICE; do
    echo "$COUNT) $SERVICE"
    ((COUNT++))
  done <<< "$SERVICE_NAMES"

  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) ;;
    2) ;;
    3) ;;
    4) ;;
    5) ;;
    *) echo -e "\nI could not find that service. What would you like today?"; MAIN_MENU  ;;
  esac
}

TIME_CHOSING() {
  echo -e "\nWhat time would you like your $($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED"), $CUSTOMER_NAME?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  $PSQL "INSERT INTO appointments(name, time, customer_id, service_id) VALUES('$CUSTOMER_NAME','$SERVICE_TIME',$CUSTOMER_ID,$SERVICE_ID_SELECTED)" > /dev/null
}

GETTING_NAME() {
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  $PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')" > /dev/null
  TIME_CHOSING
}

PHONE_CHECKING() {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  DB_VALUE=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ $DB_VALUE == $CUSTOMER_PHONE ]]
  then
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    TIME_CHOSING
  else
    GETTING_NAME
  fi
}


MAIN_MENU
PHONE_CHECKING

echo -e "\nI have put you down for a $($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED") at $SERVICE_TIME, $CUSTOMER_NAME."